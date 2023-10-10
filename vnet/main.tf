# VNet1 and its GatewaySubnet
resource "azurerm_virtual_network" "vnet1" {
  name                = "VNet1"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "gateway_subnet_vnet1" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.1.255.0/27"]
}

# VNet2 and its GatewaySubnet
resource "azurerm_virtual_network" "vnet2" {
  name                = "VNet2"
  address_space       = ["10.2.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "gateway_subnet_vnet2" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.2.255.0/27"]
}

# Public IPs for VPN Gateways
resource "azurerm_public_ip" "gateway_ip1" {
  name                = "MyGatewayIp1"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "gateway_ip2" {
  name                = "MyGatewayIp2"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

# VPN Gateways
resource "azurerm_virtual_network_gateway" "vpn_gateway1" {
  name                = "VpnGateway1"
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.gateway_ip1.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet_vnet1.id
  }
}

resource "azurerm_virtual_network_gateway" "vpn_gateway2" {
  name                = "VpnGateway2"
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.gateway_ip2.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet_vnet2.id
  }
}

# VPN Connections
resource "azurerm_virtual_network_gateway_connection" "vnet1_to_vnet2" {
  name                = "VNet1toVNet2"
  resource_group_name = var.resource_group_name
  location            = var.location

  type                       = "Vnet2Vnet"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway1.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway2.id
  shared_key                  = "Abc123"
}

resource "azurerm_virtual_network_gateway_connection" "vnet2_to_vnet1" {
  name                = "VNet2toVNet1"
  resource_group_name = var.resource_group_name
  location            = var.location

  type                       = "Vnet2Vnet"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway2.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway1.id
  shared_key                  = "Abc123"
}

