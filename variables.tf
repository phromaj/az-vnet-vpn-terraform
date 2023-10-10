variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
  default     = "MyResourceGroup"
}

variable "location" {
  description = "Localisation Azure pour les ressources"
  type        = string
  default     = "eastus"
}

