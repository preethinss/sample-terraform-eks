provider "aws" {
  region = var.aws_region
}

# IAM Role for EKS to have access to the appropriate resources
resource "aws_iam_role" "eks_iam_role" {
  name = "preethi_eks_iam_role_${terraform.workspace}"

  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

## Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_iam_role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly_EKS" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_iam_role.name
}

## Create the EKS cluster
resource "aws_eks_cluster" "preethi_eks" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_iam_role.arn


  vpc_config {
    subnet_ids = module.vpc.private_subnets
  }

  depends_on = [
    aws_iam_role.eks_iam_role,
  ]
}

## Worker Nodes
resource "aws_iam_role" "workernodes" {
  name = "eks_node_group_example_${terraform.workspace}"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role       = aws_iam_role.workernodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.workernodes.name
}

resource "aws_eks_node_group" "worker_node_group" {
  cluster_name    = aws_eks_cluster.preethi_eks.name
  node_group_name = "preethi_workernodes-${terraform.workspace}"
  node_role_arn   = aws_iam_role.workernodes.arn
  subnet_ids      = module.vpc.private_subnets

  for_each       = var.instance_types
  instance_types = [each.value]

  scaling_config {
    desired_size = var.worker_node_desired_size
    max_size     = var.worker_node_max_size
    min_size     = var.worker_node_min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
