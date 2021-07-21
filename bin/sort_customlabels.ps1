#!/usr/bin/env pwsh
#Requires -Version 5

param (
    $customLabelsPath
)

# "strict mode" best practice
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Set a default value for $customLabelsPath if it was not passed in as parameter on the command line
if (-Not $customLabelsPath) {
    $projectRoot = (Resolve-Path -LiteralPath "$PSScriptRoot/..").Path
    $customLabelsPath = "$projectRoot/client-app/common-core/labels/CustomLabels.labels-meta.xml"
}
if (-Not (Test-Path $customLabelsPath)) {
    throw "CustomLabels file does not exist: $customLabelsPath"
}

# Load CustomLabels xml, uniquely sort nodes by fullName, and save
$xmlDoc = [xml](Get-Content $customLabelsPath)
$xmlDoc.CustomLabels.labels | ForEach-Object {
    $null = $xmlDoc.CustomLabels.RemoveChild($_)
    Write-Output $_
} | Sort-Object -Unique { $_.fullName } | ForEach-Object {
    $null = $xmlDoc.CustomLabels.AppendChild($_)
}
$xmlDoc.Save($customLabelsPath)
"Sorting complete: $customLabelsPath"
