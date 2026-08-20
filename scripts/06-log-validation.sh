#!/bin/bash

# SCSA Company - Project 4
# Validate Syslog ingestion in Log Analytics

WORKSPACE_ID=$(az monitor log-analytics workspace show \
  --resource-group rg-scsa-monitoring-krc \
  --workspace-name law-scsa-monitoring-krc \
  --query customerId \
  --output tsv)

az monitor log-analytics query \
  --workspace "$WORKSPACE_ID" \
  --analytics-query "Syslog
  | where Computer == 'vm-scsa-app01'
  | where SyslogMessage contains 'SCSA Project 4 validation'
  | project TimeGenerated, Computer, Facility, SeverityLevel, SyslogMessage
  | order by TimeGenerated desc" \
  --output table
