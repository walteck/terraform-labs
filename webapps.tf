resource "azurerm_resource_group" "webapps" {
   name         = "webapps"
   location     = var.loc
   tags         = var.tags
}

resource "random_string" "webapprnd" {
  length  = 8
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "azurerm_app_service_plan" "free" {
    name                = "plan-free-${var.webapplocs[count.index]}"
    location            = var.webapplocs[count.index]
    resource_group_name = azurerm_resource_group.webapps.name
    tags                = azurerm_resource_group.webapps.tags

    kind                = "Linux"
    reserved            = true
    sku {
        tier = "Free"
        size = "F1"
    }

    count               = 1
}

resource "azurerm_app_service" "duggee_app" {
    name                = "webapp-${random_string.webapprnd.result}-${var.webapplocs[count.index]}"
    location            = var.webapplocs[count.index]
    resource_group_name = azurerm_resource_group.webapps.name
    tags                = azurerm_resource_group.webapps.tags

    app_service_plan_id = element(azurerm_app_service_plan.free.*.id, count.index)

    count               = 1
}

/* resource "azurerm_provider_type" "terraformid" {
    count               = 3
    name                = "cosmeticname-count.index"
    location            = var.webapplocs[count.index]
    resource_group_name = azurerm_resource_group.webapps.name
    tags                = azurerm_resource_group.webapps.tags

    kind                = "Linux"
    sku {
        tier = "Free"
        size = "F1"
    }
} */

output "webapp_urls" {
  description = "url of the duggee webapps provisoned as a list - we only expect one."
  value       = azurerm_app_service.duggee_app.*.default_site_hostname
  depends_on  = [duggee_app]
}