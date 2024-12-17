# Define variables
variable "subscription_id" {
  type    = string
  default = "b962a1aa-8d4f-477b-b606-d88d4bbbcfe1"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the VM"
  type        = string
  default = "terraform"
}

variable "location" {
  description = "The Azure region in which to create the VM"
  type        = string
  default = "West US"
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
  default = "Virtual_Server"
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_DS1_v2"  # Change this to the desired VM size
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
  default = "jothba"
}

variable "admin_password" {
  description = "The admin password for the VM"
  type        = string
  default = "Admin@1234567"
}
