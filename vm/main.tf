resource "azurerm_virtual_machine" "vm1" {
  name                  = "myVM1"
  location              = var.location
  resource_group_name   = var.resource_group_name
  vm_size               = "Standard_D1_v2"

  storage_os_disk {
    name              = "myOsDisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "hostName1"
    admin_username = "testadmin"
    admin_password = "Password123!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  network_interface_ids = [var.network_interface_id_1]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine" "vm2" {
  # ... (same as vm1, but adjust names, and use network_interface_id_2)
}

