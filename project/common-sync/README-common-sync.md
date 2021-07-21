# enosiX Enterprise Common-Sync (Customer and Material syncs)

## Spinning up a scratch org

1. Open "client-app-common-sync" workspace in Visual Studio Code.

2. From Terminal opened to "common-sync" run:

```
../../bin/rebuild-scratch-org.ps1 -open -a ticket-id
```

## Deploying to a client sandbox

```
cd project/common-sync

# Adapted from ../../bin/rebuild-scratch-org.ps1 -whatif

# Only required the first time
# Manual step: install app and sdk packages
sfdx force:config:set defaultusername=YOUR_SANDBOX_ALIAS
sfdx force:apex:execute --apexcodefile ../../config/base/enable-aura-debug-mode.apex
sfdx force:data:record:create --sobjecttype ensxapp__LogSetting__c --values "ensxapp__HTTP_Trace__c=true ensxapp__LoggingLevel__c=1 ensxapp__Log_Sink__c=UTIL_EnsxAppLogSink"

# Repeat as necessary
../../bin/source-deploy-and-test.ps1

# Only required the first time
sfdx force:user:permset:assign --permsetname enosiX_Common_Sync_User
sfdx force:user:permset:assign --permsetname enosiX_Common_Sync_Admin
sfdx force:user:permset:assign --permsetname enosiX_Model_Generator_Bridge
sfdx force:user:permset:assign --permsetname enosiX_App_Admin
sfdx force:user:permset:assign --permsetname enosiX_App_Standard_User
```
