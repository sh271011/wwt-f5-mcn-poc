// provider "kubernetes" {
//   config_path    = "./kubeconfig-aws-sa.yaml"
// }

resource "kubernetes_namespace" "f5-k8s-ns" {
  metadata {
    name = var.k8snamespace
  }
}

resource "kubernetes_manifest" "service_backend" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "backend"
        "service" = "backend"
      }
      "name" = "backend"
      "namespace" = "${var.k8snamespace}"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "backend-80"
          "nodePort" = var.nodePort
          "port" = 80
          "protocol" = "TCP"
        },
      ]
      "selector" = {
        "app" = "backend"
      }
      "type" = "NodePort"
    }
  }
}

resource "kubernetes_manifest" "deployment_backend" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "backend"
        "version" = "v1"
      }
      "name" = "app2"
      "namespace" = "${var.k8snamespace}"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "backend"
          "version" = "v1"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "backend"
            "version" = "v1"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "service_name"
                  "value" = "backend"
                },
              ]
              "image" = "registry.gitlab.com/arcadia-application/back-end/backend:latest"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "backend"
              "ports" = [
                {
                  "containerPort" = 80
                  "protocol" = "TCP"
                },
              ]
            },
          ]
        }
      }
    }
  }
}
