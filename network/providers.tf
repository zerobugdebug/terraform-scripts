provider "aws" {
  region  = var.region
  profile = local.environment
  alias   = "login"
}

provider "aws" {
  access_key = local.aws_access_key_id
  secret_key = local.aws_secret_access_key
  region     = var.region
}
