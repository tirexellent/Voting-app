output "vote_service_url" {
  value = "Run: minikube service vote --url"
}

output "result_service_url" {
  value = "Run: minikube service result --url"
}

output "color_service_url" {
  value = var.is_minikube ? "Run: minikube service color-service --url" : "Check LoadBalancer"
}
