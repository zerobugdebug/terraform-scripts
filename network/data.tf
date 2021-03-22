data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

data "aws_availability_zones" "aws_availability_zones" {
  state = "available"
}

data "aws_secretsmanager_secret_version" "aws_access_key_id" {
  provider  = aws.login
  secret_id = "${local.environment}.terraform.aws_access_key_id"
}

data "aws_secretsmanager_secret_version" "aws_secret_access_key" {
  provider  = aws.login
  secret_id = "${local.environment}.terraform.aws_secret_access_key"
}

data "template_file" "public_cidrsubnet" {
  count = var.public_subnet_count

  template = "$${cidrsubnet(vpc_cidr,vpc_subnets_prefix,current_count)}"

  vars = {
    vpc_cidr           = local.vpc_public_cidr
    vpc_subnets_prefix = var.vpc_subnets_prefix
    current_count      = count.index
  }
}

data "template_file" "app_cidrsubnet" {
  count = var.app_subnet_count

  template = "$${cidrsubnet(vpc_cidr,vpc_subnets_prefix,current_count)}"

  vars = {
    vpc_cidr           = local.vpc_app_cidr
    vpc_subnets_prefix = var.vpc_subnets_prefix
    current_count      = count.index
  }
}

data "template_file" "data_cidrsubnet" {
  count = var.data_subnet_count

  template = "$${cidrsubnet(vpc_cidr,vpc_subnets_prefix,current_count)}"

  vars = {
    vpc_cidr           = local.vpc_data_cidr
    vpc_subnets_prefix = var.vpc_subnets_prefix
    current_count      = count.index
  }
}
