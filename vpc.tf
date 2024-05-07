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

  for_each        = var.subnets_value
  private_subnets = each.value["private_subnets"]

  public_subnets = each.value["public_subnets"]

  enable_nat_gateway   = var.enable_nat_gateway_value
  single_nat_gateway   = var.single_nat_gateway_value
  enable_dns_hostnames = var.enable_dns_hostnames_value
  enable_dns_support   = var.enable_dns_support_value

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

}