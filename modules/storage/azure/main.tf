resource "azurerm_storage_account" "storage" {
  name                     = replace("${var.project_id}${var.environment}storage", "-", "")
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  # Disable public access
  allow_nested_items_to_be_public = false

  # Enable blob service logging
  blob_properties {
    versioning_enabled = true
    container_delete_retention_policy {
      days = 7
    }
  }

  # Enable queue service logging
  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 7
    }
  }

  tags = merge(var.tags, {
    Environment = var.environment
    ManagedBy   = "terraform"
  })
}

resource "azurerm_storage_container" "container" {
  name                  = "${var.environment}-container"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
