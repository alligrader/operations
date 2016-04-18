resource "digitalocean_droplet" "docker-agent" {
    image = "coreos-stable"
    name = "docker-agent"
    region = "nyc2"
    size = "512mb"
    private_networking = true

    ssh_keys = [1827636]

    connection {
        user = "root"
        type = "ssh"
        agent = false
        private_key = "${file("/Users/robbiemckinstry/.ssh/digital_ocean")}"
        timeout = "2m"
    }
}
