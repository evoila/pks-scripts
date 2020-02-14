#!/bin/bash

set -e -x

## Variables ##

# URL of the nsx manager
NSX_MANAGER="<MANAGER_URL>"
# Username of the user to authenticate against the nsx manager
NSX_ADMINUSER="admin"
# Name of the nsx superuser to create
PI_NAME="pks-nsx-t-superuser"
# Certificate to use for the certificate request
NSX_SUPERUSER_CERT_FILE="./superuser.cert"
# Key to use for the certificate request
NSX_SUPERUSER_KEY_FILE="./superuser.key"
# UUID for the principal identity request. Just generate a random UUID
NODE_ID="<uuid>"

####

echo "Please be aware, that this script does not come fully function without changing some variables in it."
echo "Make sure to have set the variables in the 'variables' section."

read -s -p "Enter NSX adminuser secret: " NSX_ADMINUSER_SECRET
echo " "

cert_request=$(cat <<END
  {
    "display_name": "$PI_NAME",
    "pem_encoded": "$(awk '{printf "%s\\n", $0}' $NSX_SUPERUSER_CERT_FILE)"
  }
END
)

echo "Sending certificate request ..."

curl -k -X POST \
"https://${NSX_MANAGER}/api/v1/trust-management/certificates?action=import" \
-u "$NSX_ADMINUSER:$NSX_ADMINUSER_SECRET" \
-H 'content-type: application/json' \
-d "$cert_request"

echo "... done"

read -s -p "Enter the certificate id that was created by the previous curl call: " CERTIFICATE_ID

pi_request=$(cat <<END
  {
    "display_name": "$PI_NAME",
    "name": "$PI_NAME",
    "permission_group": "superusers",
    "certificate_id": "$CERTIFICATE_ID",
    "node_id": "$NODE_ID"
  }
END
)

echo "Sending principal identity request ..."

curl -k -X POST \
  "https://${NSX_MANAGER}/api/v1/trust-management/principal-identities" \
  -u "$NSX_ADMINUSER:$NSX_ADMINUSER_SECRET" \
  -H 'content-type: application/json' \
  -d "$pi_request"

  echo "... done"