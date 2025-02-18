#!/usr/bin/env bash

ALTERNATE_TENANT_V=$(circleci env subst "\$$ALTERNATE_TENANT")
AZURE_USERNAME_V=$(circleci env subst "\$$ALTERNATE_TENANT") 
AZURE_PASSWORD_V=$(circleci env subst "\$$ALTERNATE_TENANT") 
AZURE_TENANT_V=$(circleci env subst "\$$ALTERNATE_TENANT") 

if [[ ! "${ALTERNATE_TENANT_V}" = "false" ]]; then
  az login  \
      "--tenant=${$AZURE_TENANT_V}" \
      -u="${AZURE_USERNAME_V}" \
      -p="${AZURE_PASSWORD_V}"
    exit 0
fi

if [ -n "${AZURE_USERNAME_V}" ]; then
  echo "User credentials detected; logging in with user"
  az login  \
    -u="${AZURE_USERNAME_V}" \
    -p="${AZURE_PASSWORD_V}"
  exit 0
fi
