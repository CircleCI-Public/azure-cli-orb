#!/usr/bin/env bash

if [ ! "$BASH_VERSION" ]; then
  exec /bin/bash "$0" "$@"
fi

az login \
  --service-principal \
  --tenant="${!AZURE_SP_TENANT}" \
  -u="${!AZURE_SP}" \
  -p="${!AZURE_SP_PASSWORD}"
