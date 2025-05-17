terraform {
  required_version = ">= 1.0.0"

  backend "gcs" {
    bucket = "terraform-state-dev"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

# GCP Provider
provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# AWS Provider
provider "aws" {
  region = var.aws_region
}

# Azure Provider
provider "azurerm" {
  features {}
}

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

  project_id         = var.azure_subscription_id
  environment        = local.environment
  region             = var.azure_region
  resource_group_name = var.azure_resource_group_name
  force_destroy      = true
  tags               = local.tags
}