# backend.tf

resource "kubernetes_service_v1" "frontend-svc" {
	metadata {
		name = "frontend-svc"
		namespace = "dev"
	}
	spec {
		selector = {
			app = "frontend"
		}
		type = "LoadBalancer"
		port {
			name = "frontend"
			port = 3000
			target_port = 80
		}
	}
}

resource "kubernetes_deployment_v1" "frontend" {
	metadata {
		name = "frontend"
		namespace = "dev"
	}
	spec {
		selector {
			match_labels = {
				app = "frontend"
			}
		}
		replicas = 5
		template {
			metadata {
				labels = {
					app = "frontend"
				}
			}
			spec {
				container {
					name = "frontend"
					image = "git.thyamix.com/thyamix/sumcrowds-frontend:latest"
					image_pull_policy = "Always"
					port {
						container_port = 80
					}
				}
			}
		}
	}
}

