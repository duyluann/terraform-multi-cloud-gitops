variable "project_id" {
  description = "The project/account ID"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
}

variable "force_destroy" {
  description = "Whether to force destroy the storage when deleting"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to the resources"
  type        = map(string)
  default     = {}
}

# Azure-specific variables
variable "resource_group_name" {
  description = "The Azure resource group name (required for Azure only)"
  type        = string
  default     = null
}