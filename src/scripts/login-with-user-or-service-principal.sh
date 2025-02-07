#!/usr/bin/env bash

set -x


if [[ "${!ALTERNATE_TENANT}" -eq 1 ]]; then
  az login  \
      "--tenant ${!$AZURE_TENANT}" \
      -u "${!AZURE_USERNAME}" \
      -p "${!AZURE_PASSWORD}"
    exit 0
fi

if [ -n "${!AZURE_USERNAME}" ]; then
  echo "User credentials detected; logging in with user"
  az login  \
    -u "${!AZURE_USERNAME}" \
    -p "${!AZURE_PASSWORD}"
  exit 0
fi

if [ -n "${!AZURE_SP}" ]; then
  echo "Service Principal credentials detected; logging in with Service Principal"
  az login \
    --service-principal \
    --tenant "${!AZURE_SP_TENANT}" \
    -u "${!AZURE_SP}" \
    -p "${!AZURE_SP_PASSWORD}"
  exit 0
fi

echo 'Login failed; neither user nor Service Principal credentials were provided'
exit 1

set +x