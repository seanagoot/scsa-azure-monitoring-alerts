#!/bin/bash

# SCSA Company - Project 4
# Review recent administrative activity

az monitor activity-log list \
  --resource-group rg-scsa-compute-krc \
  --max-events 10 \
  --query "[].{Time:eventTimestamp,Operation:operationName.localizedValue,Status:status.localizedValue}" \
  --output table
