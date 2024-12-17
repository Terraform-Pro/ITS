# Create a new resource group
resource "azurerm_resource_group" "vm_project" {
  name     = var.resource_group_name
  location = var.location
}

# Create a virtual network for the VM
resource "azurerm_virtual_network" "tf" {
  name                = "${var.vm_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vm_project.location
  resource_group_name = azurerm_resource_group.vm_project.name
}

# Create a subnet within the virtual network
resource "azurerm_subnet" "pubsub" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.vm_project.name
  virtual_network_name = azurerm_virtual_network.tf.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a public IP address for the VM
resource "azurerm_public_ip" "p_ip" {
  name                = "${var.vm_name}-publicip"
  location            = azurerm_resource_group.vm_project.location
  resource_group_name = azurerm_resource_group.vm_project.name
  allocation_method   = "Dynamic"
}

# Create a network interface for the VM
resource "azurerm_network_interface" "nf_i" {
  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.vm_project.location
  resource_group_name = azurerm_resource_group.vm_project.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.pubsub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.p_ip.id
  }
}

# Create the virtual machine
resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = azurerm_resource_group.vm_project.location
  resource_group_name   = azurerm_resource_group.vm_project.name
  network_interface_ids = [azurerm_network_interface.nf_i.id]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "dev"
  }
}