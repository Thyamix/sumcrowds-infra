# backend.tf

resource "kubernetes_config_map_v1" "backend_config" {
	metadata {
		name = "backend-config"
		namespace = "dev"
	}
	data = {
		"config.toml" = file("${path.module}/../../secrets/dev/config/config.toml")
	}
}

resource "kubernetes_deployment_v1" "backend" {
	metadata {
		name = "backend"
		namespace = "dev"
	}
	spec {
		selector {
			match_labels = {
				app = "backend"
			}
		}
		replicas = 1
		template {
			metadata {
				labels = {
					app = "backend"
				}
			}
			spec {
				container {
					name = "backend"
					image = "git.thyamix.com/thyamix/sumcrowds-counter:prod-latest"
					port {
						container_port = 8080
					}
					volume_mount {
						name = "config-volume"
						mount_path = "/app/config.dev.toml"
						sub_path = "config.toml"
					}
					env {
						name = "CONFIG_ENV"
						value = "dev"
					}
					env {
						name = "CONFIG_PATH"
						value = "/app/config.dev.toml"
					}
					env {
						name = "ENV_PATH"
						value = "/app/.env.prod"
					}
					env_from {
						secret_ref {
							name = "backend"
						}
					}
				}
				volume {
					name = "config-volume"
					config_map {
						name = kubernetes_config_map_v1.backend_config.metadata[0].name
					}
				}
			}
		}
	}
}

