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
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "emojikitchenkeyboard"
    storage_account_name = "emojikitchenkeyboardsa"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    subscription_id      = var.subscription_id
  }
}

provider "azurerm" {
   features {}
}

provider "azuredevops" {
  # Configuration options
}

provider "cloudflare" {
  
}