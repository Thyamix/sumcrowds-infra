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
			port = 80
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
		replicas = 1
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
					env {
						name = "VITE_APIURL"
						value = "http://192.168.1.75:8080/api/"
					}
					env {
						name = "VITE_WSURL"
						value = "http://192.168.1.75:8080/ws/"
					}
				}
			}
		}
	}
}

