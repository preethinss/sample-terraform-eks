output "cluster_id" {
  description = "EKS cluster ID."
  value       = aws_eks_cluster.preethi_eks.id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = aws_eks_cluster.preethi_eks.endpoint
}
output "region" {
  description = "AWS region"
  value       = var.aws_region
}

output "oidc_provider_arn" {
  value = aws_eks_cluster.preethi_eks.arn
}


