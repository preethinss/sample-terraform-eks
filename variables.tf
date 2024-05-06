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
