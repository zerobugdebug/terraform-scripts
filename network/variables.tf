variable "region" {
  default = "us-east-1"
}

/* variable "bucket_name_prefix" {}
variable "billing_code_tag" {}
variable "environment_tag" {}
 */

variable "vpc_address_space" {}

variable "vpc_subnets_prefix" {
  default = 4
}

variable "vpc_tiers_prefix" {
  default = 2
}

variable "public_subnet_count" {
  default = 2
}
variable "app_subnet_count" {
  default = 2
}
variable "data_subnet_count" {
  default = 2
}
