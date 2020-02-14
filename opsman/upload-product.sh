#!/bin/bash

opsman="<opsman-url>"

if [[ $# -eq 0 ]]; then
  echo "Missing first argument - Path to product to upload."
fi

OPSMAN_USER="<user>"
OPSMAN_SECRET='<password>'

om --target https://$opsman -u $OPSMAN_USER -p ${OPSMAN_SECRET} -k upload-product --product $1