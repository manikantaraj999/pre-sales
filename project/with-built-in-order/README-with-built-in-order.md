# enosiX Enterprise with built-in Order

The built-in Salesforce Order sObject is not activated by default. This is split out into a separate
project to keep the dependencies of the other projects clean, since forcing clients to activate a
feature that they don't need is a bad practice.

## Spinning up a scratch org with built-in Order

1. Open "client-app-with-built-in-order" workspace in Visual Studio Code.

2. From Terminal opened to "project/with-built-in-order" run:

```
../../bin/rebuild-scratch-org.ps1 -open -a ticket-id
```

## Deploying to a client sandbox

```
cd project/with-built-in-order

# Adapted from ../../bin/rebuild-scratch-org.ps1 -whatif

# Only required the first time
# Manual step: install app and sdk packages
sfdx force:config:set defaultusername=YOUR_SANDBOX_ALIAS
sfdx force:apex:execute --apexcodefile ../../config/base/enable-aura-debug-mode.apex
sfdx force:data:record:create --sobjecttype ensxapp__LogSetting__c --values "ensxapp__HTTP_Trace__c=true ensxapp__LoggingLevel__c=1 ensxapp__Log_Sink__c=UTIL_EnsxAppLogSink"

# Repeat as necessary
sfdx force:mdapi:deploy --wait 60 --deploydir ../../client-app/aura-ui-sobjects
../../bin/source-deploy-and-test.ps1

# Only required the first time
sfdx force:user:permset:assign --permsetname enosiX_Order_User
sfdx force:user:permset:assign --permsetname enosiX_SalesDoc_User
sfdx force:user:permset:assign --permsetname enosiX_Model_Generator_Bridge
sfdx force:user:permset:assign --permsetname enosiX_App_Admin
sfdx force:user:permset:assign --permsetname enosiX_App_Standard_User
```
