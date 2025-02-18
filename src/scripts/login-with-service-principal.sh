#!/usr/bin/env bash
AZURE_SP_TENANT_V=$(circleci env subst "\$$AZURE_SP_TENANT")
AZURE_SP_V=$(circleci env subst "\$$AZURE_SP")
AZURE_SP_PASSWORD_V=$(circleci env subst "\$$AZURE_SP_PASSWORD")

az login \
  --service-principal \
  --tenant="${AZURE_SP_TENANT_V}" \
  -u="${AZURE_SP_V}" \
  -p="${AZURE_SP_PASSWORD_V}"
