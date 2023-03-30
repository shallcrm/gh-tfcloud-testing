##########################################################################
#### OUTPUTS - Output variables related to resources just provisioned ####
##########################################################################

# VM 1 - Attributes of the VM instance (subset of all the attributes available)

output "ip_1" {
  description = "Public IP address 1"
  value       = azurerm_public_ip.ip_1.ip_address
}

# VM 2 - Attributes of the VM instance (subset of all the attributes available)

# output "ip_2" {
#   description = "Public IP address 2"
#   value       = azurerm_public_ip.ip_2.ip_address
# }
