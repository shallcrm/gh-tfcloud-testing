##############################################################
#### VPC Subnet resource descriptions                     ####
##############################################################

# Create a subnet 
resource "azurerm_subnet" "subnet_1" {
  name                 = "mas-subnet-1"                         //  Subnet name
  resource_group_name  = azurerm_resource_group.test_rg.name    //  Resoure group name
  virtual_network_name = azurerm_virtual_network.test_vnet.name //  Virtual network in which to create subnets
  address_prefixes     = ["10.10.1.0/24"]                       //  CIDR block (within overall VPC IP address space)
}


# Create a subnet 
resource "azurerm_subnet" "subnet_2" {
  name                 = "mas-subnet-2"                         //  Subnet name
  resource_group_name  = azurerm_resource_group.test_rg.name    //  Resoure group name
  virtual_network_name = azurerm_virtual_network.test_vnet.name //  Virtual network in which to create subnets
  address_prefixes     = ["10.10.2.0/24"]                       //  CIDR block (within overall VPC IP address space)

}
