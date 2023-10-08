terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.9.1"
    }
  }
}

provider "azurerm" {
   features {}
}

provider "azuredevops" {
  # Configuration options
}