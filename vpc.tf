data "aws_availability_zones" "available" {}

locals {
  cluster_name = "preethi-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "preethi-eks-vpc"
  cidr = var.vpc_cidr
  azs  = data.aws_availability_zones.available.names

  //private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  //public_subnets = ["10.0.4.0/24", "10.0.5.0/24"]

  private_subnets = {
    for key, value in var.private_subnets :
    key => {
      cidr_block = value
    }
  }

  public_subnets = {
    for key, value in var.public_subnets :
    key => {
      cidr_block = value
    }
  }

  enable_nat_gateway   = var.enable_nat_gateway_value
  single_nat_gateway   = var.single_nat_gateway_value
  enable_dns_hostnames = var.enable_dns_hostnames_value
  enable_dns_support   = var.enable_dns_support_value

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

}