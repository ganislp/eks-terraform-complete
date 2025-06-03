resource "kubernetes_deployment_v1" "myapp3" {
  metadata {
    name = "myapp3"
    labels = {
      app = "myapp3"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "myapp3"
      }
    }
    template {
      metadata {
        labels = {
          app = "myapp3"
        }
      }
      spec {
        container {
          image = "stacksimplify/kubenginx:1.0.0"
          name  = "app3-nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }

}