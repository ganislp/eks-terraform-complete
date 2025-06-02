resource "aws_eks_fargate_profile" "fargate_profile" {
  cluster_name           = data.terraform_remote_state.eks.outputs.cluster_id
  fargate_profile_name   = "${local.naming_prefix}-fp-app1"
  pod_execution_role_arn = aws_iam_role.fargate_profile_role.arn
  subnet_ids             = tolist(data.terraform_remote_state.eks.outputs.private_subnets)
    # subnet_ids             = ["subnet-0d4602e1a77091709","subnet-05d1e080682a86b46"]
  selector {
    namespace = kubernetes_namespace_v1.fp_ns_app1.metadata[0].name
  }
}