# nats.tf

resource "helm_release" "nats"{
	name = "nats"
	repository = "https://nats-io.github.io/k8s/helm/charts/"
	chart = "nats"
	namespace = "sumcrowds"
}
