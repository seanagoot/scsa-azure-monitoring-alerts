# SCSA Company – Project 4: Azure Monitoring and Alerts

## Project Overview

This project demonstrates the implementation of centralized monitoring, logging, alerting, and administrative visibility for SCSA Company’s Azure environment.

The solution extends the Linux application server deployed in Project 2 by adding Azure Monitor Agent, Data Collection Rules, Log Analytics, metric alerts, action groups, and Azure Activity Log visibility.

## Business Scenario

SCSA Company requires operational visibility into its Azure workloads so the IT team can:

- Monitor VM health and performance
- Collect Linux system logs centrally
- Detect high resource usage
- Review administrative changes
- Support troubleshooting and incident response
- Maintain a cost-conscious monitoring baseline

## Architecture Diagram

![Azure Monitoring Architecture](./architecture/scsa-azure-monitoring-architecture.png)

## Azure Region

- Korea Central

## Monitoring Resource Group

- `rg-scsa-monitoring-krc`

## Log Analytics Workspace

- Name: `law-scsa-monitoring-krc`
- Region: Korea Central
- SKU: `PerGB2018`

The workspace acts as the centralized destination for Linux Syslog data collected from the application server.

## Monitored Workload

Project 4 monitors the Linux application server created in Project 2:

- VM: `vm-scsa-app01`
- Operating System: Ubuntu Server 24.04 LTS
- VM Size: `Standard_B2als_v2`

This demonstrates how monitoring can be layered onto an existing Azure workload rather than deployed as an isolated lab.

## Azure Monitor Agent

The Azure Monitor Agent was installed on `vm-scsa-app01`.

### Configuration

- Extension: `AzureMonitorLinuxAgent`
- Publisher: `Microsoft.Azure.Monitor`
- Automatic upgrade: Enabled

The agent collects telemetry according to Data Collection Rules assigned to the VM.

## Data Collection Rule

### DCR

`dcr-scsa-linux-syslog`

The DCR sends selected Linux Syslog events to the Log Analytics Workspace.

### Collected Facilities

- `auth`
- `authpriv`
- `daemon`
- `syslog`

### Collected Severities

- Warning
- Error
- Critical
- Alert
- Emergency

Only operationally useful log levels were selected to reduce unnecessary data ingestion.

## DCR Association

The DCR is associated with:

`vm-scsa-app01`

Association name:

`dcra-scsa-app01`

This connects the Azure Monitor Agent on the VM to the Syslog collection rule.

## Syslog Validation

Test Syslog events were generated from the Linux server using the `logger` command.

The validation events included:

- Authentication warning
- Daemon error
- Syslog critical event

The events were successfully ingested into Log Analytics and verified using KQL.

Example query:

```kusto
Syslog
| where Computer == "vm-scsa-app01"
| where SyslogMessage contains "SCSA Project 4 validation"
| project TimeGenerated, Computer, Facility, SeverityLevel, SyslogMessage
| order by TimeGenerated desc
