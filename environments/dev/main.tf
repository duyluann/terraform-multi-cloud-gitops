# Environment-specific variables
locals {
  environment = "dev"
  tags = {
    Environment = local.environment
    ManagedBy   = "terraform"
  }
}

# GCP Storage
module "gcp_storage" {
  source = "../../modules/storage/gcp"
  count  = var.enable_gcp ? 1 : 0

  project_id    = var.gcp_project_id
  environment   = local.environment
  region        = var.gcp_region
  force_destroy = true
  tags          = local.tags
}

# AWS Storage
module "aws_storage" {
  source = "../../modules/storage/aws"
  count  = var.enable_aws ? 1 : 0

  project_id    = var.aws_account_id
  environment   = local.environment
  region        = var.aws_region
  force_destroy = true
  tags          = local.tags
}

# Azure Storage
module "azure_storage" {
  source = "../../modules/storage/azure"
  count  = var.enable_azure ? 1 : 0

  project_id          = var.azure_subscription_id
  environment         = local.environment
  region              = var.azure_region
  resource_group_name = var.azure_resource_group_name
  force_destroy       = true
  tags                = local.tags
}
