# ingress.tf

resource "kubernetes_ingress_v1" "sumcrowds" {
	metadata {
		name = "sumcrowds-ingress"
		namespace = "dev"
	}
	spec {
		rule {
			host = "sumcrowdsapi.thyamix.com"
			http {
				path {
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
			host = "sumcrowds.thyamix.com"
			http {
				path {
					backend {
						service {
							name = "frontend-svc"
							port {
								number = 80
							}
						}
					}
				}
			}
		}
	}
}
