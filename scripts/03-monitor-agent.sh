#!/bin/bash

# SCSA Company - Project 4
# Azure Monitor Agent installation

az vm extension set \
  --name AzureMonitorLinuxAgent \
  --publisher Microsoft.Azure.Monitor \
  --resource-group rg-scsa-compute-krc \
  --vm-name vm-scsa-app01 \
  --enable-auto-upgrade true
