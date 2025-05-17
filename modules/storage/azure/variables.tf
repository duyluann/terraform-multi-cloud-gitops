variable "project_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "The Azure region to deploy resources"
  type        = string
}

variable "resource_group_name" {
  description = "The Azure resource group name"
  type        = string
}

variable "force_destroy" {
  description = "Whether to force destroy the storage when deleting"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to the storage account"
  type        = map(string)
  default     = {}
}