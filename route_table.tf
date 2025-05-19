resource "azurerm_route_table" "rt_vnet1" {
  name                = "rt-vnet1-to-vnet3"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.rsg.name
}

resource "azurerm_route" "route_to_vnet3" {
  name                   = "to-vnet3"
  resource_group_name    = azurerm_resource_group.rsg.name
  route_table_name       = azurerm_route_table.rt_vnet1.name
  address_prefix         = "10.2.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}

resource "azurerm_subnet_route_table_association" "assoc_vnet1" {
  subnet_id      = module.vm1.subnet_id
  route_table_id = azurerm_route_table.rt_vnet1.id
}

resource "azurerm_route_table" "rt_vnet3" {
  name                = "rt-vnet3-to-vnet1"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.rsg.name
}

resource "azurerm_route" "route_to_vnet1" {
  name                   = "to-vnet1"
  resource_group_name    = azurerm_resource_group.rsg.name
  route_table_name       = azurerm_route_table.rt_vnet3.name
  address_prefix         = "10.0.0.0/16"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
}

resource "azurerm_subnet_route_table_association" "assoc_vnet3" {
  subnet_id      = module.vm3.subnet_id
  route_table_id = azurerm_route_table.rt_vnet3.id
}
