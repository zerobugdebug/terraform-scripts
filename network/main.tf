module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.region}.${local.environment}.${local.stack}.vpc"

  cidr = var.vpc_address_space[local.environment]

  azs              = slice(data.aws_availability_zones.aws_availability_zones.names, 0, var.public_subnet_count)
  public_subnets   = data.template_file.public_cidrsubnet[*].rendered
  private_subnets  = data.template_file.app_cidrsubnet[*].rendered
  database_subnets = data.template_file.data_cidrsubnet[*].rendered

  create_database_subnet_group = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

/*   # VPC Endpoint for ECR API
  enable_ecr_api_endpoint              = true
  ecr_api_endpoint_private_dns_enabled = true
  ecr_api_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC Endpoint for ECR DKR
  enable_ecr_dkr_endpoint              = true
  ecr_dkr_endpoint_private_dns_enabled = true
  ecr_dkr_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for ECS
  enable_ecs_endpoint              = true
  ecs_endpoint_private_dns_enabled = true
  ecs_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for ECS telemetry
  enable_ecs_telemetry_endpoint              = true
  ecs_telemetry_endpoint_private_dns_enabled = true
  ecs_telemetry_endpoint_security_group_ids  = [data.aws_security_group.default.id]
 */
  # Default security group - ingress/egress rules cleared to deny all
  /*   manage_default_security_group  = true
  default_security_group_ingress = [{}]
  default_security_group_egress  = [{}]
 */

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  tags = {
    Environment = local.environment
    Stack       = local.stack
    #Name        = "${var.region}.${local.environment}.${local.stack}.vpc"
  }

}

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  name = "${var.region}_${local.environment}_${local.stack}_ecs"
}

/* resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "hello_world"
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "hello_world" {
  family = "hello_world"

  container_definitions = <<EOF
[
  {
    "name": "hello_world",
    "image": "nginx:latest",
    "cpu": 0,
    "memory": 128,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "us-east-1",
        "awslogs-group": "hello_world",
        "awslogs-stream-prefix": "complete-ecs"
      }
    }
  }
]
EOF
}

resource "aws_ecs_service" "hello_world" {
  name            = "hello_world"
  cluster         = module.ecs.this_ecs_cluster_id
  task_definition = aws_ecs_task_definition.hello_world.arn

  desired_count = 1

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}

 */
