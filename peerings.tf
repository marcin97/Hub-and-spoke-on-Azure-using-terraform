resource "azurerm_virtual_network_peering" "vnet1tovnet2" {
  name                         = "vnet1tovnet2"
  resource_group_name          = azurerm_resource_group.rsg.name
  virtual_network_name         = module.vm1.vnet_name
  remote_virtual_network_id    = module.vm2.vnet_id
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "vnet2tovnet1" {
  name                         = "vnet2tovnet1"
  resource_group_name          = azurerm_resource_group.rsg.name
  virtual_network_name         = module.vm2.vnet_name
  remote_virtual_network_id    = module.vm1.vnet_id
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  allow_virtual_network_access = true
}


resource "azurerm_virtual_network_peering" "vnet3tovnet2" {
  name                         = "vnet3tovnet2"
  resource_group_name          = azurerm_resource_group.rsg.name
  virtual_network_name         = module.vm3.vnet_name
  remote_virtual_network_id    = module.vm2.vnet_id
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "vnet2tovnet3" {
  name                         = "vnet2tovnet3"
  resource_group_name          = azurerm_resource_group.rsg.name
  virtual_network_name         = module.vm2.vnet_name
  remote_virtual_network_id    = module.vm3.vnet_id
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  allow_virtual_network_access = true
}

