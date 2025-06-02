# Kubernetes Service Manifest (Type: Node Port Service)
resource "kubernetes_service_v1" "myapp3_np_service" {
  metadata {
    name      = "app3-nginx-nodeport-service"
    namespace = kubernetes_namespace_v1.ns_app3.metadata[0].name
    annotations = {
      "alb.ingress.kubernetes.io/healthcheck-path" = "/index.html"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.myapp3.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    type = "NodePort"
  }
}