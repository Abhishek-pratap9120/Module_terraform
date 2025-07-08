data "azurerm_subnet" "subnet_data" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

data "azurerm_public_ip" "data_pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
}

data "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.rg_name
}
data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}
data "azurerm_key_vault_secret" "kv_username" {
  name         = var.username
  key_vault_id = data.azurerm_key_vault.kv.id
}
data "azurerm_key_vault_secret" "kv_password" {
  name         = var.user_password
  key_vault_id = data.azurerm_key_vault.kv.id
}