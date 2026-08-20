#!/bin/bash

# SCSA Company - Project 4
# Linux Syslog Data Collection Rule

LAW_ID=$(az monitor log-analytics workspace show \
  --resource-group rg-scsa-monitoring-krc \
  --workspace-name law-scsa-monitoring-krc \
  --query id \
  --output tsv)

cat > dcr-scsa-linux-syslog.json <<EOF
{
  "location": "koreacentral",
  "properties": {
    "dataSources": {
      "syslog": [
        {
          "name": "syslogDataSource",
          "streams": [
            "Microsoft-Syslog"
          ],
          "facilityNames": [
            "auth",
            "authpriv",
            "daemon",
            "syslog"
          ],
          "logLevels": [
            "Warning",
            "Error",
            "Critical",
            "Alert",
            "Emergency"
          ]
        }
      ]
    },
    "destinations": {
      "logAnalytics": [
        {
          "name": "lawDestination",
          "workspaceResourceId": "$LAW_ID"
        }
      ]
    },
    "dataFlows": [
      {
        "streams": [
          "Microsoft-Syslog"
        ],
        "destinations": [
          "lawDestination"
        ]
      }
    ]
  }
}
EOF

az rest \
  --method put \
  --url "https://management.azure.com/subscriptions/$(az account show --query id -o tsv)/resourceGroups/rg-scsa-monitoring-krc/providers/Microsoft.Insights/dataCollectionRules/dcr-scsa-linux-syslog?api-version=2023-03-11" \
  --body @dcr-scsa-linux-syslog.json
