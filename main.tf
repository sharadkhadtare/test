// Configure the Google Cloud provider
provider "google" {
 project     = "spikey-prem"
 region      = "us-west1"
 credentials = "/tmp/serviceaccount.json"
}

data "terraform_remote_state" "folders" {
  backend = "gcs"

  config {
    bucket = "sharad1971"
    prefix = "state/folders"
    credentials = "/tmp/serviceaccount.json"
  }
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
 name         = "flask-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}
