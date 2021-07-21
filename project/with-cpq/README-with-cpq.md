# enosiX Enterprise with CPQ

## Spinning up a scratch org with CPQ

1. Open "client-app-with-cpq" workspace in Visual Studio Code.

2. From Terminal opened to "project/with-cpq" run:

```
../../bin/rebuild-scratch-org.ps1 -open -a ticket-id
```

## Deploying to a client sandbox

```
cd project/with-cpq

# Adapted from ../../bin/rebuild-scratch-org.ps1 -whatif

# Only required the first time
# Manual step: install Salesforce CPQ and enosiX app and sdk packages
sfdx force:config:set defaultusername=YOUR_SANDBOX_ALIAS
sfdx force:apex:execute --apexcodefile ../../config/base/enable-aura-debug-mode.apex
sfdx force:data:record:create --sobjecttype ensxapp__LogSetting__c --values "ensxapp__HTTP_Trace__c=true ensxapp__LoggingLevel__c=1 ensxapp__Log_Sink__c=UTIL_EnsxAppLogSink"

# Repeat as necessary
sfdx force:mdapi:deploy --wait 60 --deploydir ../../client-app/aura-ui-sobjects
../../bin/source-deploy-and-test.ps1
sfdx force:apex:execute --apexcodefile ../../config/with-cpq/installCustomScript.apex

# Only required the first time
# Manual step: add SAP_Configuration__c to ReferencedFields field set on SBQQ__QuoteLine__c
sfdx force:user:permset:assign --permsetname enosiX_CPQ_User
sfdx force:user:permset:assign --permsetname enosiX_SalesDoc_User
sfdx force:user:permset:assign --permsetname SBQQ__SteelBrickCPQAdmin
sfdx force:user:permset:assign --permsetname enosiX_Model_Generator_Bridge
sfdx force:user:permset:assign --permsetname enosiX_App_Admin
sfdx force:user:permset:assign --permsetname enosiX_App_Standard_User
```

### Manual Setup Steps

After the previous steps are complete, do these manual steps:

1. Authorize the CPQ Calcualtion Service

   Running rebuild-scratch-org.ps1 with the `-open` flag as shown above should have opened two tabs.
   In the first tab, Click `Allow` to finish authorizing CPQ calculation service. It will display
   the message "You are all set. Happy Quoting!!" if the authorization is successful.
   The second tab directs you to `Setup > Installed Packages` to prep for the next steps.

   However if it failed you can either run this step manually:

  ```
  sfdx force:org:open --path "services/oauth2/authorize?response_type=code%26client_id=3MVG9yZ.WNe6byQBf3KaROSnAINMpMlCRNXj2YJ3NfuFlQ3W5MNuK89Wldb3FsiUK3kdxgMStp.7aOMpdeThJ%26redirect_uri=https%3A%2F%2Frest-na.steelbrick.com%2Foauth%2Fcallback%26scope=api%20refresh_token%26state=https%3A%2F%2Ftest.salesforce.com_SBQQ"
  ```

   * **Note:** The `services/oauth2/authorize?response_type=...` URL was obtained
     by inspecting the `Authorize new calculation service` button which opens
     `https://rest-na.steelbrick.com/oauth/auth/https%3A%2F%2Ftest.salesforce.com/SBQQ`

     Running `curl -vvv https://rest-na.steelbrick.com/oauth/auth/https%3A%2F%2Ftest.salesforce.com/SBQQ`
     always returned the same URL. Using just the URL path returned lets us connect directly to the
     org and skip the extra login screen.

   And if that still fails, you can try this step manually:

   Usually this requires a username and password to continue you, which you can obtain from your
   scratch org by running `sfdx force:user:password:generate`.

   Navigate to `Setup > Installed Packages > Salesforce CPQ > Configure > Pricing and Calculation`
   and click `Authorize new calculation service`.

2. Enable Visualize Product Hierarchy

   Navigate to `Setup > Installed Packages > Salesforce CPQ > Configure > Line Editor` and check the
   box `Visualize Product Hierarchy` and click `Save`.

3. Configure the Quote Calculator Plugin

   Navigate to `Setup > Installed Packages > Salesforce CPQ > Configure > Plugins`

   Set "Quote Calculator Plugin" to `enosix_sap_simulation` which enables pricing simulation
   and click `Save`.

