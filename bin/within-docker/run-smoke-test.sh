#!/bin/bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

SKIP_SMOKE_TEST=${SKIP_SMOKE_TEST:-false}
if [[ "$SKIP_SMOKE_TEST" == "true" ]] ; then
  # All of this script is a smoke test.
  exit 0
fi

function cleanup {
  sfdx force:org:delete --noprompt --targetusername tmp_org || true
}
trap cleanup EXIT

#
# main
#
set -x -v # trace on

WAIT=${WAIT:-60}

#
# Cause build failure when CustomLabels is not sorted
#

md5sum --binary client-app/common-core/labels/CustomLabels.labels-meta.xml | tee /tmp/CustomLabels.md5sum
bin/sort_customlabels.ps1
md5sum --check --status /tmp/CustomLabels.md5sum

#
# Enterprise common-sync
#

proj_name="common-sync"

cd project/common-sync
../../bin/rebuild-scratch-org.ps1 -a tmp_org
sfdx force:apex:test:run --synchronous --wait "$WAIT" --resultformat junit > "./junit-test-report-${proj_name}.xml.tmp"
sfdx force:org:delete --noprompt --targetusername tmp_org
cd ../..

#
# Enterprise
#

proj_name="enterprise-sales-doc"

cd project/sales-doc
../../bin/rebuild-scratch-org.ps1 -a tmp_org
sfdx force:apex:test:run --synchronous --wait "$WAIT" --resultformat junit > "./junit-test-report-${proj_name}.xml.tmp"
sfdx force:org:delete --noprompt --targetusername tmp_org
cd ../..

#
# With built-in Quote
#

proj_name="enterprise-with-built-in-quote"

cd project/with-built-in-quote
../../bin/rebuild-scratch-org.ps1 -a tmp_org
sfdx force:apex:test:run --synchronous --wait "$WAIT" --resultformat junit > "./junit-test-report-${proj_name}.xml.tmp"
sfdx force:org:delete --noprompt --targetusername tmp_org
cd ../..

#
# CPQ
#

proj_name="enterprise-with-cpq"

cd project/with-cpq
../../bin/rebuild-scratch-org.ps1 -a tmp_org
sfdx force:apex:test:run --synchronous --wait "$WAIT" --resultformat junit > "./junit-test-report-${proj_name}.xml.tmp"
../../bin/source-deploy-and-test.ps1
sfdx force:org:delete --noprompt --targetusername tmp_org
cd ../..

#
# the end
#
