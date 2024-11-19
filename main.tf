terraform { 
  cloud { 
    
    organization = "INDVIK" 

    workspaces { 
      name = "VIk-VM-Deployment" 
    } 
  } 
}


provider "azurerm" {
  features {}
  subscription_id = "e2ea6760-e0a3-428c-a8a0-9cf97fd3ff16"
  client_id       = "2c985762-2025-4a1f-9282-6f3a48da1048"
  client_secret   = var.client_secret
  tenant_id       = "11fa1867-3ed1-4f68-95c4-2ef401fd7a5c"
}


resource "azurerm_public_ip" "example" { 
name = "ubuntu-pip" 
location = var.location 
resource_group_name = var.resource_group_name 
allocation_method = "Dynamic" 
sku = "Basic"
}

resource "azurerm_network_interface" "example" {
  name                = "ubuntu-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_virtual_machine" "example" {
  name                  = "ubuntu-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = "Standard_DS2_v2"

  storage_os_disk {
    name              = "ubuntu-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "ubuntu-vm"
    admin_username = var.vm_admin_username
    admin_password = var.vm_admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
  
}




