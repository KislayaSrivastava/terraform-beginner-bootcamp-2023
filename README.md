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