###################################
#### PROVIDER - Cloud provider ####
###################################

# Azure Cloud provider and credentials  (variables to be set externally using EXPORT commands)
provider "azurerm" {
  subscription_id = var.arm_subscription_id //  Azure subscription ID
  client_id       = var.arm_client_id       //  Azure service principal appid
  client_secret   = var.arm_client_secret   //  Azure service principal password 
  tenant_id       = var.arm_tenant_id       //  Azure tenant ID
  features {
    virtual_machine {
      delete_os_disk_on_deletion = true //  By default, delete OS disk when VM is deleted
    }
  }
}

# Terraform Cloud workspace where remote state will be stored
# Remove this block to revert to local management of tfstate if preferred
terraform {
  cloud {
    organization = "mshallcross"

    workspaces {
      name = "gh-tfcloud-testing"
    }
  }
}