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
  name                = "${var.application_type}-LinuxVirtualMachine"
  location            = var.location
  resource_group_name = var.resource_group
  size                = "Standard_DS2_v2"
  admin_username      = "adminuser"
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2IZ08M2Nregsr1EPMxRE7qGs4ih589lJJD7Rz0FhW+OlBbymKW1M0v2Ld3qQiXB9t/j06/DLX9DxP0k1SdV2uOID4fFhlEx7O9JYgeeUpD59wvlfGSdckCeNEpiaxWKWesww12tYASUTTrzXM13hbqHt/l1DNgYIfhwBrJXhftGx5G9KJTaLmPHcdK/N82u4L19sCApUG4KoCLdrbAwvG0Tugvj1Rtw6Y17oXruRLZa4iykueUBjhma/tTeYufvQPaRKisl8FLKLH6gQDoOxV9nkhdyDetJN7szYh0PsfFXEGY8wRmDkiZB6vev03zoEN3nVaU0d/hGgh5DUd84cAfSfdNEGz7UucC1mkShTdLs+01mrKZrCNvUApTJduCHEnmhnnxLzfOZBfBcvpL66ZhvUmfBXjOGbY4bqdfjLRNP6bbiJmsHgWI8Pgw3oyvRnshqwV1keT5tStchjbUVhMq9r+cQokRU0B+6pQh0HI3rJScecIysYS3ucZeUGM13ARzVKvQ8c0BT5KBhOopoCGSjCuF8kuKWerWuas9dq5bJsgbJOQQRfFcSY0T40EEP+0P3w1xKr91OzOuw4yk4ukTyquYxFpjHx+txE5U+TV/otCZgehG4nEwkOmGSWd5ja/HGfZl5UhMIgVNuExySilwfDNtiYuO6i41iVa3hfbzw=="
  }
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
