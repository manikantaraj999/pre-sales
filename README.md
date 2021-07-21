# enosiX Enterprise for {XYZ} built on enosiX SAP Customer 360° App SDK

When cloning this Enterprise Template for a specific client, change "{XYZ}" in the header above to the client's name, and then remove this sentence.

__*Note:*__ The contents of `scratch` are intended to help developers spin up a useful scratch org.
Anything under `scratch` (especially anything labeled "SDK App Starter") is NOT intended to be
shipped to the client unmodified. Anything intended for the client lives under `client-app`.

## Dev, Build and Test

Visual Studio Code -> Open Workspace...

- `client-app-base` is the base Enterprise Template.
  Additional instructions are available in [README-base](project/base/README-base.md).
- `client-app-with-built-in-quote` is Enterprise Template with the Salesforce built-in Quote (not CPQ).
  Additional instructions are available in [README-with-built-in-quote](project/with-built-in-quote/README-with-built-in-quote.md).
- `client-app-with-cpq` is Enterprise Template with CPQ dependent components.
  Additional instructions are available in [README-with-cpq](project/with-cpq/README-with-cpq.md).

```
# Run the following script from within project/base/ or project/with-cpq/ to spin up a
# scratch org and open it in a browser
../../bin/rebuild-scratch-org.ps1 -open -a ticket-id

# Create standard user for testing
sfdx force:user:create --setalias standard-user --definitionfile ../../config/base/standard-user-def.json

# Open for testing as standard user
sfdx force:org:open -u standard-user
```

## Debug log HTTP Trace of ensxapp/ensxsdk

The following commands configure a debug log that is (almost) free of all cruft and contains only
the raw HTTP requests/responses between the app/sdk and SAP.

```
# Deploy and apply the HTTP Trace logger (add -u to sfdx to target another org)
cd project/base
sfdx force:source:deploy --sourcepath ../../client-app/base/main/classes/UTIL_EnsxAppHttpTrace.cls
sfdx force:apex:execute --apexcodefile ../../config/base/enable-ensxapp-http-trace-mode.apex

# Define the EnsxAppHttpTrace debug level as ERROR for ApexCode and NONE for everything else
sfdx force:data:record:create --usetoolingapi --sobjecttype DebugLevel --values "DeveloperName=EnsxAppHttpTrace MasterLabel=EnsxAppHttpTrace ApexCode=ERROR ApexProfiling=NONE Callout=NONE Database=NONE System=NONE Validation=NONE Visualforce=NONE Workflow=NONE"

sfdx force:apex:log:tail --debuglevel EnsxAppHttpTrace
```

## Resources

"Using Salesforce DX at enosiX":
  https://docs.enosix.com/display/SAL/SFDX

## Description of Files and Directories

### `client-app`

Contains custom client components, code, and generated models.

#### `client-app/base/main`

Contains custom client components and code.

#### `client-app/base/models`

Contains generated SBO/RFC models.

### `data/base/wearables-example`

Contains sample data the corresponds to the `enosix_sap_*` SAP connections.

### `scratch`

The `scratch` folder contains metadata and configuration that is useful for a developer to have when
spinning up a scratch org. For example it would be quite a chore to setup a Named Credential and
common Page Layouts every time you start on a fresh task.

#### `scratch/client-dev-config`

Named Credential(s) for client's SAP system(s) and page layouts and other metadata to pre-configure
a scratch org's custom client code.

#### `scratch/base/common-app-starter`

Sample base application configuration of SAP Customer 360° which includes:

- Named Credentials for connections to enosiX's internal dev/qa/prod/dmo SAP systems.
- Custom Metadata Records that configure:
   - Discount K007 pricing condition for SAP Pricing.
   - Sample SAP Sales Area fields on Opportunity, and the custom metadata records for the
     Sales Area to be saved to the sample Opportunity fields.
- Page layouts that include the app's SAP action buttons, the Customer and Search Lightning
  components, and the SDK sample fields.
- Developer permission set that grants access to the SDK App Starter sample fields.

#### `scratch/triage`

There should be nothing in this directory except for this `.README.md` file. This filename
starts with a dot so that `sfdx` ignores it when pushing or pulling from the scratch org.

The `scratch/triage` folder is the "inbox" for new metadata created in the scratch org. Running
`sfdx force:source:pull` will land new metadata in this directory. From here it needs to be
determined whether the files are part of the code delivered to the client (`client-app`), or if it
is not important to commit to git (i.e. you will delete it from here when no longer needed for the
current task at hand), or whether it should be relocated to `scratch/client-dev-config` since
it will be useful for other developers spinning up a scratch org for this client (e.g. a Named
Credential for the client's SAP instance, or a Flexipage that makes it easy to interact with a
client's custom component).

## Issues

### Missing Opportunity SAP Pricing Quick Action from `ensxapp` 2gp beta packages

This is currently a limitation of second-generation-packaging (as of Spring '18). The workaround is
included in `scratch/common-app-starter/quickActions-missing-from-2gp`. Once this can be included
in the beta 2gp packages then this workaround can be removed. This is not necessary when working
with 1gp packages.

### Improvements to explore

- Instead of modifying the default page layouts, create a "SDK Developer" profile and assign the
  record and page layouts to that profile rather than overriding the org defaults.
  This will allow labeling and naming the layouts with _SDKAppStarter to continue providing a clear
  separation of what is only for development vs what is for the client.
