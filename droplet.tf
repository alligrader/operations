resource "digitalocean_droplet" "swarm-leader" {
    # image = "coreos-stable"
    image = "ubuntu-14-04-x64"
    name = "swarm-leader"
    region = "nyc2"
    size = "512mb"
    private_networking = true
    depends_on = ["digitalocean_droplet.consul"]

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
            "docker run --rm swarm create",
            "sleep 30 && docker run -d -p 4000:4000 swarm manage -H :4000  --advertise ${digitalocean_droplet.swarm-leader.ipv4_address}:4000 consul://${digitalocean_droplet.consul.ipv4_address}:8500"
        ]
    }
}

resource "digitalocean_droplet" "swarm-follower1" {
    image = "ubuntu-14-04-x64"
    name = "swarm-follower1"
    region = "nyc2"
    size = "512mb"
    private_networking = true
    depends_on = ["digitalocean_droplet.consul", "digitalocean_droplet.swarm-leader"]


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
            "sleep 30 && docker run -d swarm join --advertise=${self.ipv4_address}:2375 consul://${digitalocean_droplet.consul.ipv4_address}:8500"
        ]
    }
}

resource "digitalocean_droplet" "swarm-follower2" {
    image = "ubuntu-14-04-x64"
    name = "swarm-follower2"
    region = "nyc2"
    size = "512mb"
    private_networking = true
    depends_on = ["digitalocean_droplet.consul", "digitalocean_droplet.swarm-leader"]


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
            "sleep 30 && docker run -d swarm join --advertise=${self.ipv4_address}:2375 consul://${digitalocean_droplet.consul.ipv4_address}:8500"
        ]
    }
}

resource "digitalocean_droplet" "consul" {
    image = "ubuntu-14-04-x64"
    name = "consul"
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
            "sleep 30 && docker run -d -p 8500:8500 --name=consul progrium/consul -server -bootstrap"
        ]
    }
}
