#!/usr/bin/env bash

az login \
  --service-principal \
  --tenant "$AZURE_SP_TENANT" \
  -u "$AZURE_SP" \
  -p "$AZURE_SP_PASSWORD"
