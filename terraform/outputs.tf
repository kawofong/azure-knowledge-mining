output "azure_search_service_name" {
  value = "${azurerm_search_service.km-search.name}"
}

# output "azure_cognitive_service_endpoint" {
#   value = "${azurerm_cognitive_account.km-cogservice.endpoint}"
# }

# output "azure_cognitive_service_primary_key" {
#   value = "${azurerm_cognitive_account.km-cogservice.primary_access_key}"
# }

output "azure_storage_name" {
  value = "${azurerm_storage_account.km-storage.name}"
}

output "azure_storage_primary_connection_string" {
  value = "${azurerm_storage_account.km-storage.primary_connection_string}"
}
