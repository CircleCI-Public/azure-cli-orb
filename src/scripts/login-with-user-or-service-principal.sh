#!/usr/bin/env bash
ALTERNATE_TENANT_V=$(circleci env subst "\$$ALTERNATE_TENANT")
AZURE_TENANT_V=$(circleci env subst "\$$AZURE_TENANT")
AZURE_USERNAME_V=$(circleci env subst "\$$AZURE_USERNAME")
AZURE_PASSWORD_V=$(circleci env subst "\$$AZURE_PASSWORD")
AZURE_SP_V=$(circleci env subst "\$$AZURE_SP")
AZURE_SP_TENANT_V=$(circleci env subst "\$$AZURE_SP_TENANT")
AZURE_SP_PASSWORD_V=$(circleci env subst "\$$AZURE_SP_PASSWORD")

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

if [ -n "${AZURE_SP_V}" ]; then
  echo "Service Principal credentials detected; logging in with Service Principal"
  az login \
    --service-principal \
    --tenant="${AZURE_SP_TENANT_V}" \
    -u="${AZURE_SP_V}" \
    -p="${AZURE_SP_PASSWORD_V}"
  exit 0
fi

echo 'Login failed; neither user nor Service Principal credentials were provided'
exit 1
