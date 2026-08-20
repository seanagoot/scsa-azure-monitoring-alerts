#!/bin/bash

# SCSA Company - Project 4
# Associate the Data Collection Rule with the Linux VM

VM_ID=$(az vm show \
  --resource-group rg-scsa-compute-krc \
  --name vm-scsa-app01 \
  --query id \
  --output tsv)

DCR_ID=$(az monitor data-collection rule show \
  --resource-group rg-scsa-monitoring-krc \
  --name dcr-scsa-linux-syslog \
  --query id \
  --output tsv)

az monitor data-collection rule association create \
  --name dcra-scsa-app01 \
  --rule-id "$DCR_ID" \
  --resource "$VM_ID"
