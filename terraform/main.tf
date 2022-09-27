provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {}
}
terraform {
  backend "azurerm" {
    resource_group_name  = "qrdevopsRG"
    storage_account_name = "tstate8969"
    container_name       = "tstate"
    key                  = "terraform.tfstate"
    access_key           = "cM+scolzJnuSsVkLgkxgKJgoisZZ5LFmM+ah+sfJDDeGT7A5lBFFSgbZwVo+HA9KTYmEsyZTrl6X+AStn9ATvQ=="
  }
}
module "resource_group" {
  source               = "./modules/resource_group"
  resource_group       = var.resource_group
  location             = var.location
}
module "network" {
  source               = "./modules/network"
  address_space        = var.address_space
  location             = var.location
  virtual_network_name = var.virtual_network_name
  application_type     = var.application_type
  resource_type        = "NET"
  resource_group       = module.resource_group.resource_group_name
  address_prefix_test  = var.address_prefix_test
  demo                 = var.demo
}

module "nsg-test" {
  source              = "./modules/networksecuritygroup"
  location            = var.location
  application_type    = var.application_type
  resource_type       = "NSG"
  resource_group      = module.resource_group.resource_group_name
  subnet_id           = module.network.subnet_id_test
  address_prefix_test = var.address_prefix_test
  demo                = var.demo
}
module "appservice" {
  source           = "./modules/appservice"
  location         = var.location
  application_type = var.application_type
  resource_type    = "AppService"
  resource_group   = module.resource_group.resource_group_name
  demo             = var.demo
}
module "publicip" {
  source           = "./modules/publicip"
  location         = var.location
  application_type = var.application_type
  resource_type    = "publicip"
  resource_group   = module.resource_group.resource_group_name
  demo             = var.demo
}

module "vm" {
  source                    = "./modules/vm" 
  location                  = var.location
  application_type          = var.application_type
  resource_group            = module.resource_group.resource_group_name
  resource_type             = "VM"
  subnet_id                 = module.network.subnet_id_test
  vm_admin_user             = var.vm_admin_user
  public_ip_address_id      = module.publicip.public_ip_address_id
  demo                      = var.demo
}