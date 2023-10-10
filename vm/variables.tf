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