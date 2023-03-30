###################################
#### Resource Group            ####
###################################

# Create an Azure resource group to be used for these services 
resource "azurerm_resource_group" "test_rg" {
  name     = "vpc-test-resource-group" //  Resource group name
  location = var.azure_region          //  Azure region / location
  tags = {
    project = "tfcloud_testing"
  }
}
