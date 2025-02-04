#!/usr/bin/env bash

az login \
  --service-principal \
  --tenant $<<parameters.azure-sp-tenant>> \
  -u $<<parameters.azure-sp>> \
  -p "$<<parameters.azure-sp-password>>"
