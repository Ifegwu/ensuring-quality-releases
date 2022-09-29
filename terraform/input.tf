# Azure GUIDS
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

# Resource Group/Location
variable "location" {}
variable "resource_group" {}
variable "application_type" {}

# Network
variable "virtual_network_name" {}
variable "address_prefix_test" {
    default = "10.5.1.0/24" 
}
variable "address_space" {}

# VM
variable "vm_admin_user" {
    default = "azureadmin"
}

variable "demo" {}