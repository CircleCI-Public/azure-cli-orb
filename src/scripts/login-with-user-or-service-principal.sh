#!/usr/bin/env bash

set -x

#AZURE_USERNAME="$(eval echo "${AZURE_USERNAME}" | circleci env subst)"
#AZURE_PASSWORD="$(eval echo "${AZURE_PASSWORD}" | circleci env subst)"
#AZURE_TENANT="$(eval echo "${AZURE_TENANT}" | circleci env subst)"
#AZURE_SP="$(eval echo "${AZURE_SP}" | circleci env subst)"
#AZURE_SP_PASSWORD="$(eval echo "${AZURE_SP_PASSWORD}" | circleci env subst)"
#AZURE_SP_TENANT="$(eval echo "${AZURE_SP_TENANT}" | circleci env subst)"

AZURE_USERNAME="${!AZURE_USERNAME}"
AZURE_PASSWORD="${!AZURE_PASSWORD}"
AZURE_TENANT="${!AZURE_TENANT}"
AZURE_SP="${!AZURE_SP}"
AZURE_SP_PASSWORD="${!AZURE_SP_PASSWORD}"
AZURE_SP_TENANT="${!AZURE_SP_TENANT}"

#TENANT=""
#if [[ "$ALTERNATE_TENANT" -eq 1 ]]; then
#  TENANT="--tenant \"$AZURE_TENANT\""
#fi

if [ -n "${AZURE_USERNAME}" ]; then
  echo "User credentials detected; logging in with user"
  az login  \
    -u "$AZURE_USERNAME" \
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