# Configure the Azure provider
provider "azurerm" {
    version = "~>1.32.0"
}

# Create a new resource group
resource "azurerm_resource_group" "rg" {
    name     = "test-1-tf-rg"
    location = "Southeast Asia"
}


# create the app service plan 
resource "azurerm_app_service_plan" "asp" {
  name                = "test-1-tf-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind = "linux"
  reserved = true
  sku {
    tier= "Shared"
    size= "B1"
  }
}

# create the app service 
resource "azurerm_app_service" "app" {
  name                = "test-1-tf-appservice"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "PHP|7.3"
  }
  
  
}

# create mysql server 
resource "azurerm_mysql_server" "sqlserver" {
  name                = "test-1-tf-server"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    name= "B_Gen5_1"
    tier= "Basic"
    family= "Gen5"
    capacity= 1
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "<your id>"
  administrator_login_password = "<your password>"
  version                      = "5.7"
  ssl_enforcement              = "Enabled"
}

#create database for website 
resource "azurerm_mysql_database" "db" {
  name                = "test-1-tf-db"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.sqlserver.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# allows other azure services to use the sql server
resource "azurerm_mysql_firewall_rule" "fw1" {
  name                = "azureservices"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.sqlserver.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

# resource "null_resource" "scripting" {
#   depends_on = [
#     azurerm_app_service.app,
#     azurerm_mysql_database.db,
#     azurerm_mysql_firewall_rule.fw1,
#   ]
#   provisioner "local-exec" {
#     command = "bash deploy.sh"
#   }
# }

