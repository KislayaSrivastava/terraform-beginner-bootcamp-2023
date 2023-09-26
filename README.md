# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1` 

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install the Terraform CLI

### Considerations with the Terraform CLI Changes
The terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform documentation and change the scripting for install. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Consideration for Linux Distributions

This project is built against Ubuntu. Please consider checking your linux Distribution and change accordingly to the distribution needs.

[Checking OS Version in Linux](https://www.geeksforgeeks.org/how-to-check-the-os-version-in-linux/)

Example of checking OS Version

```bash
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refractoring into Bash Scripts

While fixing the terraform CLI gpg depreciation issues we noticed that bash scripts steps were a considerable amount of more code. So we decided to create a bash script to install the terraform CLI.

This bash script is located here: [InstallationFile](./bin/install_terraform.sh)

- This will keep Gitpod Task File [.gitpod.yml](.gitpod.yml)Tidy.
- This will allow us an easier way to debug and execute manually terraform CLI Installs.
- This will also allow better portability for other projects that need to install terraform CLI.

#### Shebang Considerations

A Shebang(Pronounced Sha-Bang) tells the bash script what program will interpret the script eg. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- For portability for different OS distributions
- will search the user's PATH variable for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the bash script we can use `./` shorthand notation to execute the bash script. 
eg. `./bin/install_terraform.sh`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret it. 

eg. `source ./bin/install_terraform.sh`

#### Linux Permissions Considerations

In Order to make our bash scripts executable we need to change linux permissions for the file to be executable at the user mode. 

```sh
chmod u+x ./bin/install_terrform.sh
```

alternatively 
```sh
chmod 744 ./bin/install_terraform.sh
```

https://en.wikipedia.org/wiki/Chmod

### Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working with Env Vars

We can list out all Environment variables (Env Vars) using the `env` command
We can filter specific env vars using grep eg `env| grep AWS_`

#### Setting and unsetting Env Vars

In the terminal we can set using `export HELLO=world`
In the terminal we can unset using `unset HELLO`

We can set an env var temporarily when just running a command 

```sh
HELLO='world ./bin/print_message
```

Within a bash script we can set env without wriing export eg.
```sh
#!/usr/bin/env bash
HELLO='world'
echo $HELLO
```

#### Printing Vars

We can print an environment using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open a new bash terminal in VSCode, it will not be aware of env vars that you have set in another window. 

If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. 

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```sh
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in these workspaces.
You can also set an env var in the `.gitpod.yml` but this can only contain non-sensitive environments. 

### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli.sh`](./bin/install_aws_cli.sh)

[Getting started with AWS CLI Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

if it is successful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIDARG44KG3PZV7BYCJVC",
    "Account": "192414461494",
    "Arn": "arn:aws:iam::192414461494:user/terraform-user"
}
```

We will need to generate the AWS CLI Credentials from IAM user in order to use the AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform source their providers and modules from the terraform registry that is located at [Terraform Registry](registry.terraform.io)

- **Providers** is an interface to APIs that will allow to create resources in terraform
- **Modules** are a way to make large amounts of terraform code modular, portable and sharable.

[Random Terraform](https://registry.terraform.io/providers/hashicorp/random)
### Terraform Console

We can see a list of all the terraform commands by simply typing `terraform`

#### Terraform init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project. 

#### Terraform Plan

`terraform plan`

This will generate out a changeset about the state of the infrastructer and what will be changed. 
We can output this changeset ie. 'plan' to be passed to an apply, but often you can just ignore outputting. 

#### Terraform apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt yes or no. 
If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`terraform destroy`

This will destroy resources. You can also use the auto-approve flag to skip the approve prompt.
eg. `terraform destroy --auto-approve`

#### Terraform Lock Files

`terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project. 
This **should be committed** to the VCS eg Github

### Terraform State Files

`.terraform.tfstate` contain information about the current state of your infrastructure. 

This file **should not be committed** to teh VCS eg Github. This file can contain sensitive data. If you lose this file you lose knowing the state of your infrastructure. 

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud Login and Gitpod WorkSpace

When attempting to run `terraform login` it will launch a bash wiswig view to generate a token. However it does not work as expected in Gitpod VSCode in the browser. 

The workaround is as follows
- Go to the link mentioned below and generate a token 

```sh
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

- In the bash wiswig view exit out using 'q' key to quit and then confirm the response by saying 'y'.
- The prompt now displays as below

```sh
Generate a token using your browser, and copy-paste it into this prompt.

Terraform will store the token in plain text in the following file
for use by subsequent commands:
    /home/gitpod/.terraform.d/credentials.tfrc.json

Token for app.terraform.io:
  Enter a value: 

```

- At this prompt, select the token from the above link and paste it here. **NOTE** The prompt will not move. Since this is a security token, the OS will paste the token but the prompt will stay there. Best way is to first click on the cursor with mouse to activate the field and then use keys `shift + insert` or `Ctrl + V` to paste the value. Wait 2 seconds to ensure the complete string is pasted and then press `enter` key once.

- Below screen will display after a few seconds if the code was successfully entered. 

```sh
Retrieved token for user <USERNAME>


---------------------------------------------------------------------------------

                                          -                                
                                          -----                           -
                                          ---------                      --
                                          ---------  -                -----
                                           ---------  ------        -------
                                             -------  ---------  ----------
                                                ----  ---------- ----------
                                                  --  ---------- ----------
   Welcome to Terraform Cloud!                     -  ---------- -------
                                                      ---  ----- ---
   Documentation: terraform.io/docs/cloud             --------   -
                                                      ----------
                                                      ----------
                                                       ---------
                                                           -----
                                                               -


   New to TFC? Follow these steps to instantly apply an example configuration:

   $ git clone https://github.com/hashicorp/tfc-getting-started.git
   $ cd tfc-getting-started
   $ scripts/setup.sh


gitpod /workspace/terraform-beginner-bootcamp-2023 (main) $
```

- Now the commands `terraform init` and `terraform apply` should be used to update the status. 

### Terraform State Copy

The first time `terraform init` command is run post successfully login into terraform cloud via `terraform login`, a message comes up informing the user that terraform can optionally copy the current workspace state to the configured terraform cloud workspace and requests user confirmation through `yes` or `no`.

If you say yes the state file is copied otherwise it is left as is. 

> Sample Output Generated for first time terraform init command run post terraform login 

```sh
gitpod /workspace/terraform-beginner-bootcamp-2023 (main) $ terraform init

Initializing Terraform Cloud...
Do you wish to proceed?
  As part of migrating to Terraform Cloud, Terraform can optionally copy your
  current workspace state to the configured Terraform Cloud workspace.
  
  Answer "yes" to copy the latest state snapshot to the configured
  Terraform Cloud workspace.
  
  Answer "no" to ignore the existing state and just activate the configured
  Terraform Cloud workspace with its existing state, if any.
  
  Should Terraform migrate your existing state?

  Enter a value: yes


Initializing provider plugins...
- Reusing previous version of hashicorp/random from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/random v3.5.1
- Using previously-installed hashicorp/aws v5.17.0

Terraform Cloud has been successfully initialized!

You may now begin working with Terraform Cloud. Try running "terraform plan" to
see any changes that are required for your infrastructure.

If you ever set or change modules or Terraform Settings, run "terraform init"
again to reinitialize your working directory.
gitpod /workspace/terraform-beginner-bootcamp-2023 (main) $
```
