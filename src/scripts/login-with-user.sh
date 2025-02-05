#!/usr/bin/env bash

TENANT=""
if [[ -n "$ALTERNATE_TENANT" ]]; then
  TENANT="--tenant \"$AZURE_TENANT\""
fi

az login \
  "$TENANT" \
  -u "$AZURE_USERNAME" \
  -p "$AZURE_PASSWORD"
