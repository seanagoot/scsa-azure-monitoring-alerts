#!/bin/bash

# SCSA Company - Project 4
# Log Analytics Workspace

az monitor log-analytics workspace create \
  --resource-group rg-scsa-monitoring-krc \
  --workspace-name law-scsa-monitoring-krc \
  --location koreacentral
