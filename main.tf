provider "azurerm" {
  # Configure your Azure provider details here
}

resource "azurerm_virtual_machine" "c8_vm" {
  name                  = "c8"
  location              = "<Azure region>"
  resource_group_name   = "<resource_group_name>"
  vm_size               = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.c8_nic.id]

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  os_disk {
    name              = "c8-os-disk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "c8.local"
    admin_username = "<admin_username>"
    admin_password = "<admin_password>"
  }
}

resource "azurerm_virtual_machine" "u21_vm" {
  name                  = "u21"
  location              = "<Azure region>"
  resource_group_name   = "<resource_group_name>"
  vm_size               = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.u21_nic.id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "21.04-LTS"
    version   = "latest"
  }

  os_disk {
    name              = "u21-os-disk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "u21.local"
    admin_username = "<admin_username>"
    admin_password = "<admin_password>"
  }
}

resource "azurerm_network_interface" "c8_nic" {
  name                = "c8-nic"
  location            = "<Azure region>"
  resource_group_name = "<resource_group_name>"
}

resource "azurerm_network_interface" "u21_nic" {
  name                = "u21-nic"
  location            = "<Azure region>"
  resource_group_name = "<resource_group_name>"
}
