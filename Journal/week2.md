# Terraform Begineer BootCamp 2023 - week 2

## Working with Ruby

### Bundler

Bundler is a package manager for Ruby. It is the primary way to install packages for ruby (known as gems) for ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally(unlike nodejs which installs packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project. 

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell the future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

You can create a web-server in a single file. 

[Sinatra Website](https://sinatrarb.com)

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in `server.rb` file.


## Custom Provider Creation and Testing
### Errors encountered  

The executable successfully compiled then it is providing this error at the time of running

```tf
gitpod /workspace/terraform-beginner-bootcamp-2023 (46-provider-block-custom-tf) $ tf plan
Running plan in Terraform Cloud. Output will stream here. Pressing Ctrl-C
will stop streaming the logs, but will not stop the plan running remotely.

Preparing the remote plan...

To view this run in a browser, visit:
https://app.terraform.io/app/KS-Food-Vendor-Organization/terra-house-FoodCart/runs/run-UQZwVH5ZSu1ptoxF

Waiting for the plan to start...

Terraform v1.5.7
on linux_amd64
Initializing plugins and modules...

Initializing Terraform Cloud...

Initializing provider plugins...
- terraform.io/builtin/terraform is built in to Terraform
- Reusing previous version of local.providers/local/terratowns from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Installing hashicorp/aws v5.19.0...
- Installed hashicorp/aws v5.19.0 (signed by HashiCorp)
╷
│ Error: Failed to query available provider packages
│ 
│ Could not retrieve the list of available versions for provider
│ local.providers/local/terratowns: could not connect to local.providers:
│ failed to request discovery document: Get
│ "https://local.providers/.well-known/terraform.json": dial tcp: lookup
│ local.providers on 10.184.0.2:53: no such host
╵

Operation failed: failed running terraform init (exit 1)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
gitpod /workspace/terraform-beginner-bootcamp-2023 (46-provider-block-custom-tf) $ 
```
[One Possible Fix](https://stackoverflow.com/questions/63556138/could-not-retrieve-the-list-of-available-versions-for-provider-terraform-azure)


```tf
The Terraform configuration must be valid before initialization so that
Terraform can determine which modules and providers need to be installed.
╷
│ Error: Invalid provider source string
│ 
│   on main.tf line 4, in terraform:
│    4:       source = "local.providers/local/terratowns/"
│ 
│ The "source" attribute must be in the format "[hostname/][namespace/]name"
╵

gitpod /workspace/terraform-beginner-bootcamp-2023 (46-provider-block-custom-tf) $ 
```

### Error Resolution while running the custom provider

These issues were fixed by completely blanking out the `main.tf` file. I had my cloud configuration in it. That was causing issues. 
To fix that i completed commented the cloud configuration and the originally added terrahouse_aws module. Then added the  `required_providers` block

Updated file post adding the custom provider 

```tf
terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
}
  # cloud {
  #   organization = "KS-Food-Vendor-Organization"
  #   workspaces {
  #     name = "terra-house-FoodCart"
  #   }
  # }
}

# module "terrahouse_aws" {
#   source ="./modules/terrahouse_aws"
#   user_uuid = var.user_uuid
#   bucket_name = var.bucket_name
#   index_html_filepath = "${path.root}${var.index_html_filepath}"
#   error_html_filepath = "${path.root}${var.error_html_filepath}"
#   content_version = var.content_version
#   assets_path = "${path.root}${var.assets_path}"
# }

provider "terratowns" {
  endpoint = "http://localhost:4567"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}
```

For testing the setup, I first re-created the executable using the shell script `bin/build_provider.sh`. Next i ran the `terraform init` command followed by `terraform plan` command.

```tf
gitpod /workspace/terraform-beginner-bootcamp-2023 (46-provider-block-custom-tf) $ ./bin/build_provider.sh 
```

```tf
gitpod /workspace/terraform-beginner-bootcamp-2023 (46-provider-block-custom-tf) $ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding local.providers/local/terratowns versions matching "1.0.0"...
- Installing local.providers/local/terratowns v1.0.0...
- Installed local.providers/local/terratowns v1.0.0 (unauthenticated)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

╷
│ Warning: Incomplete lock file information for providers
│ 
│ Due to your customized provider installation methods, Terraform was forced to calculate lock file checksums locally for the following providers:
│   - local.providers/local/terratowns
│ 
│ The current .terraform.lock.hcl file only includes checksums for linux_amd64, so Terraform running on another platform will fail to install these providers.
│ 
│ To calculate additional checksums for another platform, run:
│   terraform providers lock -platform=linux_amd64
│ (where linux_amd64 is the platform to generate)
╵

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
gitpod /workspace/terraform-beginner-bootcamp-2023 (46-provider-block-custom-tf) $
```

Running the `terraform plan` command 

```tf
gitpod /workspace/terraform-beginner-bootcamp-2023 (46-provider-block-custom-tf) $ terraform plan
var.assets_path
  path to assets folder

  Enter a value: 1

var.bucket_name
  Enter a value: test

var.content_version
  Enter a value: 3

var.error_html_filepath
  Enter a value: index.html

var.index_html_filepath
  Enter a value: error.html

var.user_uuid
  Enter a value: e328f4ab-b99f-421c-84c9-4ccea042c7d1

╷
│ Error: Reference to undeclared module
│ 
│   on outputs.tf line 3, in output "bucket_name":
│    3:     value = module.terrahouse_aws.bucket_name
│ 
│ No module call named "terrahouse_aws" is declared in the root module.
╵
╷
│ Error: Reference to undeclared module
│ 
│   on outputs.tf line 8, in output "S3_website_endpoint":
│    8:     value=module.terrahouse_aws.website_endpoint
│ 
│ No module call named "terrahouse_aws" is declared in the root module.
╵
╷
│ Error: Reference to undeclared module
│ 
│   on outputs.tf line 13, in output "cloudfront_url":
│   13:   value=module.terrahouse_aws.cloudfront_url
│ 
│ No module call named "terrahouse_aws" is declared in the root module.
╵
gitpod /workspace/terraform-beginner-bootcamp-2023 (46-provider-block-custom-tf) $
```

This error was resolved by commenting out the `outputs.tf` file because the module terrahouse_aws was being referenced here and this was already commented out in `main.tf`.

final output post successful run of `terraform plan`

```tf
gitpod /workspace/terraform-beginner-bootcamp-2023 (46-provider-block-custom-tf) $ terraform plan
var.assets_path
  path to assets folder

  Enter a value: rs

var.bucket_name
  Enter a value: ters

var.content_version
  Enter a value: 4

var.error_html_filepath
  Enter a value: tdt

var.index_html_filepath
  Enter a value: tre

var.user_uuid
  Enter a value: e328f4ab-b99f-421c-84c9-4ccea042c7d1


No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
gitpod /workspace/terraform-beginner-bootcamp-2023 (46-provider-block-custom-tf) $
```

So the custom terraform provider was successfully tested.

## CRUD

Terraform provider resources utilizes CRUD. It stands for Create/Read/Update/Delete.

[CRUD Primer](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)

A main.go file was created in golang. I coded alongside Andrew and was able to successfully implement the CRUD operations on the demo server `sinatra`. 

## Getting Access Code for Terratowns and Deploying Code to Terratown

Next step was to use an access token generated on the exampro website to create an account on `terratowns.cloud` website. This was successfully completed by me. 

Steps in Deploying Code

1- The `main.tf` file was modified to point to the correct endpoint. Then the `user_uuid` value and the `access_token` values were initially hardcoded to test that the record is getting successfully inserted. 
2- A resource named `food-truck` was created with the key attributes as per the custom provider attributes.

Sample Code fix
```tf
provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid=var.teacherseat_user_uuid
  token=var.terratowns_access_token
}

module "terrahome_foodtruck_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  public_path = var.foodtruck.public_path
  content_version = var.foodtruck.content_version
}

resource "terratowns_home" "food-truck" {
  name = "My Food Truck 'let's eat' is here to stay forver"
  description =<<DESCRIPTION
Welcome to 'Let's Eat'! 🌟
We're thrilled to introduce our mouthwatering world of flavors on wheels to Bangalore. At Let's Eat, we're not just serving food; we're crafting unforgettable culinary experiences, one plate at a time.
Our Menu: Explore a delectable lineup of Lucknawi delights, from classic favorites to innovative creations. Our ingredients are fresh, our recipes are handcrafted, and our passion for food is unparalleled.
Our Chefs: Meet the talented culinary artists behind the magic - Kislaya & Shruti. With years of experience and a commitment to excellence, they're here to tantalize your taste buds.
Our Truck: Our vibrant and welcoming food truck is not just a place to eat; it's a gathering spot for friends and foodies alike. We take pride in our spotlessly clean kitchen on wheels, ensuring your meals are prepared with love and care.
Join the Let's eat Family: We're more than just a food truck; we're a community. Follow us on social media for the latest updates, special promotions, and behind-the-scenes glimpses of our food truck adventures.
DESCRIPTION
  domain_name = module.terrahome_foodtruck_hosting.cloudfront_url
  town="cooker-cove"
  content_version=1
}
```
3- Commands run on terraform console
  - `terraform init` to initialize the terraform cloud
  - `terraform plan` to create the deployment plan. if any errors occured then to remove those errors.
  - `terraform apply` to execute the created deployment plan. There is a flag used `auto-approve` to automatically push the changes. 
4- Once the changes were shown deployed on terratowns, the deployment was complete.

## Deploying more than one page in terratowns

In order to deploy more than one page, a few changes were made.

Earlier there was just one `public` folder related to just one html document. Now if two or more html webpages were being deployed, then the folder structure was rearranged

```sh
  <public>
  |
  |---<FirstWebpageFolder>
  |      |
  |      |---<assets>
  |      |      |
  |      |      |--------<imagefiles>
  |      |---index.html
  |      |---error.html
  |
  |---<SecondWebpageFolder>
  |      |
  |      |---<assets>
  |      |      |
  |      |      |--------<imagefiles>
  |      |---index.html
  |      |---error.html
  |
  |---<ThirdWebpageFolder> 
  |
```
The module "food-truck" was copied and it was renamed and the description was changed. Also the name of the town was also changed to which it was being deployed to. Then the `variables.tf` and the `main.tf` and the `resource-storage.tf` files were modified. 

Additionally we used another data structure `object` ie nested variables for listing all the values in one place like a map. 

```tf
variable "foodtruck" {
  type = object({
    public_path = string
    content_version = number
  })
}
```

Then the values were accordingly mapped
```tf
foodtruck = {
  public_path = "/workspace/terraform-beginner-bootcamp-2023/public/FoodTruck"
  content_version = 2
  bucket_name = "" 
}
```

So the custom provider was the same but the name of the module was changed. 
Also all the variables were not hard-coded but were assigned values using `var` parameter.

Faced a few errors because of the object changes and the renamings. So had to check and rename all the places where the errors were being shown. 

Commands run on terraform console
  - `terraform init` to initialize the terraform cloud
  - `terraform plan` to create the deployment plan. if any errors occured then to remove those errors.
  - `terraform apply` to execute the created deployment plan. There is a flag used `auto-approve` to automatically push the changes. 

Once everything was correct, the code was deployed and then two pages were simultaneously deployed using terraform.

```tf
Apply complete! Resources: 25 added, 0 changed, 0 destroyed.

Outputs:

S3_website_endpoint_FoodTruck = "terraform-20231009181827735800000002.s3-website.ap-south-1.amazonaws.com"
S3_website_endpoint_Movies = "terraform-20231009181827735700000001.s3-website.ap-south-1.amazonaws.com"
bucket_name = "terraform-20231009181827735800000002"
cloudfront_url_FoodTruck = "d39vr7c6twbj0s.cloudfront.net"
cloudfront_url_Movies = "d3cnptglwev7x7.cloudfront.net"
gitpod /workspace/terraform-beginner-bootcamp-2023 (53-multi-home-terraform-cloud)
```
