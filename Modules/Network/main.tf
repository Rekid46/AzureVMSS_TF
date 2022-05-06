####################
## Network - Main ##
####################

# Create the network VNET
resource "azurerm_virtual_network" "vmss-vnet" {
  name                = var.vnet_name
  address_space       = [var.vmss-vnet-cidr]
  resource_group_name = var.resource_group_name
  location            = var.location
  tags = {
    environment = var.environment
  }
}

# Create a subnet for VMSS
resource "azurerm_subnet" "vmss-subnet" {
  name                 = var.subnet_name
  address_prefixes     = [var.vmss-subnet-cidr]
  virtual_network_name = azurerm_virtual_network.vmss-vnet.name
  resource_group_name  = var.resource_group_name
  service_endpoints    = ["Microsoft.Storage", "Microsoft.KeyVault"]
}

# Create Network Security Group to Access VM from Internet
resource "azurerm_network_security_group" "vmss-nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowRDP"
    description                = "Allow RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    description                = "Allow HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    description                = "Allow HTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}

# Associate the NSG with the Subnet
resource "azurerm_subnet_network_security_group_association" "vmss-nsg-association" {
  subnet_id                 = azurerm_subnet.vmss-subnet.id
  network_security_group_id = azurerm_network_security_group.vmss-nsg.id
}