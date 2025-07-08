data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}
data "azurerm_key_vault_secret" "kv_sql_username" {
  name         = var.administrator_login
  key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "kv_sql_password" {
  name         = var.administrator_login_password
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.sql_server_location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.kv_sql_username.value    #"4dm1n157r470r"
  administrator_login_password = data.azurerm_key_vault_secret.kv_sql_password.value    #"4-v3ry-53cr37-p455w0rd"
}

