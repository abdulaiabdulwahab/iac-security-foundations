# iac-security-foundations

# IaC Security Foundations

## Project Overview

This project demonstrates how to identify and fix insecure Infrastructure as Code configurations before deployment.

The lab uses **Terraform** to define Azure infrastructure and **Checkov** to scan the Terraform files for security misconfigurations.

The goal is to understand how IaC security fits into a DevSecOps workflow and how security issues can be detected before infrastructure is deployed to Azure.

## Objectives

This project focuses on:

- Understanding Infrastructure as Code security
- Scanning Terraform files for security issues
- Identifying insecure Azure resource configurations
- Remediating security findings
- Re-running security scans to verify fixes
- Understanding the difference between Terraform validation and security validation

## Tools Used

- Terraform
- Checkov
- AzureRM Provider
- Azure
- Git / GitHub
- Python

## Project Structure

```text
iac-security-foundations/
├── main.tf
└── .venv/
```

## Security Issues Tested

The Terraform configuration was intentionally created with insecure settings such as:

- HTTP traffic allowed to Azure Storage
- Public access enabled
- Shared access keys enabled
- Public network access enabled
- Weak storage security configuration

These settings were used only for security testing and were not intended to be deployed.

## Install Checkov

Create a Python virtual environment:

```bash
python -m venv .venv
```

Activate it using Git Bash:

```bash
source .venv/Scripts/activate
```

Install Checkov:

```bash
python -m pip install --upgrade pip
python -m pip install checkov
```

Verify the installation:

```bash
checkov --version
```

## Scan the Terraform Configuration

Run:

```bash
checkov -d . --framework terraform
```

For more compact output:

```bash
checkov -d . \
  --framework terraform \
  --compact
```

Checkov analyzes the Terraform configuration and reports security checks as either passed or failed.

## Remediation

After reviewing the findings, insecure settings were changed to more secure values.

Examples included:

```hcl
https_traffic_only_enabled = true
```

```hcl
allow_nested_items_to_be_public = false
```

```hcl
shared_access_key_enabled = false
```

```hcl
public_network_access_enabled = false
```

Additional security controls were also enabled where appropriate.

## Re-Scan

After fixing the configuration, the security scan was run again:

```bash
checkov -d . \
  --framework terraform \
  --compact
```

The updated scan showed fewer security findings and demonstrated the basic IaC security workflow:

```text
Write IaC
   ↓
Scan
   ↓
Identify security findings
   ↓
Fix configuration
   ↓
Re-scan
```

## Key Learning

Terraform validation checks whether Terraform configuration is syntactically and structurally valid.

For example:

```bash
terraform validate
```

IaC security scanning checks whether valid Terraform is also secure.

For example:

```bash
checkov -d .
```

A Terraform configuration can therefore be completely valid while still containing serious security risks.

## Troubleshooting

### Checkov command not found

Activate the virtual environment:

```bash
source .venv/Scripts/activate
```

Then verify:

```bash
checkov --version
```

### Checkov cannot find Terraform files

Verify that `main.tf` exists:

```bash
ls
```

Then run:

```bash
checkov -d . --framework terraform
```

### Too many findings

Use compact mode:

```bash
checkov -d . \
  --framework terraform \
  --compact
```

Review and remediate one finding at a time.

## Outcome

This project demonstrated how IaC security tools can identify risky cloud infrastructure configurations before deployment.

It also introduced the concept of **shift-left security**, where security checks are performed earlier in the development lifecycle instead of waiting until infrastructure has already been deployed.

## Skills Demonstrated

- Infrastructure as Code Security
- Terraform
- Checkov
- Azure Security
- Cloud Security
- DevSecOps
- Security Misconfiguration Detection
- Security Remediation
- Shift-Left Security

## Next Step

The next project extends this concept into a real-world CI/CD workflow where IaC security scanning is integrated into **Azure Pipelines** and insecure Terraform can automatically fail the pipeline.