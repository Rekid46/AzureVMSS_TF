#################################
## Windows VM Scale Set - Main ##
#################################




# Create Windows Virtual Machine Scale Set
resource "azurerm_windows_virtual_machine_scale_set" "vmss" {
  name                = var.vmss_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku       = var.windows-vm-size
  instances = 1

  computer_name_prefix = var.windows-vm-hostname
  admin_username       = var.windows-admin-username
  admin_password       = var.windows-admin-password

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = var.windows-2019-sku
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "${var.windows-vm-hostname}-network"
    primary = true

    ip_configuration {
      name      = "${var.windows-vm-hostname}-internal"
      primary   = true
      subnet_id = var.subnet_id
    }
  }

  tags = {
    environment = var.environment
  }
}
