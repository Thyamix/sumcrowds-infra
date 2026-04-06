# cleanup.tf

resource "kubernetes_cron_job_v1" "cleanup_cron" {
	metadata {
		name = "cleanup-cron"
		namespace = "dev"
	}
	spec {
		schedule = "@midnight"
		job_template {
			metadata {
				name = "cleanup-job"
				namespace = "dev"
			}
			spec {
				template {
					metadata {
						name = "cleanup"
					}
					spec {
						container {
							name = "cleanup"
							image = "git.thyamix.com/thyamix/sumcrowds-cleanup:latest"
							image_pull_policy = "Always"
							volume_mount {
								name = "config-volume"
								mount_path = "/app/config.dev.toml"
								sub_path = "config.toml"
							}
							env_from {
								secret_ref {
									name = "backend"
								}
							}
							env {
								name = "CONFIG_ENV"
								value = "dev"
							}
							env {
								name = "CONFIG_PATH"
								value = "/app/config.dev.toml"
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
	}
}
