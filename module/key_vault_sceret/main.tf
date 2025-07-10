data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.rg_name
}
resource "azurerm_key_vault_secret" "kv_secret" {
  name         = var.secret_name                  #kis name se key vault bnega cloud me
  value        = var.secret_value        #user name or password k liye 
  key_vault_id = data.azurerm_key_vault.kv.id
}




