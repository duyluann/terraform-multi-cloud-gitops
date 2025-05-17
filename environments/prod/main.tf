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
  region        = var.gcp_region
  force_destroy = true
  tags          = local.tags
}
