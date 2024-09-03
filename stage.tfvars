vpc_name                   = "preethi-eks-vpc-stage"
vpc_cidr                   = "10.1.0.0/16"
aws_region                 = "us-west-1"
enable_nat_gateway_value   = true
single_nat_gateway_value   = true
enable_dns_hostnames_value = true
enable_dns_support_value   = true
instance_types             = ["t2.large"]
private_subnets = {
  subnet1 = "10.1.1.0/24"
  subnet2 = "10.1.2.0/24"
}
public_subnets = {
  subnet1 = "10.1.4.0/24"
  subnet2 = "10.1.5.0/24"
}
worker_node_desired_size = 1
worker_node_max_size     = 4
worker_node_min_size     = 1
