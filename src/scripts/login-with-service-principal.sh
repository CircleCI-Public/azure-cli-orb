#!/usr/bin/env bash

if bash --version &>/dev/null; then
  az login \
    --service-principal \
    --tenant="${!AZURE_SP_TENANT}" \
    -u="${!AZURE_SP}" \
    -p="${!AZURE_SP_PASSWORD}"
else
  echo "Bash not found and is required for azure cli"
fi
