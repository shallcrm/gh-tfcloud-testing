##############################################################
#### VPC Network Security Group and Rules descriptions    ####
##############################################################

# Define network security group for public internet-facing subnet (without inline security rules)
resource "azurerm_network_security_group" "pub_sec_grp" {
    name                         = "test_vnet_public_security_group"
    location                     = "${azurerm_resource_group.test_rg.location}"
    resource_group_name          = "${azurerm_resource_group.test_rg.name}"
    tags = {
        project                  = "tfcloud_testing"
    }
}


# Define network security group for private internal subnet (without inline security rules)
resource "azurerm_network_security_group" "prv_sec_grp" {
    name                         = "test_vnet_private_security_group"
    location                     = "${azurerm_resource_group.test_rg.location}"
    resource_group_name          = "${azurerm_resource_group.test_rg.name}"
    tags = {
        project                  = "tfcloud_testing"
    }
}


# Define security rules for public internet facing security group

# Allow ingress traffic for ssh traffic on TCP port 22
resource "azurerm_network_security_rule" "rule_ssh" {
    name                         = "ssh"                                   //  Rule name
    description                  = "Allow ssh ingress"                     //  Rule description
    priority                     = 100                                     //  Rule priority
    direction                    = "Inbound"                               //  Direction of traffic - Inbound or Outbound
    access                       = "Allow"                                 //  Allow or Deny
    protocol                     = "Tcp"                                   //  Protocol
    source_port_range            = "*"                                     //  Source port (range)
    destination_port_range       = "22"                                    //  Destination port (range)
    source_address_prefix        = "*"                                     //  Source address range
    destination_address_prefix   = "*"                                     //  Destination address range
    resource_group_name          = "${azurerm_resource_group.test_rg.name}"               //  Resource group name
    network_security_group_name  = "${azurerm_network_security_group.pub_sec_grp.name}"   //  Network security group name
}

# Allow ingress traffic for http traffic on TCP port 80
resource "azurerm_network_security_rule" "rule_http" {
    name                         = "http"                                  //  Rule name
    description                  = "Allow http ingress"                    //  Rule description
    priority                     = 200                                     //  Rule priority
    direction                    = "Inbound"                               //  Direction of traffic - Inbound or Outbound
    access                       = "Allow"                                 //  Allow or Deny
    protocol                     = "Tcp"                                   //  Protocol
    source_port_range            = "*"                                     //  Source port (range)
    destination_port_range       = "80"                                    //  Destination port (range)
    source_address_prefix        = "*"                                     //  Source address range
    destination_address_prefix   = "*"                                     //  Destination address range
    resource_group_name          = "${azurerm_resource_group.test_rg.name}"               //  Resource group name
    network_security_group_name  = "${azurerm_network_security_group.pub_sec_grp.name}"   //  Network security group name
}

# Allow ingress traffic for ping traffic - ICMP message type 8 ....   ERROR with protocol = "Icmp"
# resource "azurerm_network_security_rule" "rule_ping" {
#     name                         = "ping"                                  //  Rule name
#     description                  = "Allow ping ingress"                    //  Rule description
#     priority                     = 300                                     //  Rule priority
#     direction                    = "Inbound"                               //  Direction of traffic - Inbound or Outbound
#     access                       = "Allow"                                 //  Allow or Deny
#     protocol                     = "Icmp"                                  //  Protocol
#     source_port_range            = "*"                                     //  Source port (range)
#     destination_port_range       = "8"                                     //  Destination port (range)
#     source_address_prefix        = "*"                                     //  Source address range
#     destination_address_prefix   = "*"                                     //  Destination address range
#     resource_group_name          = "${azurerm_resource_group.test_rg.name}"               //  Resource group name
#     network_security_group_name  = "${azurerm_network_security_group.pub_sec_grp.name}"   //  Network security group name
# }

