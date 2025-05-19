resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rsg_name
  address_space       = var.adress
}
resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet_name
  resource_group_name  = var.rsg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefixes
}
resource "azurerm_public_ip" "my-public-ip" {
  name                = var.public_ip
  resource_group_name = var.rsg_name
  location            = var.location
  allocation_method   = "Static"
}
resource "azurerm_network_interface" "nic" {
  name                = var.nic
  location            = var.location
  resource_group_name = var.rsg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.my-public-ip.id
 
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.base_name
  resource_group_name = var.rsg_name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "diox"
  admin_password      = "Admin1234"
    network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "enable_rdp_and_icmp" {
  name                 = "EnableRDP"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = jsonencode({
    "commandToExecute" = "powershell -Command \"Enable-NetFirewallRule -DisplayGroup 'Remote Desktop'\""
    "commandToExecute": "powershell -ExecutionPolicy Unrestricted -Command \"New-NetFirewallRule -DisplayName 'ICMPv4-In' -Protocol ICMPv4 -Direction Inbound -Action Allow\""
  })
}

