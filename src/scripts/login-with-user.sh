#!/usr/bin/env bash

ALTERNATE_TENANT="$(circleci env subst "$ALTERNATE_TENANT")"
AZURE_USERNAME="$(circleci env subst "$ALTERNATE_TENANT")"
AZURE_PASSWORD="$(circleci env subst "$ALTERNATE_TENANT")"
AZURE_TENANT="$(circleci env subst "$ALTERNATE_TENANT")"

if [[ ! "${ALTERNATE_TENANT}" = "false" ]]; then
  az login  \
      "--tenant=${$AZURE_TENANT}" \
      -u="${AZURE_USERNAME}" \
      -p="${AZURE_PASSWORD}"
    exit 0
fi

if [ -n "${AZURE_USERNAME}" ]; then
  echo "User credentials detected; logging in with user"
  az login  \
    -u="${AZURE_USERNAME}" \
    -p="${AZURE_PASSWORD}"
  exit 0
fi
