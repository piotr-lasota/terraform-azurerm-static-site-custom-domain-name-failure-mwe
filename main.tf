terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.90.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = "rg-${var.minimum_working_example_name}"
  location = "westeurope"
}

resource "azurerm_static_site" "website" {
  name                = "app-${var.minimum_working_example_name}"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  sku_size            = "Free"
  sku_tier            = "Free"
}

resource "azurerm_dns_zone" "dns" {
  name                = var.domain_name
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_static_site_custom_domain" "txt-root" {
  static_site_id  = azurerm_static_site.website.id
  domain_name     = azurerm_dns_zone.dns.name
  validation_type = "dns-txt-token"
}

resource "azurerm_dns_txt_record" "txt-root" {
  name                = "@"
  zone_name           = azurerm_dns_zone.dns.name
  resource_group_name = azurerm_resource_group.resource_group.name
  ttl                 = 3600
  record {
    # 1. This value will cause an error after successful validation (+/- 30m after application)    
    # 2. It will not do so right after creation
    value = azurerm_static_site_custom_domain.txt-root.validation_token
  }
}