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
  tags = {
    demo = var.demo
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  count                 = "${var.resourceNumber}"
  name                  = "${var.application_type}-${count.index}-VM"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group}"
  size                  = "Standard_B1s"
  admin_username        = "${var.vm_admin_user}"
  # network_interface_ids = [zurerm_network_interface.test.id]
  network_interface_ids = [element(azurerm_network_interface.test.*.id, count.index)]
  admin_ssh_key {
    username   = "${var.vm_admin_user}"
   #public_key = file("/home/${var.vm_admin_user}/.ssh/id_rsa.pub")
   public_key = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1A1wSSJHY6uqogNJd+T1m+B9q14QJAy1Pj+HZ3wJ41lbMavEwzX/quexa+X6niENryG3x/Ba9gk64DgAh/mE/6ZknExv/z6sUw4UAkuaRuFCSs9b2xehBMgQxg7ojnz5JDrdoeDYNrEmU2cvKDZy0XdgQXbeyt89pFk7c6UdHuVnK+UtTLeu2NRsQowgSLbblrlcNtEioCDmUg49jTfwpZaD74K+jaaVZO1v8DGbfgQfHej9XNEXHK5sQ1mfz3dYxq+2LgCxdhIpLMWriGCPtzAfpzhi7F6pBiI2WxfG5T8Q8s9nLeZEdv0WdLqTFWIxUnc7jCLyfgzh6Zm6E45tt akwari@akwari-Dell-System-XPS-L502X'
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
