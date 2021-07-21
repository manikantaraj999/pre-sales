#!/usr/bin/env pwsh
#Requires -Version 5

[CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
param (
    # Flag -a, -setalias set an sfdx alias for for the created scratch org
    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="set an sfdx alias for for the created scratch org")]
    [Alias("a")]
    [string]
    $SetAlias,

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="set sfdx wait time in minutes")]
    [Alias("w")]
    [int]
    $Wait = 60,

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="path to rebuild-scratch-org configuration file - defaults to ./rebuild-scratch-org.json or {project-root}/config/rebuild-scratch-org-default.json")]
    [Alias("f")]
    [string]
    $RebuildScratchOrgConfigFile,

    # Flag -o, -open opens the scratch org when its complete
    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="open the scratch org when its complete")]
    [Alias("o")]
    [switch]
    $Open,

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="open the scratch org when its complete to this navigation URL path")]
    [Alias("p")]
    [string]
    $OpenUrlPath,

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="duration of the scratch org (in days) (default:7, min:1, max:30)")]
    [Alias("d")]
    [String]
    $DurationDays,

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="username or alias for the dev hub org; overrides default dev hub org")]
    [Alias("v")]
    [String]
    $TargetDevhubUsername,

    [Parameter(Mandatory=$false,
               ValueFromRemainingArguments=$true,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="Package Ids to install (04t)")]
    [String[]]
    $PackageIds
)

# "strict mode" best practice
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

$ImportSfdxWrapperPath = (Resolve-Path (Join-Path $PSScriptRoot "import-sfdx-wrapper.ps1")).Path
. $ImportSfdxWrapperPath

# Load configuration
if (-Not $RebuildScratchOrgConfigFile) {
    if (Test-Path "./rebuild-scratch-org.json") {
        $RebuildScratchOrgConfigFile = "./rebuild-scratch-org.json"
    } else {
        $RebuildScratchOrgConfigFile = "$PSScriptRoot/../config/rebuild-scratch-org-default.json"
    }
}

$Config = @{}
Write-Verbose "Attempting to read rebuild-scratch-org configuration: $RebuildScratchOrgConfigFile"
if (Test-Path $RebuildScratchOrgConfigFile) {
    (Get-Content $RebuildScratchOrgConfigFile | ConvertFrom-Json).psobject.properties | ForEach-Object { $Config[$_.Name] = $_.Value }
    $ConfigFolderPath = Split-Path -Parent (Resolve-Path $RebuildScratchOrgConfigFile)
} else {
    Write-Verbose "Unable to read $RebuildScratchOrgConfigFile"
}

$ScratchOrgDefinitionFile = "$PSScriptRoot/../config/project-scratch-def.json"
if ($Config.ContainsKey("ScratchOrgDefinitionFile")) {
    $ScratchOrgDefinitionFile = Join-Path -Resolve $ConfigFolderPath $Config.ScratchOrgDefinitionFile
}
$ScratchOrgDefinitionFile = (Resolve-Path $ScratchOrgDefinitionFile).Path

$DataRecordCreate = @{}
if ($Config.ContainsKey("DataRecordCreate")) {
    $Config.DataRecordCreate.psobject.properties | ForEach-Object { $DataRecordCreate[$_.Name] = $_.Value }
}

$PermSets = @()
if ($Config.ContainsKey("PermSets")) {
    $PermSets = $Config.PermSets
}

$DataPlans = @()
if ($Config.ContainsKey("DataPlans")) {
    $DataPlans = $Config.DataPlans | ForEach-Object {
        Join-Path -Resolve $ConfigFolderPath $_
    }
}

$AnonApexFiles = @()
if ($Config.ContainsKey("AnonApexFiles")) {
    $AnonApexFiles = $Config.AnonApexFiles | ForEach-Object {
        Join-Path -Resolve $ConfigFolderPath $_
    }
}

$MdapiDeployBeforeSfdxSource = @()
if ($Config.ContainsKey("MdapiDeployBeforeSfdxSource")) {
    $MdapiDeployBeforeSfdxSource = $Config.MdapiDeployBeforeSfdxSource
}

$MdapiDeployAfterSfdxSource = @()
if ($Config.ContainsKey("MdapiDeployAfterSfdxSource")) {
    $MdapiDeployAfterSfdxSource = $Config.MdapiDeployAfterSfdxSource
}

