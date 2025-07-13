# Azure VM Automation with Packer and Terraform

This project automates the creation of an Azure Linux VM using a custom image built with Packer and deployed using Terraform.

## ✅ Tools Used

- HashiCorp **Packer**: Builds a custom Ubuntu image with Nginx pre-installed
- HashiCorp **Terraform**: Provisions the VM and networking using the custom image
- **Azure CLI** for login and service principal setup

## 🔧 Setup Instructions

### 1. Authenticate and Create Service Principal

```bash
az login
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<your-subscription-id>"

## Build Custom Image with Packer 

cd packer
packer init ubuntu.pkr.hcl
packer build \
  -var "client_id=..." \
  -var "client_secret=..." \
  -var "tenant_id=..." \
  -var "subscription_id=..." \
  ubuntu.pkr.hcl


## Provision VM with Terraform

cd ../terraform
terraform init
terraform apply -var="custom_image_id=<output-image-id>"

