# providers.tf

provider "kubernetes" {
	config_path = "~/.kube/k3sconfig"
}

provider "helm" {
	kubernetes = {
		config_path = "~/.kube/k3sconfig"
	}
}
