terraform {
  backend "s3" {
    bucket = "terraform-state-8kstxmua"
    key    = "terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-state-locks-sgwb5wl0"
    encrypt        = true
  }

  required_version = ">= 0.12.21"

  required_providers {
    aws = ">= 2.68"
  }

}
