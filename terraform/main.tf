provider "azurerm" {
    version = "=1.33.1"
}

resource "azurerm_resource_group" "km-rg" {
  name     = "${var.prefix}-rg"
  location = "${var.location}"
}

resource "azurerm_storage_account" "km-storage" {
  name                     = "${replace(lower(var.prefix), "-", "")}storage"
  resource_group_name      = "${azurerm_resource_group.km-rg.name}"
  location                 = "${azurerm_resource_group.km-rg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "km-storage-container" {
  name                  = "${var.prefix}-container"
  resource_group_name   = "${azurerm_resource_group.km-rg.name}"
  storage_account_name  = "${azurerm_storage_account.km-storage.name}"
  container_access_type = "private"
}

resource "azurerm_search_service" "km-search" {
  name                = "${var.prefix}-search"
  resource_group_name = "${azurerm_resource_group.km-rg.name}"
  location            = "${azurerm_resource_group.km-rg.location}"
  sku                 = "standard"
}

## Azure general cognitive service account is not available through Terraform
# resource "azurerm_cognitive_account" "km-cogservice" {
#   name                = "${var.prefix}-cogservice"
#   location            = "${azurerm_resource_group.km-rg.location}"
#   resource_group_name = "${azurerm_resource_group.km-rg.name}"
#   kind                = "TextAnalytics"

#   sku {
#     name = "S0"
#     tier = "Standard"
#   }
# }

resource "azurerm_application_insights" "km-appinsight" {
  name                = "${var.prefix}-appinsight"
  location            = "${azurerm_resource_group.km-rg.location}"
  resource_group_name = "${azurerm_resource_group.km-rg.name}"
  application_type    = "Node.JS"
}

resource "azurerm_app_service_plan" "km-app-plan" {
  name                = "${var.prefix}-app-plan"
  location            = "${azurerm_resource_group.km-rg.location}"
  resource_group_name = "${azurerm_resource_group.km-rg.name}"
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "km-function" {
  name                      = "${var.prefix}-functions"
  location                  = "${azurerm_resource_group.km-rg.location}"
  resource_group_name       = "${azurerm_resource_group.km-rg.name}"
  app_service_plan_id       = "${azurerm_app_service_plan.km-app-plan.id}"
  storage_connection_string = "${azurerm_storage_account.km-storage.primary_connection_string}"
  version                   = "~2"
  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "10.14.1"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "${azurerm_application_insights.km-appinsight.instrumentation_key}"
  }
}