resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-NetworkInterface"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id_test
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                            = "${var.application_type}-LinuxVirtualMachine"
  location                        = var.location
  resource_group_name             = var.resource_group
  size                            = "Standard_DS2_v2"
  admin_username                  = "adminuser"
  admin_password                  = "Password11-+"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.test.id]
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    name                 = "${var.application_type}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
