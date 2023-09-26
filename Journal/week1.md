# Terraform Begineer BootCamp 2023 - week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
|
|__ main.tf          # everything else
|__ variables.tf     # stores the structure of input variables
|__ terraform.tfvars # the data of variables we want to load into our terraform project
|__ providers.tf     # defined required providers and their configuration
|__ outputs.tf       # stores our outputs
|__ README.md        # required for root modules
```

[](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
