#  provider "kubernetes" {
#    config_path    = "./kubeconfig-azure-atcbld.yaml"
#  }

resource "kubernetes_namespace" "f5-k8s-ns" {
  metadata {
    name = var.k8snamespace
  }
}

resource "kubernetes_manifest" "service_app3" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "app3"
        "service" = "app3"
      }
      "name" = "app3"
      "namespace" = "${var.k8snamespace}"
    }
    "spec" = {
      "ports" = [
        {
          "name" = "app3-80"
          "nodePort" = var.nodePort
          "port" = 80
        },
      ]
      "selector" = {
        "app" = "app3"
      }
      "type" = "NodePort"
    }
  }
}

resource "kubernetes_manifest" "deployment_app3" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "app3"
        "version" = "v1"
      }
      "name" = "app3"
      "namespace" = "${var.k8snamespace}"
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "app3"
          "version" = "v1"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "app3"
            "version" = "v1"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "service_name"
                  "value" = "app3"
                },
              ]
              "image" = "registry.gitlab.com/arcadia-application/app3/app3:latest"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "app3"
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