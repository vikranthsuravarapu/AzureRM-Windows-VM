variable "location" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "client_secret" {
  description = "The ID of the subnet."
  type        = string
}


variable "subnet_id" {
  description = "The ID of the subnet."
  type        = string
}

variable "vm_admin_username" {
  description = "The admin username for the VM. small change"
  type        = string
  default     = "adminuser"
}

variable "vm_admin_password" {
  description = "The admin password for the VM."
  type        = string
}
