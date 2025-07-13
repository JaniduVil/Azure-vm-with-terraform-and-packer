packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = ">=1.0.0"
    }
  }
}

variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

source "azure-arm" "ubuntu" {
  client_id                    = var.client_id
  client_secret                = var.client_secret
  tenant_id                    = var.tenant_id
  subscription_id              = var.subscription_id

  managed_image_resource_group_name = "myResourceGroup"
  managed_image_name                = "ubuntu-custom-image"
  location                          = "East US"

  vm_size        = "Standard_B1s"
  os_type        = "Linux"
  image_publisher = "Canonical"
  image_offer     = "UbuntuServer"
  image_sku       = "18.04-LTS"
}

build {
  sources = ["source.azure-arm.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}

