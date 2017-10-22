provider "google" {
  region = "${var.region}"
  project = "${var.project_id}"
  credentials = "${file(var.account_file_path)}"
}


resource "google_compute_network" "auto-vpc" {
  name                    = "${var.project_tag}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "auto-subnet" {
  name          = "${var.project_tag}-subnet-1"
  ip_cidr_range = "192.168.101.0/24"
  network       = "${google_compute_network.auto-vpc.self_link}"
  region        = "${var.region}"
  private_ip_google_access = "false"
}

resource "google_compute_subnetwork" "auto-subnet" {
  name          = "${var.project_tag}-subnet-2"
  ip_cidr_range = "192.168.102.0/24"
  network       = "${google_compute_network.auto-vpc.self_link}"
  region        = "${var.region}"
  private_ip_google_access = "false"
}

resource "google_compute_subnetwork" "auto-subnet" {
  name          = "${var.project_tag}-subnet-3"
  ip_cidr_range = "192.168.103.0/24"
  network       = "${google_compute_network.auto-vpc.self_link}"
  region        = "${var.region}"
  private_ip_google_access = "false"
}