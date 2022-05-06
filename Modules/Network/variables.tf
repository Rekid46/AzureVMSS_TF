##############################
## Core Network - Variables ##
##############################
variable "vnet_name" {
  type        = string
  description = "name of the vnet that this subnet will belong to"
  default     = "VMSS-vnet"
}

variable "subnet_name" {
  type        = string
  description = "name to give the subnet"
  default     = "default-subnet"
}

variable "vmss-vnet-cidr" {
  type        = string
  description = "The CIDR of the network VNET"
}

variable "vmss-subnet-cidr" {
  type        = string
  description = "The CIDR for the vm subnet"
}

variable "nsg_name" {
  type        = string
  description = "The Network Security Group Name"
  default     = "VMSS-subnet"
}

variable "environment" {
  type        = string
  description = "Default Environment"
  default     = "dev"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
  default     = "vmss_rg"
}

variable "location" {
  type        = string
  description = "Resource Group name"
  default     = "eastus"
}