4. Setup the Salesforce CPQ's External Configurator URL

   Navigate to `Setup > Installed Packages > Salesforce CPQ > Configure > Additional Settings > External Configurator URL` and use the URL from this one-liner in PowerShell and then click `Save`:

```
# Run this directly in PowerShell:

$iurl = (sfdx force:org:display --json | ConvertFrom-Json).result.instanceUrl.ToLower(); $iurl -replace '\..*','--c.visualforce.com/apex/VFP_enosiXExternalConfiguratorPlugin'; $iurl -replace '\.cs','--c.cs' -replace '\.my\.salesforce\.com','.visual.force.com/apex/VFP_enosiXExternalConfiguratorPlugin'

# Or run this one-liner on macOS to call PowerShell:

pwsh -c "\$iurl = (sfdx force:org:display --json | ConvertFrom-Json).result.instanceUrl.ToLower(); \$iurl -replace '\..*','--c.visualforce.com/apex/VFP_enosiXExternalConfiguratorPlugin'; \$iurl -replace '\.cs','--c.cs' -replace '\.my\.salesforce\.com','.visual.force.com/apex/VFP_enosiXExternalConfiguratorPlugin'"
```

   * Note: Which URL to use is based on whether the Critical Updates for "Remove Instance
     Names From URLs for Visualforce, Community Builder, Site.com Studio, and Content Files" and
     "Stabilize the Hostname for My Domain URLs in Sandboxes" have been activated.
     The manual way to obtain the appropriate URL for any given org is to navigate to
     `Setup > Visualforce pages > Choose VFP_enosiXExternalConfiguratorPlugin > Preview` and copy
     the URL from the browser address bar.

## Using CPQ to get to VC

1. App Launcher -> Salesforce CPQ -> Quotes -> New -> Pick an Account (e.g. REI-Atlanta) -> Save
2. Quick Actions -> Edit Lines -> Wearables Price Book -> Add Products -> DELL COMPUTER1 -> Select

## Sample Test Data for CPQ
Go to this link for the list of sample data:
https://docs.enosix.com/display/CPQ/CPQ+Test+Data

## Editing the Quote Calculator Plugin (QCP)

After making local changes to the `enosix_sap_simulation.js` static resource, it must be deployed
and applied to the custom script record for CPQ to use it. Then extract it from the org to keep the
transpiled version of the code synchronized with the original code.

```
cd project/with-cpq

# Deploy and apply changes so CPQ can use it
sfdx force:source:push
sfdx force:apex:execute --apexcodefile ../../config/with-cpq/installCustomScript.apex

# Extract enosix_sap_simulation SBQQ__CustomScript__c from default org to ../../client-app/vc-cpq/cpq-quote-sap-simulation/staticresources/*.js
../../bin/with-cpq/extract-custom-script.ps1

# Extract CPQ Custom Actions
sfdx force:data:tree:export --query "SELECT Id, SBQQ__Action__c, SBQQ__Active__c, SBQQ__BrandButton__c, SBQQ__Class__c, SBQQ__ConditionsMet__c, SBQQ__Default__c, SBQQ__Description__c, SBQQ__DisplayOrder__c, SBQQ__EventHandlerName__c, SBQQ__IconClass__c, SBQQ__Icon__c, SBQQ__Label__c, SBQQ__Location__c, SBQQ__PageHandlerName__c, SBQQ__Page__c, SBQQ__ParentCustomAction__c, SBQQ__ReturnURL__c, SBQQ__TargetObject__c, SBQQ__Type__c, SBQQ__URLTarget__c, SBQQ__URL__c, Name FROM SBQQ__CustomAction__c WHERE SBQQ__DisplayOrder__c < 900" --outputdir ../../data/vc-cpq-example/
```

If error like:
Refused to display 'https://test--enosixdev2--c.visualforce.com/apex/VFP_enosiXExternalConfiguratorPlugin?xdm_e=https%3A%2F%2Ftest--enosixdev2--sbqq.visualforce.com&xdm_c=sbQQ&xdm_p=1' in a frame because an ancestor violates the following Content Security Policy directive: "frame-ancestors 'self'"

try disabling Setup | Session Settings | Clickjack Protection for Visualforce pages

## Resources

CPQ Installation Packages - http://steelbrick2.force.com/InstallPremium

Customer 500178 
Sales Area 3000, 10, 00
VC Products 506600X-WGRN & 5099365-WGRN
