# Usage:
#
#   $ImportSfdxWrapperPath = (Resolve-Path (Join-Path $PSScriptRoot "import-sfdx-wrapper.ps1")).Path
#   . $ImportSfdxWrapperPath

# sfdx wrapper function
$sfdxCmd = Get-Command sfdx | Where-Object { @('Application','ExternalScript') -contains $_.CommandType } | Sort-Object { $_.CommandType } | Select-Object -First 1
function sfdx {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(Mandatory=$false,
        ValueFromRemainingArguments=$true,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        HelpMessage="arguments for sfdx")]
        [String[]]
        $argsForSfdx
    )
    if($PSCmdlet.ShouldProcess("$sfdxCmd $argsForSfdx")) {
        Write-Verbose "Running:   $sfdxCmd $argsForSfdx"
        & $sfdxCmd @argsForSfdx
        Write-Verbose "Finished:  $sfdxCmd $argsForSfdx"
        if ($LASTEXITCODE) {
            throw "[sfdx exit code] $LASTEXITCODE"
        }
    }
}
