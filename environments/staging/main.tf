terraform {
  required_version = ">= 1.0.0"

  backend "gcs" {
    bucket = "terraform-state-staging"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Environment-specific variables
locals {
  environment = "staging"
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
  force_destroy = true
  tags          = local.tags
}