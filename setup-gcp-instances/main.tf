terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "tough-victor-459408-e1"
  region  = "us-central1"
  zone    = "us-central1-c"
}


resource "google_compute_firewall" "allow-redis" {
  name    = "allow-redis"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["6379"]
  }

  source_ranges = ["49.37.169.126"]
  target_tags = ["allow-redis"]
  direction   = "INGRESS"

}


resource "google_compute_instance" "n1_instance" {
    name         = "n1-instance-dev"
    machine_type = "n1-standard-2"
    zone         = "us-central1-c"
    
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-12"
        }
    }
    
    network_interface {
        network = "default"
        access_config {}
    }

    metadata = {
        ssh-keys = "girish:${file("~/.ssh/gcp.pub")}"  
    }
    tags = ["allow-redis"]
}