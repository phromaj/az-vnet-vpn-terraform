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

variable "subscription_id" {
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  sensitive   = true
}