resource "azurerm_network_security_group" "sg-rdp-connection" {
  name                = "allowrdpconnection"
  location            = azurerm_resource_group.rsg.location
  resource_group_name = azurerm_resource_group.rsg.name

  security_rule {
    name                       = "rdpport"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "ping"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
  name                       = "allow-out-icmp"
  priority                   = 110
  direction                  = "Outbound"
  access                     = "Allow"
  protocol                   = "Icmp"
  source_port_range          = "*"
  destination_port_range     = "*"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
}
}
resource "azurerm_network_interface_security_group_association" "nsgvm1" {
  network_interface_id      = module.vm1.nic
  network_security_group_id = azurerm_network_security_group.sg-rdp-connection.id
}
resource "azurerm_network_interface_security_group_association" "nsgvm2" {
  network_interface_id      = module.vm2.nic
  network_security_group_id = azurerm_network_security_group.sg-rdp-connection.id
}
resource "azurerm_network_interface_security_group_association" "nsgvm3" {
  network_interface_id      = module.vm3.nic
  network_security_group_id = azurerm_network_security_group.sg-rdp-connection.id
}