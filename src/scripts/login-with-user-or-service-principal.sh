#!/usr/bin/env bash
ALTERNATE_TENANT="$(circleci env subst "$ALTERNATE_TENANT")"
AZURE_TENANT="$(circleci env subst "$AZURE_TENANT")"
AZURE_USERNAME="$(circleci env subst "$AZURE_USERNAME")"
AZURE_PASSWORD="$(circleci env subst "$AZURE_PASSWORD")"
AZURE_SP="$(circleci env subst "$AZURE_SP")"
AZURE_SP_TENANT="$(circleci env subst "$AZURE_SP_TENANT")"
AZURE_SP_PASSWORD="$(circleci env subst "$AZURE_SP_PASSWORD")"

if [[ ! "${ALTERNATE_TENANT}" = "false" ]]; then
  az login \
    --tenant="${AZURE_TENANT}" \
    -u="${AZURE_USERNAME}" \
    -p="${AZURE_PASSWORD}"
  exit 0
fi

if [ -n "${AZURE_USERNAME}" ]; then
  echo "User credentials detected; logging in with user"
  az login \
    -u="${AZURE_USERNAME}" \
    -p="${AZURE_PASSWORD}"
  exit 0
fi

if [ -n "${AZURE_SP}" ]; then
  echo "Service Principal credentials detected; logging in with Service Principal"
  az login \
    --service-principal \
    --tenant="${AZURE_SP_TENANT}" \
    -u="${AZURE_SP}" \
    -p="${AZURE_SP_PASSWORD}"
  exit 0
fi

echo 'Login failed; neither user nor Service Principal credentials were provided'
exit 1
