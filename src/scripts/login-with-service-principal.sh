#!/usr/bin/env bash
set -x
az login \
  --service-principal \
  --tenant "$AZURE_SP_TENANT" \
  -u "$AZURE_SP" \
  -p "$AZURE_SP_PASSWORD"
set +x
