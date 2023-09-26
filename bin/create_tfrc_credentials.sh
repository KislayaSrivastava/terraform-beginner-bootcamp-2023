#!/usr/bin/env bash

# Define the target directory
target_directory="/home/gitpod/.terraform.d"

# Check if TERRAFORM_CLOUD_TOKEN is set
if [ -z "$TERRAFORM_CLOUD_TOKEN" ]; then
  echo "TERRAFORM_CLOUD_TOKEN environment variable is not set."
  exit 1
fi

# Create the target directory if it doesn't exist
if [ ! -d "$target_directory" ]; then
  mkdir -p "$target_directory"
fi

# Create the credentials.tfrc.json file
cat > "$target_directory/credentials.tfrc.json" <<EOF
{
  "credentials": {
    "app.terraform.io": {
      "token": "$TERRAFORM_CLOUD_TOKEN"
    }
  }
}
EOF

echo "credentials.tfrc.json file generated successfully in $target_directory."
