# postgres.tf

resource "kubernetes_persistent_volume_claim_v1" "postgres-pvc" {
	metadata {
		name = "postgres-pvc"
		namespace = "dev"
	}
	spec {
		access_modes = ["ReadWriteOnce"]
		resources {
			requests = {
				storage = "5Gi"
			}
		}
	}
	 
}

resource "kubernetes_service_v1" "postgres-svr" {
	metadata {
		name = "postgres-svr"
		namespace = "dev"
	}
	spec {
		selector = {
			app = "postgres"
		}
		type = "LoadBalancer"
		port {
			name = "postgres"
			port = 5432
			target_port = 5432
		}
	}
}

resource "kubernetes_deployment_v1" "postgres" {
	metadata {
		name = "postgres"
		namespace = "dev"
	}
	spec {
		selector {
			match_labels = {
				app = "postgres"
			}
		}
		replicas = 1
		template {
			metadata {
				labels = {
					app = "postgres"
				}
			}
			spec {
				container {
					name = "postgres"
					image = "docker.io/postgres:14"
					port {
						container_port = 5432
					}
					volume_mount {
						name = "postgres-storage"
						mount_path = "/var/lib/postgresql/data"
					}
					volume_mount {
						name = "postgres-config-volume"
						mount_path = "/var/lib/postgresql/postgresql.conf"
						sub_path = "postgresql.conf"
					}
					env_from {
						secret_ref {
							name = "postgres"
						}
					}
				}
				volume {
					name = "postgres-storage"
					persistent_volume_claim {
						claim_name = "postgres-pvc"
					}
				}
				volume {
					name = "postgres-config-volume"
				}
			}
		}
	}
}

