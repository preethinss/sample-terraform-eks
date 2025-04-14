vpc_name                   = "preethi-eks-vpc-dev"
vpc_cidr                   = "10.0.0.0/16"
aws_region                 = "us-west-1"
enable_nat_gateway_value   = true
single_nat_gateway_value   = true
enable_dns_hostnames_value = true
enable_dns_support_value   = true
instance_types             = ["t2.medium"]
private_subnets = {
  subnet1 = "10.0.1.0/24"
  subnet2 = "10.0.2.0/24"
}
public_subnets = {
  subnet1 = "10.0.4.0/24"
  subnet2 = "10.0.5.0/24"
}
worker_node_desired_size = 1
worker_node_max_size     = 5
worker_node_min_size     = 1
