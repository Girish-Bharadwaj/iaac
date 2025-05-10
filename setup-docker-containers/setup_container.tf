terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "ubuntu" {
  name         = "ubuntu-ssh"
  build {
    context = "${path.module}/Dockerfile"
  }
  keep_locally = false
}

locals {
  containers = {
    "ubuntu_1" = 2221
    "ubuntu_2" = 2222
    "ubuntu_3" = 2223
  }
}

resource "docker_container" "ubuntu" {
  for_each = local.containers

  image   = docker_image.ubuntu.image_id
  name    = "container-${each.key}"

  ports {
    internal = 22
    external = each.value
  }
}
