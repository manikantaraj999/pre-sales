#!/usr/bin/env pwsh
#Requires -Version 5

param (
    $PackageDir = "./.tmp/mdapi-src"
)

# "strict mode" best practice
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Replace wildcard * CustomLabel in package.xml with actual custom label names
$LabelNames = ([xml](Get-Content $PackageDir/labels/CustomLabels.labels)).CustomLabels.labels.fullName | Sort-Object -Unique
Write-Output $LabelNames
$packageXmlPath = (Resolve-Path -LiteralPath "$PackageDir/package.xml").Path
$xmlDoc = [xml](Get-Content $packageXmlPath)
$customLabelNode = $xmlDoc.Package.types | Where-Object {$_.name -eq 'CustomLabel'}
$customLabelNode.RemoveAll()
$element = $xmlDoc.CreateElement('name',$customLabelNode.NamespaceURI)
$element.InnerText='CustomLabel'
$null = $customLabelNode.AppendChild($element)
$LabelNames | ForEach-Object {
  $element = $xmlDoc.CreateElement('members',$customLabelNode.NamespaceURI)
  $element.InnerText = $_
  $null = $customLabelNode.AppendChild($element)
}
$xmlDoc.Save($packageXmlPath)
