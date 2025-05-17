terraform {
  required_version = ">= 1.0.0"

  backend "gcs" {
    bucket = "terraform-state-prod"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Environment-specific variables
locals {
  environment = "prod"
  tags = {
    Environment = local.environment
    ManagedBy   = "terraform"
  }
}

module "storage" {
  source = "../../modules/storage"

  project_id    = var.project_id
  environment   = local.environment
  region        = var.region
  force_destroy = false  # Set to false for production
  tags          = local.tags
}