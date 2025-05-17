resource "azurerm_storage_account" "storage" {
  name                     = replace("${var.project_id}${var.environment}storage", "-", "")
  resource_group_name      = var.resource_group_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version         = "TLS1_2"

  tags = merge(
    var.tags,
    {
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  )
}

resource "azurerm_storage_container" "container" {
  name                  = "${var.environment}-container"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}