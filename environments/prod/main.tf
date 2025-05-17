# Environment-specific variables
locals {
  environment = "prod"
  tags = {
    environment = local.environment
    managed_by  = "terraform"
  }
}

# Generate project_id if not provided
resource "random_string" "project_id" {
  count   = var.project_id == null ? 1 : 0
  length  = 8
  special = false
  upper   = false
}

locals {
  project_id = var.project_id != null ? var.project_id : random_string.project_id[0].result
}

# GCP Storage
module "gcp_storage" {
  source = "../../modules/storage/gcp"
  count  = var.enable_gcp ? 1 : 0

  project_id    = local.project_id
  environment   = local.environment
  region        = var.gcp_region
  force_destroy = true
  tags          = local.tags
}

# AWS Storage
module "aws_storage" {
  source = "../../modules/storage/aws"
  count  = var.enable_aws ? 1 : 0

  project_id    = local.project_id
  environment   = local.environment
  region        = var.aws_region
  force_destroy = true
  tags          = local.tags
}

# Azure Storage
module "azure_storage" {
  source = "../../modules/storage/azure"
  count  = var.enable_azure ? 1 : 0

  project_id          = local.project_id
  environment         = local.environment
  region              = var.azure_region
  resource_group_name = var.azure_resource_group_name
  force_destroy       = true
  tags                = local.tags
}
