#!/usr/bin/env bash

if [[ ! "${!ALTERNATE_TENANT}" = "false" ]]; then
  az login  \
      "--tenant=${!$AZURE_TENANT}" \
      -u="${!AZURE_USERNAME}" \
      -p="${!AZURE_PASSWORD}"
    exit 0
fi

if [ -n "${!AZURE_USERNAME}" ]; then
  echo "User credentials detected; logging in with user"
  az login  \
    -u="${!AZURE_USERNAME}" \
    -p="${!AZURE_PASSWORD}"
  exit 0
fi
