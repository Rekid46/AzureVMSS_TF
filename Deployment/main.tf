# Resource Group

resource "azurerm_resource_group" "vmss-rg" {
  name     = var.resource-group-name
  location = var.location
  tags = {
    environment = var.environment
  }
}

# Network

module "vmss_network" {
  source              = "../Modules/Network"
  vnet_name           = var.vnet-name
  subnet_name         = var.subnet-name
  resource_group_name = azurerm_resource_group.vmss-rg.name
  vmss-vnet-cidr      = var.vmss-vnet-cidr
  vmss-subnet-cidr    = var.vmss-subnet-cidr
  location            = var.location
}

# VMSS

module "vmss" {
  source      = "../Modules/VMSS"
  vmss_name   = "${var.prefix}-${var.environment}-vmss"
  environment = var.environment
  location    = var.location
  resource_group_name = azurerm_resource_group.vmss-rg.name
  subnet_id  = module.vmss_network.network_vmss_subnet_id

}