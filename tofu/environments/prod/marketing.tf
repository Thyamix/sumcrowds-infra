# backend.tf

resource "kubernetes_service_v1" "marketing-svc" {
	metadata {
		name = "marketing-svc"
		namespace = "sumcrowds"
	}
	spec {
		selector = {
			app = "marketing"
		}
		type = "ClusterIP"
		port {
			name = "marketing"
			port = 4000
			target_port = 80
		}
	}
}

resource "kubernetes_deployment_v1" "marketing" {
	metadata {
		name = "marketing"
		namespace = "sumcrowds"
	}
	spec {
		selector {
			match_labels = {
				app = "marketing"
			}
		}
		replicas = 1
		template {
			metadata {
				labels = {
					app = "marketing"
				}
			}
			spec {
				container {
					name = "marketing"
					image = "git.thyamix.com/thyamix/sumcrowds-marketing:8f5f990aad"
					image_pull_policy = "Always"
					port {
						container_port = 80
					}
				}
			}
		}
	}
}

