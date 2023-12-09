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
  name                  = "${var.application_type}-LinuxVirtualMachine"
  location              = var.location
  resource_group_name   = var.resource_group
  size                  = "Standard_DS2_v2"
  admin_username        = "adminuser"
  admin_password        = "Password11-+"
  network_interface_ids = [azurerm_network_interface.test.id]
  source_image_id       = var.source_image_id
  admin_ssh_key {
    username   = "phuctd"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbIIqqpNAc11RfbJa7d2Sv5E8FuBofJToFsvw2sRJWtIkgtSLqmkX7/02EsdbeTKPPEeTNPPnxYCg9FYS79Hw45nR2R1p8+erjWZiQ1zy0sqUrIj6Bsi4gwbL51jqLvasGtgdTgDBpdu0L9DKt6C1usbHGsXxZH/KIA5tM1afKNjRiJ+me980cBuo/npWrCjkSusUmlygo/82yN2nIqZ4wiyDzpZk56IXvy9lyMsapLfECZnyvMyh5sCbyaJy/mLGCtNc++hNz9X7paYAnL9mzkcMjdVqdQgYC8r3aO59v8hox6OVfiU1fimEbM1T1x5Vu2Z2tV08+eItIDbo4NkzT"
  }
  os_disk {
    name                 = "${var.application_type}-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
