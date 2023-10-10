resource "azurerm_subnet" "vnet1_vm_subnet" {
  name                 = "VmSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet1_id
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_network_interface" "vm1_nic" {
  name                = "vm1-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnet1_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_subnet" "vnet2_vm_subnet" {
  name                 = "VmSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet2_id
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_network_interface" "vm2_nic" {
  name                = "vm2-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnet2_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}


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
    azurerm_network_interface.vm1_nic.id  
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
    azurerm_network_interface.vm2_nic.id
  ]

}
