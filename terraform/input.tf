# Azure GUIDS
variable "subscription_id" {}
variable "client_id" {
    default = ""
}
variable "client_secret" {
    default = ""
}
variable "tenant_id" {
    default = ""
}

# Resource Group/Location
variable "location" {
    default = ""
}
variable "resource_group" {
    default = ""
}
variable "application_type" {
    default = ""
}

# Network
variable "virtual_network_name" {
    default = ""
}
variable "address_prefix_test" {
    default = "" 
}
variable "address_space" {
    default = [""]
}

# VM
variable "vm_admin_user" {
    default = ""
}

variable "demo" {
    default = ""
}