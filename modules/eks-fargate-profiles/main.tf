# Resource: EKS Fargate Profile
resource "aws_eks_fargate_profile" "fargate_profile_kube_system" {
  cluster_name           = var.eks_cluster_name
  fargate_profile_name   = var.forgate_profile_name
  pod_execution_role_arn = var.fargate_profile_role_arn
  subnet_ids             = tolist(var.private_subnets)
  selector {
    namespace = var.name_space
   # Enable the below labels if we want only CoreDNS Pods to run on Fargate from kube-system namespace

  # labels = { 
  #    "k8s-app" = "kube-dns"
  #    "app.kubernetes.io/instance" = "aws-load-balancer-controller"
  #    "app.kubernetes.io/name" = "aws-load-balancer-controller"
  #   }
  }
}

resource "aws_eks_fargate_profile" "fargate_profile_default" {
  cluster_name           = var.eks_cluster_name
  fargate_profile_name   = "fp-default"
  pod_execution_role_arn = var.fargate_profile_role_arn
  subnet_ids             = tolist(var.private_subnets)
  selector {
    namespace = "default"
}

}




