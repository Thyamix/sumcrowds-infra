# ingress.tf

resource "kubernetes_ingress_v1" "sumcrowds" {
	metadata {
		name = "sumcrowds-ingress"
		namespace = "sumcrowds"
	}
	spec {
		ingress_class_name = "traefik"

		rule {
			host = "app.sumcrowds.com"
			http {
				path {
					path = "/api"
					path_type = "Prefix"
					backend {
						service {
							name = "backend-svc"
							port {
								number = 8080
							}
						}
					}
				}
			}
		}
		rule {
			host = "app.sumcrowds.com"
			http {
				path {
					path = "/ws"
					path_type = "Prefix"
					backend {
						service {
							name = "backend-svc"
							port {
								number = 8080
							}
						}
					}
				}
			}
		}
		rule {
			host = "app.sumcrowds.com"
			http {
				path {
					path = "/"
					path_type = "Prefix"
					backend {
						service {
							name = "frontend-svc"
							port {
								number = 3000
							}
						}
					}
				}
			}
		}
	}
}
