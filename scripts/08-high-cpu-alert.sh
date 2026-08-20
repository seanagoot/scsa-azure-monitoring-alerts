#!/bin/bash

# SCSA Company - Project 4
# High CPU Metric Alert

VM_ID=$(az vm show \
  --resource-group rg-scsa-compute-krc \
  --name vm-scsa-app01 \
  --query id \
  --output tsv)

AG_ID=$(az monitor action-group show \
  --resource-group rg-scsa-monitoring-krc \
  --name ag-scsa-operations \
  --query id \
  --output tsv)

az monitor metrics alert create \
  --name alert-scsa-high-cpu \
  --resource-group rg-scsa-monitoring-krc \
  --scopes "$VM_ID" \
  --condition "avg Percentage CPU > 80" \
  --window-size 5m \
  --evaluation-frequency 1m \
  --severity 2 \
  --description "Alert when vm-scsa-app01 average CPU exceeds 80 percent for the evaluation window." \
  --action "$AG_ID"
