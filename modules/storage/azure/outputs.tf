output "storage_account_name" {
  description = "The name of the created storage account"
  value       = azurerm_storage_account.storage.name
}

output "storage_account_id" {
  description = "The ID of the created storage account"
  value       = azurerm_storage_account.storage.id
}

output "container_name" {
  description = "The name of the created container"
  value       = azurerm_storage_container.container.name
}