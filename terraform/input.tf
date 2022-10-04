# Azure GUIDS
variable "subscription_id" {
    default = "3ca2aacf-c15c-4375-a828-0d64713c2e00"
}
variable "client_id" {
    default = "7672ba44-ef61-4865-a91c-01e3c04741aa"
}
variable "client_secret" {
    default = "yD78Q~KSQO~xCTNBIAoZ37YKyLpQla4umQjQqaig"
}
variable "tenant_id" {
    default = "33e55062-7183-4ac7-b62b-3a2f4f351b3e"
}

# Resource Group/Location
variable "location" {}
variable "resource_group" {}
variable "application_type" {}

# Network
variable "virtual_network_name" {}
variable "address_prefix_test" {}
variable "address_space" {}

# VM
variable "vm_admin_user" {}

variable "demo" {}