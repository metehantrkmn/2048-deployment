resource "kubernetes_deployment" "_2048-game" {
  metadata {
    name = "terraform-2048"
    labels = {
      test = "2048"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = "2048-App"
      }
    }

    template {
      metadata {
        labels = {
          test = "2048-App"
        }
      }

      spec {
        container {
          image = "metehan1171/2048:latest"
          name  = "2048-game-application"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

        
        }
      }
    }
  }
}

resource "kubernetes_service" "_2048-service" {
  metadata {
    name = "terraform-2048-service"
  }
  spec {
    selector = {
      app = kubernetes_deployment._2048-game.metadata.0.labels.test
    }

    port {
      port        = 8080
      target_port = 80
    }

    type = "ClusterIP"
  }
}


/* 
resource "kubernetes_ingress" "_2048_ingress" {
  metadata {
    name = "terraform-2048-ingress"
  }

  spec {
    backend {
      service_name = "MyApp1"
      service_port = 8080
    }

    rule {
      http {
        path {
          backend {
            service_name = "terraform-2048-service"
            service_port = 8080
          }

          path = "/2048/*"
        }

      }
    }

  }
} */