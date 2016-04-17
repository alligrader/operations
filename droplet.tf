resource "digitalocean_droplet" "docker-agent" {
    image = "coreos-899.15.0"
    name = "docker-agent"
    region = "nyc2"
    size = "512mb"
    private_networking = true
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]

    connection {
        user = "root"
        type = "ssh"
        key_file = "${var.pvt_key}"
        timeout = "2m"
    }

    provisioner "remote-exec" {
        inline = [
            "docker ip"
        ]
    }
}
