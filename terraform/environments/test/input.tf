variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

# Resource Group/Location
variable "location" {}
variable "resource_group" {}
variable "application_type" {}

# Network
variable "address_prefix_test" {}
variable "address_space" {}
variable "address_prefixes" {}

#VM
variable "packer_image_name" {
  description = "Name of the Packer image"
  default     = "udacity-devops-p3-LinuxImage"
}

variable "packer_image_resource_group" {
  description = "Resource group name of Packer image"
  default     = "Udacity-DevOps-P3"
}
