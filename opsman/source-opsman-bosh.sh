#!/bin/bash
echo "Setting env vars for opsman bosh ..."

export BOSH_CLIENT=ops_manager 
export BOSH_CLIENT_SECRET="<bosh-secret>"
export BOSH_CA_CERT="/var/tempest/workspaces/default/root_ca_certificate"
export BOSH_ENVIRONMENT="<director-url>"

echo "... done."