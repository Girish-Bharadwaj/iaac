# Google Cloud Setup

This script sets up Google Cloud resources using Infrastructure as Code (IaC) tools like Terraform.

## Prerequisites
- Install Terraform.
- Authenticate with Google Cloud using `gcloud auth login`.

## Steps
1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Apply the configuration:
   ```bash
   terraform apply
   ```

## Example Configuration
```hcl
provider "google" {
  credentials = file("${var.credentials_file}")
  project     = var.project_id
  region      = var.region
}

resource "google_compute_instance" "default" {
  name         = "example-instance"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
```

## Variables
- `credentials_file`: Path to the Google Cloud credentials JSON file.
- `project_id`: Google Cloud project ID.
- `region`: Region for the resources.
- `zone`: Zone for the resources.