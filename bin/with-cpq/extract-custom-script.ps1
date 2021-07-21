#!/usr/bin/env pwsh
#Requires -Version 5

param (
    $CustomScriptName = 'enosix_sap_simulation',
    $OutputPath = '../../client-app/with-cpq/vc-cpq/cpq-quote-sap-simulation/staticresources'
)

# "strict mode" best practice
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

$CustomScriptRecord = (sfdx force:data:record:get --sobjecttype=SBQQ__CustomScript__c --where="Name='${CustomScriptName}'" --json | ConvertFrom-Json).result

$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

$Code = $CustomScriptRecord.SBQQ__Code__c -replace "(enosixConfig\s*=\s*){.*?};","`$1{/*ENOSIXCONFIG*/};"
$CodeFilePath = "$OutputPath/{0}.js" -f $CustomScriptRecord.Name | Resolve-Path
[System.IO.File]::WriteAllLines($CodeFilePath, $Code, $Utf8NoBomEncoding)

$TranspiledCodeFilePath = "$OutputPath/{0}_transpiled.js" -f $CustomScriptRecord.Name | Resolve-Path
$TranspiledCode = $CustomScriptRecord.SBQQ__TranspiledCode__c -replace "(enosixConfig\s*=\s*){.*?};","`$1{/*ENOSIXCONFIG*/};" -replace "//# sourceURL=.*",""
[System.IO.File]::WriteAllLines($TranspiledCodeFilePath, $TranspiledCode, $Utf8NoBomEncoding)

npx prettier --write --print-width 100 --arrow-parens avoid --trailing-comma none --single-quote --no-config "$OutputPath/*.js"
