# Azure VNet-VPN Terraform Automation

This repository provides Terraform configurations to automate the creation of Azure Virtual Networks, establish VPN connections, and deploy VMs into these networks.

## Features:

- Automated VNet creation in Azure.
- Configuration of VPN connections between VNets.
- Deployment of VMs into specific VNets.

## Prerequisites:

1. [Terraform](https://www.terraform.io/downloads.html) installed.
2. [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed.
3. An Azure account and a configured [Service Principal for Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret).

## Setup:

1. **Clone the Repository:**
    ```bash
    git clone https://github.com/[YOUR_USERNAME]/[YOUR_REPO_NAME].git
    cd [YOUR_REPO_NAME]
    ```

2. **Login to Azure:**
    ```bash
    az login
    ```

3. **Initialize Terraform:**
    ```bash
    terraform init
    ```

4. **Apply the Configuration:**
    ```bash
    terraform apply
    ```

Note: Replace `[YOUR_USERNAME]` and `[YOUR_REPO_NAME]` with appropriate values.

## Customization:

You can customize the Terraform variables as per your requirements in the provided configurations.

## Cleanup:

To destroy the created resources:

```bash
terraform destroy
```
