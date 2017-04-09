variable "username" {
    type = "string"
}

variable "password" {
    type        = "string"
    description = "The password to provision the machines"
}

output "kubernetes-IP" {
  value = "${google_container_cluster.primary.endpoint}"
}


module "alligrader-on-kubernetes" {
  source                   = "./kubernetes"
  server                   = "${google_container_cluster.primary.endpoint}"
  frontend_configuration   = "${file("deployments/frontend_configuration.yaml")}"
  api_configuration        = "${file("deployments/api_configuration.yaml")}"
  autograder_configuration = "${file("deployments/autograder_configuration.yaml")}"
  username                 = "${var.username}"
  password                 = "${var.password}"
  cluster_ca_certificate   = "${google_container_cluster.primary.cluster_ca_certificate}"
}

provider "google" "alligrader-primary" {
  credentials = "${file("alligrader.json")}"
  project     = "alligrader2018"
  region      = "us-east1"
}

resource "google_container_cluster" "primary" {
  name               = "alligrader-cluster"
  zone               = "us-east1-b"
  description        = "This cluster is the Alligrader test cluster."
  node_version       = "1.6.0"
  initial_node_count = 1

  master_auth {
    username = "${var.username}"
    password = "${var.password}"
  }

  node_config {
    machine_type = "g1-small"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
