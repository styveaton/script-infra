/*author aton85*/
#https://registry.terraform.io/providers/terraform-lxd/lxd/latest/docs/resources/volume_container_attach
terraform {
  required_providers {
    lxd = {
      source = "terraform-lxd/lxd"
    }
  }
}

provider "lxd" {
  generate_client_certificates = true
  accept_remote_certificate    = true
}

#create Pool and all volume here

resource "lxd_storage_pool" "pool1" {
  name = "mypool"
  driver = "dir"
  config = {
    source = "/var/lib/lxd/storage-pools/mypool"
  }
}

resource "lxd_volume" "jenkins-data" {
  name = "jenkins-data"
  pool = "${lxd_storage_pool.pool1.name}"
}



# Create LXC Container
resource "lxd_container" "k8-master1" {
  name      = "k8-master1"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles  = ["default"]
}

resource "lxd_container" "docker-server-lab" {
  name      = "docker-server-lab"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles  = ["default"]
}

resource "lxd_container" "jenkins-server-lab" {
  name      = "jenkins-server-lab"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles  = ["default"]

device {
    name = "jenkins-data"
    type = "disk"
    properties = {
      path = "/opt/"
      source = "${lxd_volume.jenkins-data.name}"
      pool = "${lxd_storage_pool.pool1.name}"
    }
   }                  

}

resource "lxd_container" "sonarqube-server-lab" {
  name      = "sonarqube-server-lab"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles  = ["default"]
}

resource "lxd_container" "k8-worker1" {
  name      = "k8-worker1"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles  = ["default"]
}

resource "lxd_container" "k8-worker2" {
  name      = "k8-worker2"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles  = ["default"]
}

resource "lxd_container" "ansible-server-lab" {
  name      = "ansible-server-lab"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles  = ["default"]
}

resource "lxd_container" "nagiosxi-server-lab" {
  name      = "nagiosxi-server-lab"
  image     = "ubuntu:20.04"
  ephemeral = false
  profiles  = ["default"]
}

