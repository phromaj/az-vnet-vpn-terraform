provider "azurerm" {
  features {}
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
  network_interface_id_1 = module.vnet.network_interface_id_1.id
  network_interface_id_2 = module.vnet.network_interface_id_2.id
}

