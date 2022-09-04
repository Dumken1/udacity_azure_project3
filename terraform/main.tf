provider "azurerm" {
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tfstate24260"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    access_key           = "/UdKO0cGbDX59B+QVXZ/Finzg07EkYZXOPXHDC2bPqyxLQo9ldhBU3zxxD+YGcQfdlVUSdAvbBTf+ASttqs0ig=="
  }
}

module "resource_group" {
  source               = "./modules/resource_group"
  resource_group       = "${var.resource_group}"
  location             = "${var.location}"
}

module "app_service" {
  source               = "./modules/appservice"
  resource_group       = "${module.resource_group.resource_group_name}"
  application_type     = "${var.application_type}"
  resource_type        = "AppService"
  location             = "${var.location}"
  tags                 = {tag1 = var.tier, tag2 = var.deployment}
}
