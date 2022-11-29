// provider "kubernetes" {
//   config_path    = "./kubeconfig-aws-sa.yaml"
// }

resource "kubernetes_namespace" "f5-k8s-ns" {
  metadata {
    name = var.k8snamespace
  }
}

resource "kubernetes_manifest" "service_app2" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "app2"
        "service" = "app2"
      }
      "name" = "app2"
      "namespace" = "${var.k8snamespace}"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "app2-80"
          "nodePort" = var.nodePort
          "port" = 80
          "protocol" = "TCP"
        },
      ]
      "selector" = {
        "app" = "app2"
      }
      "type" = "NodePort"
    }
  }
}

resource "kubernetes_manifest" "deployment_app2" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "app2"
        "version" = "v1"
      }
      "name" = "app2"
      "namespace" = "${var.k8snamespace}"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "app2"
          "version" = "v1"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "app2"
            "version" = "v1"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "service_name"
                  "value" = "app2"
                },
              ]
              "image" = "registry.gitlab.com/arcadia-application/app2/app2:latest"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "app2"
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
