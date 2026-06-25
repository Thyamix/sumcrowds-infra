# cloudflared.tf

resource "kubernetes_deployment_v1" "cloudflared" {
	metadata {
		name = "cloudflared"
		namespace = "sumcrowds"
	}
	spec {
		replicas = 2
		selector {
			match_labels = {
				pod = "cloudflared"
			}
		}
		template {
			metadata {
				labels = {
					pod = "cloudflared"
				}
			}
			spec {
				security_context {
					sysctl {
						name = "net.ipv4.ping_group_range"
						value = "65532 65532"
					}
				}
				container {
					name = "cloudflared"
					image = "cloudflare/cloudflared:2026.6.1"
					command = ["cloudflared", "tunnel", "--no-autoupdate", "--loglevel", "info", "--metrics", "0.0.0.0:2000", "run"]
					env_from {
						secret_ref {
							name = "cloudflared"
						}
					}
					liveness_probe {
						http_get {
							path = "/ready"
							port = 2000
						}
						failure_threshold = 1
						initial_delay_seconds = 10
						period_seconds = 10
					}
				}
			}
		}
	}
}

