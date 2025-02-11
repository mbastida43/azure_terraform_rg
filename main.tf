terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.16.0"
    }
    }
    backend "azurerm" {
    resource_group_name   = "resourcegroup"
    storage_account_name  = "storageaccountmarlon"
    container_name        = "container"
    key                   = "prod.terraform.tfstate"
    }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resourcegroup" {
  name     = var.rgname
  location = "West Europe"
}

locals {
  location = "EastUS"
  resourcegroup = "resourcegroup"
  updatedomain  = 6
  faultdomain   = 2
}

resource "azurerm_availability_set" "avset1" {
  name                          = "availabilityset1"
  location                      = local.location
  resource_group_name           = azurerm_resource_group.resourcegroup.name
  platform_update_domain_count  = local.updatedomain
  platform_fault_domain_count   = local.faultdomain
}

resource "azurerm_availability_set" "avset2" {
  name                          = "availabilityset2"
  location                      = local.location
  resource_group_name           = azurerm_resource_group.resourcegroup.name
  platform_update_domain_count  = local.updatedomain
  platform_fault_domain_count   = local.faultdomain
}

resource "azurerm_availability_set" "avset3" {
  name                          = "availabilityset3"
  location                      = local.location
  resource_group_name           = azurerm_resource_group.resourcegroup.name
  platform_update_domain_count  = local.updatedomain
  platform_fault_domain_count   = local.faultdomain
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnetname
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  address_space       = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "Prod"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/25"]  
}

resource "azurerm_subnet" "subnet2" {
  name                 = "Dev"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.128/25"] 
}




