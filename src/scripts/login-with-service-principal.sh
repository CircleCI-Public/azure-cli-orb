#!/usr/bin/env bash
AZURE_SP_TENANT="$(circleci env subst "\$$AZURE_SP_TENANT")"
AZURE_SP="$(circleci env subst "\$$AZURE_SP")"
AZURE_SP_PASSWORD="$(circleci env subst "\$$AZURE_SP_PASSWORD")"

az login \
  --service-principal \
  --tenant="${AZURE_SP_TENANT}" \
  -u="${AZURE_SP}" \
  -p="${AZURE_SP_PASSWORD}"
