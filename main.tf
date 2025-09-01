terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.22"
    }
  }
}

provider "kubernetes" {
  config_path    = var.kubeconfig_path
}

# Apply all YAML manifests in the specified folder
resource "kubernetes_manifest" "voting_app" {
  for_each = fileset("${path.module}/${var.k8s_folder}", "*.yaml")

  manifest = merge(
    yamldecode(file("${path.module}/${var.k8s_folder}/${each.key}")),
    { metadata = merge(
        lookup(yamldecode(file("${path.module}/${var.k8s_folder}/${each.key}")), "metadata", {}),
        { namespace = var.namespace }
      )
    }
  )
}


# Override problematic LoadBalancer service for Minikube
resource "kubernetes_service" "color_service_override" {
  count = var.is_minikube ? 1 : 0

  metadata {
    name      = "color-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "color"
    }

    port {
      port        = 80
      target_port = 80
      node_port   = var.color_service_nodeport
    }

    type = "NodePort"
  }
}
