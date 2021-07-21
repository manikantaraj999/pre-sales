#!/usr/bin/env pwsh
#Requires -Version 5

[CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
param (
    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="comma-separated list of paths to the local source files to convert")]
    [Alias("p")]
    [String]
    $SourcePath,

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="'-Like' filter for choosing source paths from sfdx-project.json when SourcePath is not specifiec")]
    [String]
    $SfdxProjectPathLike = "*/client-app/*",

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="directory to store the Metadata API formatted files in")]
    [Alias("d")]
    [String]
    $PackageDir = "./.tmp/mdapi-src",

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="set an sfdx alias for for the created scratch org")]
    [Alias("u")]
    [string]
    $TargetUsername,

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
               HelpMessage="Force deployment even if errors and warnings")]
    [Alias("f")]
    [Switch]
    $Force,

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="validate deploy but don’t save to the org")]
    [Alias("c")]
    [Switch]
    $CheckOnly,

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="'-Like' filter for choosing Test Class Names, defaults to 'TST*'")]
    [String]
    $TestClassNameLike = 'TST*',

    [Parameter(Mandatory=$false,
               ValueFromPipeline=$true,
               ValueFromPipelineByPropertyName=$true,
               HelpMessage="no test run")]
    [Alias("s")]
    [Switch]
    $SkipTests
)

# "strict mode" best practice
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ImportSfdxWrapperPath = (Resolve-Path (Join-Path $PSScriptRoot "import-sfdx-wrapper.ps1")).Path
. $ImportSfdxWrapperPath

# Deploy and verify test coverage
if (Test-Path $PackageDir) { Remove-Item -Recurse -Force $PackageDir }

$sfdxArgs = @('--outputdir', $PackageDir)
if (-Not $SourcePath) {
    $SourcePath = (
        (Get-Content ./sfdx-project.json | ConvertFrom-Json).packageDirectories.path |
        Where-Object { $_ -Like $SfdxProjectPathLike }
    ) -Join ','
}
$sfdxArgs += @('--sourcepath', $SourcePath)

sfdx force:source:convert @sfdxArgs

$TestClassNames = (
    (
        ([xml](Get-Content $PackageDir/package.xml)).Package.types |
        Where-Object { $_.name -eq 'ApexClass' }
    ).members |
    Where-Object { $_ -Like $TestClassNameLike } |
    Sort-Object
) -Join ','

Write-Verbose '$TestClassNames:'
Write-Output $TestClassNames

$sfdxArgs = @('--wait',$Wait,'--deploydir',$PackageDir)
if ($CheckOnly) {
    $sfdxArgs += @('--checkonly')
} elseif ($Force) {
    $sfdxArgs += @('--ignorewarnings','--ignoreerrors')
}
if ((-not $SkipTests) -and $TestClassNames) {
    $sfdxArgs += @('--testlevel','RunSpecifiedTests','--runtests',$TestClassNames)
}
if ($TargetUsername) {
    $sfdxArgs += @('--targetusername',$TargetUsername)
}

sfdx force:mdapi:deploy @sfdxArgs
