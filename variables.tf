variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  type        = string
  description = "default CIDR range of the VPC"
}

variable "aws_region" {
  default     = "us-west-1"
  type        = string
  description = "aws region"
}

variable "enable_nat_gateway_value" {
  default     = true
  type        = bool
  description = "enable nat gateway"
}

variable "single_nat_gateway_value" {
  default     = true
  type        = bool
  description = "enable single nat gateway"
}

variable "enable_dns_hostnames_value" {
  default     = true
  type        = bool
  description = "enable dns hostnames"
}

variable "enable_dns_support_value" {
  default     = true
  type        = bool
  description = "enable dns support"
}

variable "subnets_value" {
  default = {
    "private_subnets" = ["10.0.1.0/24", "10.0.2.0/24"]
    "public_subnets"  = ["10.0.4.0/24", "10.0.5.0/24"]
  }
  type        = map(set(string))
  description = "public and private subnets"
}

variable "instance_types_value" {
  default     = ["t2.medium"]
  type        = set(string)
  description = "instance type value"
}






