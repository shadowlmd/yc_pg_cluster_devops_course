# Intro

This Terraform code will create a ready-to-use PostgreSQL cluster for Sausage Store.

# Usage

1. Configure Yandex Cloud CLI: https://cloud.yandex.ru/docs/cli/quickstart#install
1. Edit locals.tf to your needs (current values are valid for students-03 cloud)
1. Run `export YC_TOKEN=$(yc iam create-token)`
1. Run `terraform init`
1. Run `terraform apply`

# Note

If you are having issues with `terraform init` failing to download some providers, please configure http/https proxy with non-Russian IP address like this:

    export HTTP_PROXY=http://127.0.0.1:8118
    export HTTPS_PROXY=http://127.0.0.1:8118
