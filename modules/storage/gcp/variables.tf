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
  description = "The GCP region"
  type        = string
  default     = "asia-southeast1"
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket even if it's not empty"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags for the resources"
  type        = map(string)
  default     = {}
}
