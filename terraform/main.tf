provider "azurerm" {
    version = "=1.33.0"
}

resource "azurerm_storage_account" "km-storage" {
  name                     = "${replace(lower(var.prefix), "-", "")}storage"
  resource_group_name      = "${azurerm_resource_group.km-rg.name}"
  location                 = "${azurerm_resource_group.km-rg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_resource_group" "km-rg" {
  name     = "${var.prefix}-rg"
  location = "${var.location}"
}

resource "azurerm_search_service" "km-search" {
  name                = "${var.prefix}-search"
  resource_group_name = "${azurerm_resource_group.km-rg.name}"
  location            = "${azurerm_resource_group.km-rg.location}"
  sku                 = "standard"
}

resource "azurerm_cognitive_account" "km-cogservice" {
  name                = "${var.prefix}-cogservice"
  location            = "${azurerm_resource_group.km-rg.location}"
  resource_group_name = "${azurerm_resource_group.km-rg.name}"
  kind                = "TextAnalytics"

  sku {
    name = "S0"
    tier = "Standard"
  }
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
}