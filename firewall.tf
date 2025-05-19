resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rsg.name
  virtual_network_name = module.vm2.vnet_name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_public_ip" "firewall_ip" {
  name                = "firewall_ip"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.rsg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
  name                = "firewall"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.rsg.name

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  ip_configuration {
    name                 = "firewall-ipconfig"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_ip.id
  }
}
resource "azurerm_firewall_network_rule_collection" "firewall_rules" {
  name                = "Allow-VNet1-VNet3"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rsg.name
  priority            = 100
  action              = "Allow"

  rule {
    name                  = "vnet1-to-vnet3"
    source_addresses      = ["10.0.0.0/16"]
    destination_addresses = ["10.2.0.0/16"]
    destination_ports     = ["*"]
    protocols             = ["Any"]
  }

  rule {
    name                  = "vnet3-to-vnet1"
    source_addresses      = ["10.2.0.0/16"]
    destination_addresses = ["10.0.0.0/16"]
    destination_ports     = ["*"]
    protocols             = ["Any"]
  }
}
resource "azurerm_firewall_network_rule_collection" "allow_rdp" {
  name                = "Allow-RDP"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rsg.name
  priority            = 200
  action              = "Allow"

  rule {
    name                  = "rdp-rule"
    source_addresses      = ["*"]
    destination_addresses = ["*"]
    destination_ports     = ["3389"]
    protocols             = ["TCP"]
  }
}
resource "azurerm_firewall_network_rule_collection" "allow_icmp" {
  name                = "Allow-ICMP"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rsg.name
  priority            = 150
  action              = "Allow"

  rule {
    name                  = "icmp-between-vnets"
    source_addresses      = ["*"] 
    destination_addresses = ["*"]
    destination_ports     = ["*"]
    protocols             = ["Any"] 
  }
}

