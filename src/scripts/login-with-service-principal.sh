#!/usr/bin/env bash

if [ -z "$BASH_VERSION" ]; then
  echo "$@"
  exec bash "$@"
fi

az login \
  --service-principal \
  --tenant="${!AZURE_SP_TENANT}" \
  -u="${!AZURE_SP}" \
  -p="${!AZURE_SP_PASSWORD}"
