#GENERAL
locals {
  environment = split(".", terraform.workspace)[0]

  stack = split(".", terraform.workspace)[1]

  aws_access_key_id = data.aws_secretsmanager_secret_version.aws_access_key_id.secret_string

  aws_secret_access_key = data.aws_secretsmanager_secret_version.aws_secret_access_key.secret_string
}

#NETWORK
locals {
  vpc_public_cidr = cidrsubnet(var.vpc_address_space[local.environment], var.vpc_tiers_prefix, 0)
  vpc_app_cidr    = cidrsubnet(var.vpc_address_space[local.environment], var.vpc_tiers_prefix, 1)
  vpc_data_cidr   = cidrsubnet(var.vpc_address_space[local.environment], var.vpc_tiers_prefix, 2)

  vpc_public_subnets = data.template_file.public_cidrsubnet[*].rendered
  vpc_app_subnets    = data.template_file.app_cidrsubnet[*].rendered
  vpc_data_subnets   = data.template_file.data_cidrsubnet[*].rendered
}
