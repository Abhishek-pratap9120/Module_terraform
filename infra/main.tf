module "resource_group" {
  source      = "../module/resource_group"
  rg_name     = "abhirg"
  rg_location = "west us"
}
module "public_ip_frontend" {
  source       = "../module/public_ip"
  depends_on   = [module.resource_group]
  pip_name     = "frontendabhipip"
  pip_location = "west us"
  rg_name      = "abhirg"
}
module "public_ip_backend" {
  source       = "../module/public_ip"
  depends_on   = [module.resource_group]
  pip_name     = "backendabhipip"
  pip_location = "west us"
  rg_name      = "abhirg"
}
module "virtual_network" {
  source             = "../module/virtual_network"
  depends_on         = [module.resource_group]
  vnet_name          = "abhivent"
  vnet_location      = "west us"
  rg_name            = "abhirg"
  vent_address_space = ["10.0.0.0/16"]

}
module "frontend_subnet" {
  depends_on       = [module.virtual_network]
  source           = "../module/subnet"
  subnet_name      = "frontendsubnet"
  vnet_name        = "abhivent"
  rg_name          = "abhirg"
  address_prefixes = ["10.0.1.0/24"]

}

module "backend_subnet" {
  depends_on       = [module.virtual_network]
  source           = "../module/subnet"
  subnet_name      = "backendsubnet"
  vnet_name        = "abhivent"
  rg_name          = "abhirg"
  address_prefixes = ["10.0.2.0/24"]

}
module "frontend_nsg" {
  source       = "../module/nsg"
  depends_on   = [module.resource_group]
  nsg_name     = "frontendnsg"
  nsg_location = "west us"
  rg_name      = "abhirg"
}
module "backend_nsg" {
  source       = "../module/nsg"
  depends_on   = [module.resource_group]
  nsg_name     = "backendnsg"
  nsg_location = "west us"
  rg_name      = "abhirg"
}
# module "sql_server" {
#   source                       = "../module/sql_server"
#   depends_on                   = [module.resource_group, module.kv_vault, module.kv_sql_username, module.kv_sql_password]
#   sql_server_name              = "serverabhi9120"
#   rg_name                      = "abhirg"
#   sql_server_location          = "west us"
#   administrator_login          = "sqlserverlogin"
#   administrator_login_password = "sqlserverpassword"
#   kv_name                      = "abhi52089363"
# }
# module "sql_database" {
#   source            = "../module/sqldatabase"
#   depends_on        = [module.sql_server]
#   sql_database_name = "sqldataabhi"
#   sql_server_name   = "serverabhi9120"
#   rg_name           = "abhirg"
# }
module "kv_vault" {
  source      = "../module/key_vault"
  depends_on  = [module.resource_group]
  kv_name     = "abhi52089363"
  kv_location = "west us"
  rg_name     = "abhirg"
}
module "username" {
  source       = "../module/key_vault_sceret"
  depends_on   = [module.kv_vault]
  secret_name  = "vm-username"
  secret_value = "frontendabhi-vm"
  kv_name      = "abhi52089363"
  rg_name      = "abhirg"
}
module "password" {
  source       = "../module/key_vault_sceret"
  depends_on   = [module.kv_vault]
  secret_name  = "vm-password"
  secret_value = "Password@123"
  kv_name      = "abhi52089363"
  rg_name      = "abhirg"
}

module "frontend_vm" {
  source                = "../module/virtual_machine"
  depends_on            = [module.frontend_subnet, module.public_ip_frontend, module.resource_group, module.virtual_network, module.kv_vault, module.username, module.password]
  rg_name               = "abhirg"
  vm_name               = "frontendvm"
  vm_location           = "west us"
  nic_name              = "frontendabhinic"
  nic_location          = "west us"
  ip_configuration_name = "ipconfabhi"
  subnet_name           = "frontendsubnet"
  pip_name              = "frontendabhipip"
  vnet_name             = "abhivent"
  nsg_name              = "frontendnsg"
  kv_name               = "abhi52089363"
  username              = "vm-username"
  user_password         = "vm-password"

}
# module "kv_vault_backend" {
#   source      = "../module/key_vault"
#   depends_on  = [module.resource_group]
#   kv_name     = "abhi52089363"
#   kv_location = "west us"
#   rg_name     = "abhirg"
# }
module "username_backend" {
  source       = "../module/key_vault_sceret"
  depends_on   = [module.kv_vault]
  secret_name  = "vm-backendusername"
  secret_value = "backendabhi-vm"
  kv_name      = "abhi52089363"
  rg_name      = "abhirg"
}
module "backend_password" {
  source       = "../module/key_vault_sceret"
  depends_on   = [module.kv_vault]
  secret_name  = "vm-passwordbackend"
  secret_value = "Password@123"
  kv_name      = "abhi52089363"
  rg_name      = "abhirg"
}
module "backend_vm" {
  source                = "../module/virtual_machine"
  depends_on            = [module.backend_subnet, module.public_ip_backend, module.resource_group, module.virtual_network, module.kv_vault, module.username_backend, module.backend_password]
  rg_name               = "abhirg"
  vm_name               = "backendvm"
  vm_location           = "west us"
  nic_name              = "backendabhinic"
  nic_location          = "west us"
  ip_configuration_name = "ipconfabhi"
  subnet_name           = "backendsubnet"
  pip_name              = "backendabhipip"
  vnet_name             = "abhivent"
  nsg_name              = "backendnsg"
  kv_name               = "abhi52089363"
  username              = "vm-backendusername"
  user_password         = "vm-password_backend"
}

# module "kv_sql_username" {
#   source       = "../module/key_vault_sceret"
#   depends_on = [ module.kv_vault ]
#   secret_name  = "sqlserverlogin"
#   secret_value = "4dm1n157r470r"
#   kv_name      = "abhi52089363"
#   rg_name      = "abhirg"
# }
# module "kv_sql_password" {
#   source       = "../module/key_vault_sceret"
#   depends_on = [ module.kv_vault ]
#   secret_name  = "sqlserverpassword"
#   secret_value = "4-v3ry-53cr37-p455w0rd"
#   kv_name      = "abhi52089363"
#   rg_name      = "abhirg"
# }


