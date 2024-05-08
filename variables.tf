variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  //default     = "preethi-eks-vpc"
}

variable "vpc_cidr" {
  //default     = "10.0.0.0/16"
  type        = string
  description = "default CIDR range of the VPC"
}

variable "aws_region" {
  //default     = "us-west-1"
  type        = string
  description = "aws region"
}

variable "enable_nat_gateway_value" {
  //default     = true
  type        = bool
  description = "enable nat gateway"
}

variable "single_nat_gateway_value" {
  //default     = true
  type        = bool
  description = "enable single nat gateway"
}

variable "enable_dns_hostnames_value" {
  //default     = true
  type        = bool
  description = "enable dns hostnames"
}

variable "enable_dns_support_value" {
  // default     = true
  type        = bool
  description = "enable dns support"
}

variable "instance_types" {
  description = "A set of instance types for the worker nodes"
  type        = set(string)
  // default     = ["t2.medium"]
}

variable "private_subnets" {
  description = "A map of CIDR blocks for private subnets"
  type        = map(string)
  /* default = {
    subnet1 = "10.0.1.0/24"
    subnet2 = "10.0.2.0/24"
  }*/
}

variable "public_subnets" {
  description = "A map of CIDR blocks for public subnets"
  type        = map(string)
  /*default = {
    subnet1 = "10.0.4.0/24"
    subnet2 = "10.0.5.0/24"
  }*/
}

variable "worker_node_desired_size" {
  description = "The desired number of worker nodes"
  type        = number
  //default     = 1
}

variable "worker_node_max_size" {
  description = "The maximum number of worker nodes"
  type        = number
  // default     = 1
}

variable "worker_node_min_size" {
  description = "The minimum number of worker nodes"
  type        = number
  //default     = 1
}






