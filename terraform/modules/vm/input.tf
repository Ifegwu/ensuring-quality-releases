# VM location
variable "location" {}
variable "application_type" {}
variable "resource_group" {}
variable "resource_type" {}
variable "subnet_id" {}
variable "username" {}
variable "resourceNumber" {
    description = "Number of resources which be created"
    default = 2
}