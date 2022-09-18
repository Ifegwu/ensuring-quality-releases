resource "azurerm_network_interface" "test" {
  count               = "${var.resourceNumber}"
  name                = "${var.application_type}-${count.index}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  count                 = "${var.resourceNumber}"
  name                  = "${var.application_type}-${count.index}-VM"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group}"
  size                  = "Standard_B1s"
  admin_username        = "${var.vm_admin_user}"
  network_interface_ids = [element(azurerm_network_interface.test.*.id, count.index)]
  admin_ssh_key {
    username   = "${var.vm_admin_user}"
    public_key = file("/home/${var.vm_admin_user}/.ssh/id_rsa.pub")
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
