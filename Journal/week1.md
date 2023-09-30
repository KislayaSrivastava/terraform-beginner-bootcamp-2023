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

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kinds of variables:
- Environment Variables - Those you set in your bash terminal eg AWS Credentials
- Terraform Variables - Those you set in your tfvars file

We can set terraform cloud variables to be sensitive so they are not shown visibly in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the '-var' flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag
- TODO: Document this flag

### terraform.tfvars

This is the default file to load in terraform variables in bulk.

### auto.tfvars

- TODO: Document this funcatiuonaly fior terraform cloud

### Order of terraform variables 

- TODO: documetn which terraform variables setting take precedence

## Dealing with Configuration Drift

### What happens if you lose your state file

If you lose your state file, you most likely have to tear down all your cloud infrastructure manually. You can use terraform import but it will not work for all cloud resources. You need to check the terraform providers documentation for which resources support import. 

### Fix Missing Resources with Terraform Import 

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and deletes/updates/modifies cloud resources manually through ClickOps.

If we run Terraform plan it will attempt to put our infrastructure back into the expected state fixing Configuration Drift. 

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only --auto-approve
```

## Terraform Modules

### Terraform Module Structure

It is recommended to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to be define the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
    source ="./modules/terrahouse_aws"
    user_uuid = var.user_uuid
    bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg 
- Locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
    source ="./modules/terrahouse_aws"
}
```

[Terraform Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs like ChatGPT/Bard may not be trained on the latest documentation or information about terraform. It may likely produce older examples that could be deprecated often affecting providers.

## Working with Files in Terraform

### Fileexists function

This is a built in terraform function to check the existence of a file. 

```tf
validation {
     condition = fileexists("${path.root}/public/index.html")
     error_message = "The provided index_html_filepath does not point to a valid file."
   }
```
### Path Variables

In Terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path to the current module
- path.root = get the path for the root module

[Special Path Reference](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "Index_File_object" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
  etag = filemd5("${path.root}/public/index.html")
}
```

