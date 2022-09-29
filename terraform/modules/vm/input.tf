# VM location
variable "location" {}
variable "application_type" {}
variable "resource_group" {}
variable "resource_type" {}
variable "vm_admin_user" {
    default = "azureadmin"
}
variable "resourceNumber" {
    description = "Number of resources which be created"
    default = 1
}

variable "public_ip_address_id" {
    default = "/subscriptions/3ca2aacf-c15c-4375-a828-0d64713c2e00/resourceGroups/devops3/providers/Microsoft.Network/publicIPAddresses/project3App-publicip"
}    
variable "subnet_id" {
    default = "/subscriptions/3ca2aacf-c15c-4375-a828-0d64713c2e00/resourceGroups/devops3/providers/Microsoft.Network/virtualNetworks/project3App-NET-subnet1"
}

variable "demo" {}