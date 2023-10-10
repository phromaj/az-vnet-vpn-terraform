variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
}

variable "location" {
  description = "Localisation Azure pour les ressources"
  type        = string
}

variable "vnet1_id" {
  description = "ID du VNet1"
  type        = string
}

variable "vnet2_id" {
  description = "ID du VNet2"
  type        = string
}

# If you're attaching existing NICs, pass their IDs. Otherwise, create NICs in this module or another module.
variable "network_interface_id_1" {
  description = "ID de l'interface réseau pour VM1"
  type        = string
}

variable "network_interface_id_2" {
  description = "ID de l'interface réseau pour VM2"
  type        = string
}

