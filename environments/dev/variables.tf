# Provider enablement flags
variable "enable_gcp" {
  description = "Enable GCP provider"
  type        = bool
  default     = true
}

variable "enable_aws" {
  description = "Enable AWS provider"
  type        = bool
  default     = true
}

variable "enable_azure" {
  description = "Enable Azure provider"
  type        = bool
  default     = true
}

# GCP Variables
variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
  default     = null
}

variable "gcp_region" {
  description = "The GCP region to deploy resources"
  type        = string
  default     = "asia-southeast1"
}

# AWS Variables
variable "aws_account_id" {
  description = "The AWS account ID"
  type        = string
  default     = null
}

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-1"
}

# Azure Variables
variable "azure_subscription_id" {
  description = "The Azure subscription ID"
  type        = string
  default     = null
}

variable "azure_region" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "southeastasia"
}

variable "azure_resource_group_name" {
  description = "The Azure resource group name"
  type        = string
  default     = null
}

variable "project_id" {
  description = "The project ID. If not provided, a random string will be generated"
  type        = string
  default     = null
}
