############################################################################
####  Azure VM - Definition of Azure Virtual Machine resources          ####
############################################################################


# Create Ubuntu Server in Availabliity Zone 1 on subnet 1 (public)

# Create public IP address
resource "azurerm_public_ip" "ip_1" {
    name                       = "mas-ip-1"
    location                   = "${azurerm_resource_group.test_rg.location}"    //  Location for the resource
    resource_group_name        = "${azurerm_resource_group.test_rg.name}"        //  Resource group name
    allocation_method          = "Static"                                        //  Public IP address type - Dynamic or Static 
    zones                      = ["1"]                                           //  Availablity zone 
    sku                        = "Standard"                                      //  Standard SKU required for AZ support 
    tags = {
        project                = "tfcloud_testing"
    }
}

# Create network interface for the VM
resource "azurerm_network_interface" "nic_1" {
    name                       = "mas-nic-1"
    location                   = "${azurerm_resource_group.test_rg.location}"    //  Location for the resource
    resource_group_name        = "${azurerm_resource_group.test_rg.name}"        //  Resource group name
    ip_configuration {                                                           
        name                           = "ip-configuration-1"                    //  Name of IP configuration
        subnet_id                      = "${azurerm_subnet.subnet_1.id}"      //  Subnet for the IP address 
        private_ip_address_allocation  = "Dynamic"                               //  Private IP address type - Dynamic or Static      
        private_ip_address_version     = "IPv4"                                  //  Private IP address type - default is IPv4
        public_ip_address_id           =  "${azurerm_public_ip.ip_1.id}"      //  Public IP address 
    }
}

# Associate network interface with network security group
resource "azurerm_network_interface_security_group_association" "nic_nsg_1" {
  network_interface_id      = azurerm_network_interface.nic_1.id
  network_security_group_id = azurerm_network_security_group.pub_sec_grp.id
}

# Create virtual machine
resource "azurerm_virtual_machine" "vm_1" {
    name                       = "mas-az1-vm-1"                                  //  Virtual machine name
    location                   = "${azurerm_resource_group.test_rg.location}"    //  Location for the resource
    resource_group_name        = "${azurerm_resource_group.test_rg.name}"        //  Resource group name
    network_interface_ids      = ["${azurerm_network_interface.nic_1.id}"]       //  Network interface(s)
    vm_size                    = "Standard_B1s"                                  //  VM size : Balanced burtstable 1 vCPU 1 GB RAM
    zones                      = ["1"]                                           //  Availablity zone 

    depends_on = [
      azurerm_network_interface_security_group_association.nic_nsg_1
    ]

    delete_os_disk_on_termination    = true                                      //  Delete the OS disk automatically when deleting the VM
    delete_data_disks_on_termination = true                                      //  Delete the data disks automatically when deleting the VM

    storage_image_reference {                                                    //  Standard VM image 
        publisher              = "Canonical"
        offer                  = "0001-com-ubuntu-server-jammy"
        sku                    = "22_04-lts"                                     //  Ubuntu Server 22.04 LTS
        version                = "latest"
    }
    storage_os_disk {                                                            //  OS disk
        name                   = "mas-az1-vm-1-osdisk"                           //  Name for OS disk 
        caching                = "ReadWrite"                                     //  Caching type 
        create_option          = "FromImage"                                     //  Create from image (or attach VHD)
        managed_disk_type      = "Standard_LRS"                                  //  Disk type 
#        disk_size_gb           = "20"                                           //  Disk size (default defined by image)
    }
    os_profile {
        computer_name          = "mas-az1-vm-1"                                  //  Hostname
        admin_username         = "ansible"                                       //  Admin user to be created
    }
    os_profile_linux_config {
        disable_password_authentication = true                                   //  Passwords authentication disabled - will require SSH key access
        ssh_keys {                                                               //  //  SSH public key value
            key_data           = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDlRL+oidf4TgYRYobJwq5xLLkDr14dX+sXHJ3EcCTp/QjZx4sZTATvhTscSi4e/5+1bE6elpxVup7pD8d4VjNjykuacdYFWoWYY/2ytawfj5vgRVBtXuNgFJTwy2DGEq6J23vJsBxTtap9ke4dq4f0fliKAiKI292gj2z0HmX0l1hfarQPsWciZ2p9Dn8iIjer3aitWajSOcnfD+ZDoOmPDSX4Ed70eMYQBvOsYC+KQsCQU2pryPlotgk9w9qc2wO6y3xN8uTQ4DwwBPz+x1OStXgRWPS/4d7QdPJ4HdNRAGNiWVnX3/MOFyUrG9GNEgPxTchv84sG1VBx6bLGxREgIAS+4SNilDB4RYD3ZCviqNw9rUfEnfHI5apUtd2aOSCZJ7b11Zj4mvPJEZVwiS8S5cZB3HinwNRVSGRhU2tBK0O+nXZdI0o/3w8zozscV4nq9GREDWKPjrD4dqcL5BDhWIcD4WxergXXI9jIttlR9AtKfHT/lQiR2muO3QGGN/xXilc7QD5h07w2KIuQa3YBZwDmXetI5iJt5P8hjOPwQFuQpx36Md0diD0oh4PQEKpfjqJgJcOKriFg7Vhp60hoQRQSENce3yPCZWTnWleG2YDGe5Cw1Q32tl8dOTB0K2u0twMcEaN3224jL+/24Kk7M8+hjuBS3Qohtip1iLy8LQ== m.a.shallcross@gmail.com"      
            path               = "/home/ansible/.ssh/authorized_keys"            //  Path to store public key
        }
    }
    tags = {
        project                = "tfcloud_testing"
    } 
}


# # Create Ubuntu Server in Availabliity Zone 2 on subnet 1 (public)

