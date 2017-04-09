variable "username" {
    type = "string"
}

variable "password" {
    type        = "string"
    description = "The password to provision the machines"
}

variable "server" {
  description = "The address and port of the Kubernetes API server"
}

variable "cluster_ca_certificate" {
  description = "This is the cert used to connect to the Kubernetes instance"
}

variable "frontend_configuration" {
  description = "The value of the frontend deployment specification"
}

variable "api_configuration" {
  description = "The value of the api deployment specification"
}

variable "autograder_configuration" {
  description = "The value of the autograder deployment specification"
}

resource "null_resource" "kubernetes_resource" {

  triggers {
    server = "${var.server}"
  }

  provisioner "local-exec" {
    command = "touch ${path.module}/kubeconfig"
  }

  provisioner "local-exec" {
    command = "echo '${var.cluster_ca_certificate}' > ${path.module}/ca.pem"
  }

  # Run the configure kubectl
  # provisioner "local-exec" {
  #   command = "gcloud container clusters get-credentials alligrader-cluster"
  # }

  # Deploy the Frontend
  provisioner "local-exec" {
    command = "kubectl apply --kubeconfig=${path.module}/kubeconfig --server=${var.server} --certificate-authority=${path.module}/ca.pem --username=${var.username} --password=${var.password} -f - <<EOF\n${var.frontend_configuration}\nEOF"
    

    # command = "echo '${var.frontend_configuration}' | kubectl apply --server=${var.server} --username=${var.username} --password=${var.password} -f -"
  }

/*
  # Deploy the Autograder
  provisioner "local-exec" {
    command = "echo '${var.autograder_configuration}' | kubectl apply --server=${var.server} --username=${var.username} --password=${var.password} -f -"
  }

  # Deploy the API
  provisioner "local-exec" {
    command = "echo '${var.api_configuration}' | kubectl apply --server=${var.server} --username=${var.username} --password=${var.password} -f -"
  }
*/
}
