#!/usr/bin/env bash

AZURE_USERNAME_V="$(eval echo "$AZURE_USERNAME")"

TENANT=""
if [[ -z "$ALTERNATE_TENANT" ]]; then
  TENANT="--tenant \"$AZURE_TENANT\""
fi
set -x
if [ -n "${AZURE_USERNAME_V}" ]; then
  echo "User credentials detected; logging in with user"
  az login "$TENANT" \
    -u "$AZURE_USERNAME_V" \
    -p "$AZURE_PASSWORD"
elif [ -n "${AZURE_SP}" ]; then
  echo "Service Principal credentials detected; logging in with Service Principal"
  az login \
    --service-principal \
    --tenant "$AZURE_SP_TENANT" \
    -u "$AZURE_SP" \
    -p "$AZURE_SP_PASSWORD"
else
  echo 'Login failed; neither user nor Service Principal credentials were provided'
  exit 1
fi
set +x
