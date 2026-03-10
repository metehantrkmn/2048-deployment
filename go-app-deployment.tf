resource "kubernetes_deployment" "_2048-game" {
  metadata {
    name = "go-app"
    labels = {
      deployment = "go-app-deployment"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        application = "go-app"
      }
    }

    template {
      metadata {
        labels = {
          application = "go-app"
          prometheus = "a"
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