# Only obtain OpenUrlPaths from config file when none are specified on the command line
$OpenUrlPaths = @()
if (-Not $OpenUrlPath) {
    if ($Config.ContainsKey("OpenUrlPaths")) {
        $OpenUrlPaths = $Config.OpenUrlPaths
    }
}

# Only obtain PackageIds from config file when none are specified on the command line
if (-Not $PackageIds) {
    if ($Config.ContainsKey("PackageIds")) {
        $PackageIds = $Config.PackageIds
    }
}

# Validate params
if ($PackageIds) {
    $InvalidPackageIds = $PackageIds | ForEach-Object { @($_ -split ':')[0] } | Where-Object { -not ($_.StartsWith('04t') -and (@(15,18) -contains $_.Length)) }
    if ($InvalidPackageIds) {
        throw "ERROR: Unrecognized Package Ids [$InvalidPackageIds] must begin with 04t and have a length of 15 or 18 characters."
    }
}

# Spin up fresh scratch org
if ($ScratchOrgDefinitionFile) {
    $sfdxArgs = @('--wait', $Wait, '--definitionfile', $ScratchOrgDefinitionFile, '--setdefaultusername')
    if ($SetAlias) {
        $sfdxArgs += @("description=$SetAlias", '--setalias', $SetAlias)
    }
    if ($DurationDays) {
        $sfdxArgs += @('--durationdays', $DurationDays)
    }
    if ($TargetDevhubUsername) {
        $sfdxArgs += @('--targetdevhubusername', $TargetDevhubUsername)
    }
    sfdx force:org:create @sfdxArgs
}

# Install packages
if ($PackageIds) {
    $PackageIds | ForEach-Object {
        $id,$key = $_ -split ':'
        $sfdxArgs = @('--noprompt', '--publishwait', $Wait, '--wait', $Wait, '--package', $id)
        if ($key) {
            $key = $key -join ':'
            $sfdxArgs += @('--installationkey', $key)
        }
        sfdx force:package:install @sfdxArgs
    }

    # "sfdx force:package:installed:list" caused build flakiness with non-overridable 2-minute
    # timeout with message: "ERROR:  Your query request was running for too long."
    # Might be able to re-enable if it gains support for a "--wait" parameter
    ## Display installed package versions
    #sfdx force:package:installed:list

}

# Push mdapi source
if ($MdapiDeployBeforeSfdxSource) {
    $MdapiDeployBeforeSfdxSource | ForEach-Object {
        sfdx force:mdapi:deploy --wait $Wait --deploydir $_
    }
}

# Push sfdx source
sfdx force:source:push --forceoverwrite

# Push mdapi source
if ($MdapiDeployAfterSfdxSource) {
    $MdapiDeployAfterSfdxSource | ForEach-Object {
        sfdx force:mdapi:deploy --wait $Wait --deploydir $_
    }
}

# Configure logging and connection settings
if ($DataRecordCreate) {
    $DataRecordCreate.Keys | Sort-Object | ForEach-Object {
        sfdx force:data:record:create --sobjecttype $_ --values $DataRecordCreate[$_]
    }
}

# Assign permission sets per your development / testing needs
if ($PermSets) {
    $PermSets | ForEach-Object {
        sfdx force:user:permset:assign --permsetname $_
    }
}

# Load sample data (Accounts, Wearables Products, a Wearables Price Book, and Pricebook Entries)
# that corresponds to the `enosix_sap_*` SAP connections.
if ($DataPlans) {
    $DataPlans | ForEach-Object {
        sfdx force:data:tree:import --plan $_
    }
}
if ($AnonApexFiles) {
    $AnonApexFiles | ForEach-Object {
        sfdx force:apex:execute --apexcodefile $_
    }
}

if ($OpenUrlPath) {
    sfdx force:org:open --path $OpenUrlPath
} elseif ($Open) {
    if ($OpenUrlPaths) {
        $OpenUrlPaths | ForEach-Object {
            sfdx force:org:open --path $_
        }
    } else {
        sfdx force:org:open
    }
}

Write-Verbose "$SetAlias Scratch org spin cycle complete!"
