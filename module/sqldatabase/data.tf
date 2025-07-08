data "azurerm_mssql_server" "sqlserverdata" {
  name                = var.sql_server_name
  resource_group_name = var.rg_name
}