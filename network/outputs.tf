output "WARNING" {
  value = ["******************************************************************************",
    "!!!YOU WILL UPDATE STACK ___ ${local.stack} ___ ON ___ ${local.environment} ___ ENVIRONMENT!!!",
  "******************************************************************************"]
}

output "aws_access_key_id" {
  value = data.aws_secretsmanager_secret_version.aws_access_key_id.secret_string
}

output "aws_secret_access_key" {
  value = data.aws_secretsmanager_secret_version.aws_secret_access_key.secret_string
}

output "public_cidrsubnet" {
  value = data.template_file.public_cidrsubnet[*].rendered
}

output "app_cidrsubnet" {
  value = data.template_file.app_cidrsubnet[*].rendered
}

output "data_cidrsubnet" {
  value = data.template_file.data_cidrsubnet[*].rendered
}

output "database_subnets" {
  value = module.vpc.database_subnets
}

