terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.75.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id  = var.subscription_id
  tenant_id        = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source = "./vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}

module "vm" {
  source              = "./vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vnet1_id            = module.vnet.vnet1_id
  vnet2_id            = module.vnet.vnet2_id
}