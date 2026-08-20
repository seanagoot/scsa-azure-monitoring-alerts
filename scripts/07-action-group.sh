#!/bin/bash

# SCSA Company - Project 4
# Azure Monitor Action Group

az monitor action-group create \
  --resource-group rg-scsa-monitoring-krc \
  --name ag-scsa-operations \
  --short-name scsaops
