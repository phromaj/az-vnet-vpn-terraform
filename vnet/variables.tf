variable "vnet1_address_space" {
  description = "Plage d'adresses pour VNet1"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "vnet2_address_space" {
  description = "Plage d'adresses pour VNet2"
  type        = list(string)
  default     = ["10.2.0.0/16"]
}

variable "gateway_subnet_prefix_vnet1" {
  description = "Prefix de GatewaySubnet pour VNet1"
  type        = string
  default     = "10.1.255.0/27"
}

variable "gateway_subnet_prefix_vnet2" {
  description = "Prefix de GatewaySubnet pour VNet2"
  type        = string
  default     = "10.2.255.0/27"
}
