terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "c8ae0155-19b9-4306-a16f-ce3e1dab29f4"
  features {}
}
