##############################################################
#### VPC - Declarations of new Virtual Network            ####
##############################################################

# Create a new Virtal Network (in region / location defined in resource group block)

resource "azurerm_virtual_network" "test_vnet" {
    name                = "mas-vnet"                                //  Name for my virtual network
    resource_group_name = "${azurerm_resource_group.test_rg.name}"     //  Resoure group name
    location            = "${azurerm_resource_group.test_rg.location}" //  Location for the virtual network 
    address_space       = ["10.10.0.0/16"]                             //  IP V4 address range
    tags = {
        project         = "tfcloud_testing"
    }
}