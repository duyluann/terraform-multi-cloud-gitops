resource "random_string" "project_id" {
  length  = 8
  special = false
  upper   = false
}

locals {
  project_id = var.project_id != null ? var.project_id : random_string.project_id.result
}

resource "azurerm_storage_account" "storage" {
  name                            = "${var.project_id}${var.environment}storage"
  resource_group_name             = var.resource_group_name
  location                        = var.region
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  tags = merge(var.tags, {
    environment = var.environment
    managed_by  = "terraform"
  })

  blob_properties {
    versioning_enabled = true
    container_delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "${var.environment}-container"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_account_queue_properties" "queue_properties" {
  storage_account_id = azurerm_storage_account.storage.id

  logging {
    version               = "1.0"
    delete                = true
    read                  = true
    write                 = true
    retention_policy_days = 7
  }
}
