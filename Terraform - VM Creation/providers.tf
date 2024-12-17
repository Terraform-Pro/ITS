# Azurerm providers declaration
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.42.0"
    }
  }
}

# Specify the provider and its configuration
provider "azurerm" {
  alias                      = "its"
  subscription_id            = var.subscription_id
  skip_provider_registration = true
  features {}
}

provider "azurerm" {
  skip_provider_registration = true
  features {}

}