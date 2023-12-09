provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "saudacitydevopsp3"
    container_name       = "udacity-devops-p3"
    key                  = "Udacity-DevOps-P3"
    access_key           = "2DKfVj1ZMMje7M8b2eoBvyqVeE3BCBZun5S7FpJ+Mf2OmK3qxfhDb0ui9vNSmiPy5kbV1e1PAuh6+AStTFDpGg=="
  }
}
module "resource_group" {
  source         = "../../modules/resourcegroup"
  resource_group = var.resource_group
  location       = var.location
}
module "network" {
  source           = "../../modules/network"
  address_space    = var.address_space
  location         = var.location
  application_type = var.application_type
  resource_type    = "NET"
  resource_group   = module.resource_group.resource_group_name
  address_prefixes = var.address_prefixes
}
module "nsg-test" {
  source              = "../../modules/networksecuritygroup"
  location            = var.location
  application_type    = var.application_type
  resource_type       = "NSG"
  resource_group      = module.resource_group.resource_group_name
  subnet_id           = module.network.subnet_id_test
  address_prefix_test = var.address_prefix_test
}
module "appservice" {
  source           = "../../modules/appservice"
  location         = var.location
  application_type = var.application_type
  resource_type    = "AppService"
  resource_group   = module.resource_group.resource_group_name
}
module "publicip" {
  source           = "../../modules/publicip"
  location         = var.location
  application_type = var.application_type
  resource_type    = "publicip"
  resource_group   = module.resource_group.resource_group_name
}
module "vm" {
  source                      = "../../modules/vm"
  location                    = var.location
  application_type            = var.application_type
  resource_group              = module.resource_group.resource_group_name
  public_ip_address_id        = module.publicip.public_ip_address_id
  subnet_id_test              = module.network.subnet_id_test
}
