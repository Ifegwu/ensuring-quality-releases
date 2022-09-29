# Azure GUIDS
variable "subscription_id" {}
variable "client_id" {
    default = "6672ba44-rf61-4865-a91w-01e3c04e41aa"
}
variable "client_secret" {
    default = "6672ba44-rf61-4865-a91w-01e3c04e41aa"
}
variable "tenant_id" {
    default = "6672ba44-rf61-4865-a91w-01e3c04e41aa"
}

# Resource Group/Location
variable "location" {
    default = "East US"
}
variable "resource_group" {}
variable "application_type" {
    default = "project3App"
}

# Network
variable "virtual_network_name" {
    default = "project3App-vnet"
}
variable "address_prefix_test" {
    default = "10.5.1.0/24" 
}
variable "address_space" {
    default = ["10.5.0.0/16"]
}

# VM
variable "vm_admin_user" {
    default = "azureadmin"
}

variable "demo" {
    default = "devops"
}