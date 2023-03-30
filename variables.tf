####################################################################
####  VARIABLES - Define the variables we will use in this plan ####
####################################################################

#### Microsoft Azure Services Access Credentials #####
# Note:  The values of these variables should be set either by exporting environment variables
#        or by setting the variables in a separate .tfvars file
#        These credentials MUST NOT be published on git or any other public repository
#        For details see https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure
variable "arm_subscription_id" {
  description = "Azure subscription ID"
  default     = ""
}

variable "arm_client_id" {
  description = "Azure service principal appid"
  default     = ""
}

variable "arm_client_secret" {
  description = "Azure service principal password"
  default     = ""
}

variable "arm_tenant_id" {
  description = "Azure tenant ID"
  default     = ""
}

#### Azure service variables ###
variable "azure_region" {
  description = "Target region for Azure infrastructure requests"
  default     = "eastus2" //  VPC being created in US East 2
}

variable "shallcrm_ssh_key" {
  description = "SSH public key value to provision VM instances with"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDmAFBIqTyklVrG5lSgese7gN0rohFUavYnS2UfEEPWyXj/UZ498hGxuF3Kw+2lfjllFdjIAxVTQNl4I1OLthM6r6RatoOyalUTqPqUJ7dhWyoXDUY88UWniNf6Yt1jRa/T4wvmnnSYcUEts5wfRxjCK5IUTohup4q9cuRUciO22xRf//7+S7tVNr7huQgOXhx8YeVW86Vb7ZhP9zktijAC/BFfPdypHjV6j2tV1zy0NA8z8IaTyJOD4YsdOrjeMVp/fkPHOqGaP46tAjAT0iyyyjt4FeQ/0kuxLj0dF+OxSXrzFfoBnwikiEAFvlOok0fbpgImdsdPNUqIXoDQ6iaxHkgEbpdolAYrFPKqXxs1Yzchgk3a7EAG9KDRLT2p5MWnJhb6iO+kBZ5z6QpzfbIQ7MVotzSC1oSZIRxL86QQbLF/T51l0MyAxd9jlDPaCD24M5jTR0m2WuQ99hvDDc5X1ih5A7BR6dfbizhMfeMJgDAL5A+lN4pKUkeB5FZTizholGUq0Y7MNved36G7ORLZC/Q1ZCdAlHQhgBkoUpOmuCSOJpzAspoSs504lV0jbB92VRhm8PcXt5QV4ezBuMrc+01NL64m/9GViV7Muyrn8jrgo6sb9DrvR400Sc1Cs3d+bQiCHLF+2xXWV6mYnQG/7bvZ62QC9qARQRqf27jMow== m.a.shallcross@gmail.com"
}
