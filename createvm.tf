# Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 4
}
# Create VM #1
resource "google_compute_instance" "vm_instance_public" {
  name = "${var.app_name}-vm-${random_id.instance_id.hex}"
  machine_type = "f1-micro"
  zone = var.gcp_zone_1
  hostname = "${var.app_name}vm-${random_id.instance_id.hex}.testing"
  tags = ["ssh","http"]
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  metadata_startup_script = <<SCRIPT
    sudo apt-get update | 
    sudo apt-get install -yq build-essential apache2
    SCRIPT

  network_interface {
    network = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.public_subnet_1.name
  
  access_config { }
  }
}
