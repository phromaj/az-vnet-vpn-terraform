
resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "VM1"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_D2s_v3"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }

  computer_name  = "vm1"
  admin_username = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  network_interface_ids = [
    # Assuming you have a network interface created, add the ID here.
  ]

}

resource "azurerm_linux_virtual_machine" "vm2" {
  name                = "VM2"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_D2s_v3"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }

  computer_name  = "vm2"
  admin_username = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  network_interface_ids = [
    # Assuming you have a network interface created, add the ID here.
  ]

}
