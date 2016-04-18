resource "digitalocean_droplet" "swarm-leader" {
    # image = "coreos-stable"
    image = "ubuntu-14-04-x64"
    name = "swarm-leader"
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

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update -q",
            "sudo apt-get install -yq curl",
            "curl -sSL https://get.docker.com/ | sh",
            "docker run --rm swarm create"
        ]
    }
}

resource "digitalocean_droplet" "swarm-follower1" {
    image = "ubuntu-14-04-x64"
    name = "swarm-follower1"
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

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update -q",
            "sudo apt-get install -yq curl",
            "curl -sSL https://get.docker.com/ | sh",
        ]
    }
}

resource "digitalocean_droplet" "swarm-follower2" {
    image = "ubuntu-14-04-x64"
    name = "swarm-follower2"
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

    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update -q",
            "sudo apt-get install -yq curl",
            "curl -sSL https://get.docker.com/ | sh",
        ]
    }
}
