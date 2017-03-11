Owncloud
===

Dev:
```
terraform plan  -var-file=dev/env_dev.tfvars  -state=dev/terraform-dev.tfstate
terraform apply  -var-file=dev/env_dev.tfvars  -state=dev/terraform-dev.tfstate
```

Prod:
```
terraform plan -var-file=prod/env_prod.tfvars  -state="prod/terraform-prod.tfstate"
terraform apply -var-file=prod/env_prod.tfvars  -state="prod/terraform-prod.tfstate"
```
