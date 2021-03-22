/* key_name = "terraform-test-key"

private_key_path = "C:\\Code\\terraform-test-key.pem"

public_key_path = "C:\\Code\\terraform-test-key.pub"

bucket_name_prefix = "globo"

environment_tag = "dev"

billing_code_tag = "ACCT8675309" */


vpc_address_space = {
  dev  = "10.12.0.0/16"
  qa   = "10.14.0.0/16"
  prod = "10.16.0.0/16"
  test = "10.18.0.0/16"
}

public_subnet_count = 2
app_subnet_count    = 2
data_subnet_count   = 2

