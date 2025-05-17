variable "project_id" {
  description = "The project ID. If not provided, a random string will be generated"
  type        = string
  default     = null
}

variable "environment" {
  description = "The environment (dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "The Azure region"
  type        = string
  default     = "southeastasia"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "force_destroy" {
  description = "Whether to force destroy the storage when deleting"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags for the resources"
  type        = map(string)
  default     = {}
}
