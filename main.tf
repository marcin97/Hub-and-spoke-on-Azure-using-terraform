resource "azurerm_resource_group" "rsg" {
  name     = "hub_and_spoke"
  location = "West Europe"
}
module "vm1" {
  source           = "./vm"
  base_name        = "vm1"
  location         = "West Europe"
  rsg_name         = azurerm_resource_group.rsg.name
  vnet_name        = "vnet1"
  adress           = ["10.0.0.0/16"]
  subnet_name      = "subnet1"
  address_prefixes = ["10.0.1.0/24"]
  nic              = "nic1"
  public_ip        = "ip1"

}

module "vm2" {
  source           = "./vm"
  base_name        = "vm2"
  location         = "West Europe"
  rsg_name         = azurerm_resource_group.rsg.name
  vnet_name        = "vnet2"
  adress           = ["10.1.0.0/16"]
  subnet_name      = "subnet2"
  address_prefixes = ["10.1.1.0/24"]
  nic              = "nic2"
  public_ip        = "ip2"
}

module "vm3" {
  source           = "./vm"
  base_name        = "vm3"
  location         = "West Europe"
  rsg_name         = azurerm_resource_group.rsg.name
  vnet_name        = "vnet3"
  adress           = ["10.2.0.0/16"]
  subnet_name      = "subnet3"
  address_prefixes = ["10.2.1.0/24"]
  nic              = "nic3"
  public_ip        = "ip3"
}