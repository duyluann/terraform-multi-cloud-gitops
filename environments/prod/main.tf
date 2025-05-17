# Environment-specific variables
locals {
  environment = "prod"
  tags = {
    Environment = local.environment
    ManagedBy   = "terraform"
  }
}

module "gcp_storage" {
  source = "../../modules/storage/gcp"

  project_id    = var.project_id
  environment   = local.environment
  region        = var.region
  force_destroy = false # Set to false for production
  tags          = local.tags
}