# # Create public IP address
# resource "azurerm_public_ip" "ip_2" {
#     name                       = "mas-ip-2"
#     location                   = "${azurerm_resource_group.test_rg.location}"    //  Location for the resource
#     resource_group_name        = "${azurerm_resource_group.test_rg.name}"        //  Resource group name
#     allocation_method          = "Static"                                        //  Public IP address type - Dynamic or Static 
#     zones                      = ["2"]                                           //  Availablity zone 
#     sku                        = "Standard"                                      //  Standard SKU required for AZ support 
#     tags = {
#         project                = "tfcloud_testing"
#     }
# }

# # Create network interface for the VM
# resource "azurerm_network_interface" "nic_2" {
#     name                       = "mas-nic-2"
#     location                   = "${azurerm_resource_group.test_rg.location}"    //  Location for the resource
#     resource_group_name        = "${azurerm_resource_group.test_rg.name}"        //  Resource group name
#     ip_configuration {                                                           
#         name                           = "ip-configuration-2"                    //  Name of IP configuration
#         subnet_id                      = "${azurerm_subnet.subnet_1.id}"         //  Subnet for the IP address 
#         private_ip_address_allocation  = "Dynamic"                               //  Private IP address type - Dynamic or Static      
#         private_ip_address_version     = "IPv4"                                  //  Private IP address type - default is IPv4
#         public_ip_address_id           =  "${azurerm_public_ip.ip_2.id}"         //  Public IP address 
#     }
# }

# # Associate network interface with network security group
# resource "azurerm_network_interface_security_group_association" "nic_nsg_2" {
#   network_interface_id      = azurerm_network_interface.nic_2.id
#   network_security_group_id = azurerm_network_security_group.pub_sec_grp.id
# }

# # Create virtual machine
# resource "azurerm_virtual_machine" "vm_2" {
#     name                       = "mas-az2-vm-2"                                  //  Virtual machine name
#     location                   = "${azurerm_resource_group.test_rg.location}"    //  Location for the resource
#     resource_group_name        = "${azurerm_resource_group.test_rg.name}"        //  Resource group name
#     network_interface_ids      = ["${azurerm_network_interface.nic_2.id}"]       //  Network interface(s)
#     vm_size                    = "Standard_B1s"                                  //  VM size : Balanced burtstable 1 vCPU 1 GB RAM
#     zones                      = ["2"]                                           //  Availablity zone 
#
#     depends_on = [
#       azurerm_network_interface_security_group_association.nic_nsg_2
#     ]
#
#     delete_os_disk_on_termination    = true                                      //  Delete the OS disk automatically when deleting the VM
#     delete_data_disks_on_termination = true                                      //  Delete the data disks automatically when deleting the VM

#     storage_image_reference {                                                    //  Standard VM image 
#         publisher              = "Canonical"
#         offer                  = "0001-com-ubuntu-server-jammy"
#         sku                    = "22_04-lts"                                     //  Ubuntu Server 22.04 LTS
#         version                = "latest"
#     }
#     storage_os_disk {                                                            //  OS disk
#         name                   = "mas-az2-vm-2-osdisk"                           //  Name for OS disk 
#         caching                = "ReadWrite"                                     //  Caching type 
#         create_option          = "FromImage"                                     //  Create from image (or attach VHD)
#         managed_disk_type      = "Standard_LRS"                                  //  Disk type 
# #        disk_size_gb           = "20"                                           //  Disk size (default defined by image)
#     }
#     os_profile {
#         computer_name          = "mas-az2-vm-2"                                  //  Hostname
#         admin_username         = "ansible"                                       //  Admin user to be created
#     }
#     os_profile_linux_config {
#         disable_password_authentication = true                                   //  Passwords authentication disabled - will require SSH key access
#         ssh_keys {                                                               //  //  SSH public key value
#             key_data           = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDlRL+oidf4TgYRYobJwq5xLLkDr14dX+sXHJ3EcCTp/QjZx4sZTATvhTscSi4e/5+1bE6elpxVup7pD8d4VjNjykuacdYFWoWYY/2ytawfj5vgRVBtXuNgFJTwy2DGEq6J23vJsBxTtap9ke4dq4f0fliKAiKI292gj2z0HmX0l1hfarQPsWciZ2p9Dn8iIjer3aitWajSOcnfD+ZDoOmPDSX4Ed70eMYQBvOsYC+KQsCQU2pryPlotgk9w9qc2wO6y3xN8uTQ4DwwBPz+x1OStXgRWPS/4d7QdPJ4HdNRAGNiWVnX3/MOFyUrG9GNEgPxTchv84sG1VBx6bLGxREgIAS+4SNilDB4RYD3ZCviqNw9rUfEnfHI5apUtd2aOSCZJ7b11Zj4mvPJEZVwiS8S5cZB3HinwNRVSGRhU2tBK0O+nXZdI0o/3w8zozscV4nq9GREDWKPjrD4dqcL5BDhWIcD4WxergXXI9jIttlR9AtKfHT/lQiR2muO3QGGN/xXilc7QD5h07w2KIuQa3YBZwDmXetI5iJt5P8hjOPwQFuQpx36Md0diD0oh4PQEKpfjqJgJcOKriFg7Vhp60hoQRQSENce3yPCZWTnWleG2YDGe5Cw1Q32tl8dOTB0K2u0twMcEaN3224jL+/24Kk7M8+hjuBS3Qohtip1iLy8LQ== m.a.shallcross@gmail.com"      
#             path               = "/home/ansible/.ssh/authorized_keys"            //  Path to store public key
#         }
#     }
#     tags = {
#         project                = "tfcloud_testing"
#     } 
# }

