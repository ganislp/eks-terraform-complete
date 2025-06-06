# Resource: k8s Role
resource "kubernetes_role_v1" "eksdeveloper_role" {
  #depends_on = [kubernetes_namespace_v1.k8s_dev]
  metadata {
    name      = "eksdeveloper-role"
    namespace = kubernetes_namespace_v1.k8s_dev.metadata[0].name
  }

  rule {
    api_groups = ["", "extensions", "apps"]
    resources  = ["*"]
    verbs      = ["*"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["jobs", "cronjobs"]
    verbs      = ["*"]
  }
}

# Resource: k8s Role Binding
resource "kubernetes_role_binding_v1" "eksdeveloper_rolebinding" {
  #depends_on = [kubernetes_namespace_v1.k8s_dev]  
  metadata {
    name      = "eksdeveloper-rolebinding"
    namespace = kubernetes_namespace_v1.k8s_dev.metadata[0].name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_cluster_role_v1.eksreadonly_clusterrole.metadata.0.name
  }
  subject {
    kind      = "Group"
    name      = "eks-readonly-group"
    api_group = "rbac.authorization.k8s.io"
  }
}