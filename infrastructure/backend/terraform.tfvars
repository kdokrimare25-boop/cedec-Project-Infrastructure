# Copy to terraform.tfvars. Do not commit terraform.tfvars.

aws_region   = "eu-north-1"
environment  = "dev"
project_name = "cdec-alpha"
cluster_name = "cdec-eks-dev"

# VPC — change AZ names for your region
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
availability_zones   = ["eu-north-1", "eu-north-1"]

single_nat_gateway = true

# EKS
kubernetes_version  = "1.34"
node_instance_types = ["t3.2xlarge"]
desired_size        = 2
min_size            = 1
max_size            = 3

cluster_endpoint_public_access       = true
cluster_endpoint_private_access      = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

cluster_admin_iam_role_names    = []
cluster_admin_principal_arns    = []
include_caller_as_cluster_admin = true

additional_tags = {
  Owner = "platform-team"
}

# ALB Ingress — AWS Load Balancer Controller + API ingress
enable_alb_ingress  = true
ingress_host        = "api.awsproject.shop"
acm_certificate_arn = "arn:aws:acm:eu-north-1:329504364887:certificate/278f0c77-f159-4561-be8a-2b7f800f17ff"
alb_name            = "cdec-alpha-alb"
