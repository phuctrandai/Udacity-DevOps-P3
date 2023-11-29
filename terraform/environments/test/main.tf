provider "azurerm" {
  skip_provider_registration = true
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "saudacitydevopsp3"
    container_name       = "udacity-devops-p3"
    key                  = "Udacity-DevOps-P3"
    access_key           = "9HC3U2sGHWHq2GL8qYchVND532njIw595BRass1fcJSn3Ylu1VRZU33FQDY5sBVGHn0PWWsrLXuf+ASt8z/iVA=="
  }
}
module "network" {
  source           = "../../modules/network"
  address_space    = var.address_space
  location         = var.location
  application_type = var.application_type
  resource_type    = "NET"
  resource_group   = var.resource_group
  address_prefixes = var.address_prefixes
}
module "nsg-test" {
  source              = "../../modules/networksecuritygroup"
  location            = var.location
  application_type    = var.application_type
  resource_type       = "NSG"
  resource_group      = var.resource_group
  subnet_id           = module.network.subnet_id_test
  address_prefix_test = var.address_prefix_test
}
module "appservice" {
  source           = "../../modules/appservice"
  location         = var.location
  application_type = var.application_type
  resource_type    = "AppService"
  resource_group   = var.resource_group
}
module "publicip" {
  source           = "../../modules/publicip"
  location         = var.location
  application_type = var.application_type
  resource_type    = "publicip"
  resource_group   = var.resource_group
}
module "vm" {
  source               = "../../modules/vm"
  location             = var.location
  application_type     = var.application_type
  resource_group       = var.resource_group
  public_ip_address_id = module.publicip.public_ip_address_id
  subnet_id_test       = module.network.subnet_id_test
}
