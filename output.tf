output "vpc_id" {
  value = module.vpc.vpc_id
}


output "cluster_certificate_authority_data" {
  value = module.eks_cluester.cluster_certificate_authority_data
}

output "cluster_id" {
  value = module.eks_cluester.cluster_id
}

output "cluster_endpoint" {
  value = module.eks_cluester.cluster_endpoint
}

output "cluster_oidc_issuer_url" {
  value = module.eks_cluester.cluster_oidc_issuer_url
}

output "cluster_name" {
  value = module.eks_cluester.eks_cluster_name
}

output "aws_iam_openid_connect_provider_arn" {
  value = module.eks_cluester.aws_iam_openid_connect_provider_arn
}

output "aws_iam_openid_connect_provider_extract_from_arn" {
  value = module.eks_cluester.aws_iam_openid_connect_provider_extract_from_arn
}

# output "eks_nodegroup_role_arn" {
#   value = module.eks_node_group_public_private.eks_nodegroup_role
# }

output "private_subnets" {
  value = module.vpc.private_subnets
}


# Outputs: Fargate Profile for kube-system Namespace
# output "kube_system_fargate_profile_arn" {
#   description = "Fargate Profile ARN"
#   value = module.fargate_prof
# }
# output "kube_system_fargate_profile_id" {
#   description = "Fargate Profile ID"
#   value = aws_eks_fargate_profile.fargate_profile_kube_system.id 
# }

# output "kube_system_fargate_profile_status" {
#   description = "Fargate Profile Status"
#   value = aws_eks_fargate_profile.fargate_profile_kube_system.status
# }