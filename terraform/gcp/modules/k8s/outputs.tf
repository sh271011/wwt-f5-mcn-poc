output "k8s_namespace_name" {
  description = "Name of namespace created"
  value = kubernetes_namespace.f5-k8s-ns.id
}

output "k8s_app_name" {
  description = "Name of app created"
  value = kubernetes_manifest.deployment_app2.object.metadata.name
}