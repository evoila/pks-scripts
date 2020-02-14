#!/bin/bash


if [[ $# -eq 0 ]]; then
  echo "Missing first argument - Path to stemcell to upload."
fi

OPSMAN="<opsman-url>"
OPSMAN_USER="<user>"
OPSMAN_SECRET='<secret>'

om --target https://$OPSMAN -u $OPSMAN_USER -p ${OPSMAN_SECRET} -k upload-stemcell --stemcell $1