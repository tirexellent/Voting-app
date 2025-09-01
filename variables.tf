variable "kubeconfig_path" {
  description = "Path to kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_client_timeout" {
  description = "Timeout for Kubernetes provider"
  type        = string
  default     = "60s"
}

variable "k8s_folder" {
  description = "Folder containing Kubernetes YAML manifests"
  type        = string
  default     = "k8s-specifications"
}

variable "is_minikube" {
  description = "Flag to override LoadBalancer to NodePort for Minikube"
  type        = bool
  default     = true
}

variable "color_service_nodeport" {
  description = "NodePort for color-service in Minikube"
  type        = number
  default     = 30080
}

variable "namespace" {
  description = "Namespace for all resources"
  type        = string
  default     = "default"
}
