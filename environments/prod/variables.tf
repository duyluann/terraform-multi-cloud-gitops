variable "project_id" {
  description = "The GCP project ID"
  type        = string
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
