# Provider enablement flags
variable "enable_gcp" {
  description = "Enable GCP provider"
  type        = bool
  default     = false
}

variable "enable_aws" {
  description = "Enable AWS provider"
  type        = bool
  default     = false
}

variable "enable_azure" {
  description = "Enable Azure provider"
  type        = bool
  default     = false
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
  default     = "us-central1"
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
  default     = "us-east-1"
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
  default     = "eastus"
}

variable "azure_resource_group_name" {
  description = "The Azure resource group name"
  type        = string
  default     = null
}