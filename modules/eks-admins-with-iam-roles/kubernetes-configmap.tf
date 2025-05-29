data "aws_caller_identity" "caller_identity" {

}

locals {
  configmap_roles = [
    {
      # rolearn = "${var.eks_nodegroup_role_arn}"
      rolearn  = "arn:aws:iam::${data.aws_caller_identity.caller_identity.account_id}:role/eks_worker_node_role"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    },
    {
      # rolearn = "${var.eks_nodegroup_role_arn}"
      rolearn  = "${aws_iam_role.eks_admin_role.arn}"
      username = "eks-admin"
      groups   = ["system:masters"]
    },
    {
      rolearn  = "${aws_iam_role.eks_readonly_role.arn}"
      username = "eks-readonly"
      groups   = ["${kubernetes_cluster_role_binding_v1.eksreadonly_clusterrolebinding.subject[0].name}"]
    }

  ]

  config_users = [
    {
      userarn  = "${aws_iam_user.admin_user.arn}"
      username = "${aws_iam_user.admin_user.name}"
      groups   = ["system:masters"]
    },
    {
      userarn  = "${aws_iam_user.basic_user.arn}"
      username = "${aws_iam_user.basic_user.name}"
      groups   = ["system:masters"]
    }
  ]
}

resource "kubernetes_config_map_v1" "aws_auth_config_map" {
  depends_on = [var.cluster_id, kubernetes_cluster_role_binding_v1.eksreadonly_clusterrolebinding]
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    mapRoles = yamlencode(local.configmap_roles)
    mapUsers = yamlencode(local.config_users)
  }
}