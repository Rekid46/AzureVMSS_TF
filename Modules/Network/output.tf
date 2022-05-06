######################
## Network - Output ##
######################

output "network_vnet" {
  value = azurerm_virtual_network.vmss-vnet
}

output "network_vmss_subnet" {
  value = azurerm_subnet.vmss-subnet
}

output "network_vmss_subnet_id" {
  value = azurerm_subnet.vmss-subnet.id
}