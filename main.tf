provider "google" {
  region = "${var.region}"
  project = "${var.project_id}"
  credentials = "${file(var.account_file_path)}"
}


resource "google_compute_network" "auto-vpc" {
  name                    = "${var.project_tag}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "auto-subnet-1" {
  name          = "${var.project_tag}-subnet-1"
  ip_cidr_range = "192.168.101.0/24"
  network       = "${google_compute_network.auto-vpc.self_link}"
  region        = "${var.region}"
  private_ip_google_access = "false"
}

resource "google_compute_subnetwork" "auto-subnet-2" {
  name          = "${var.project_tag}-subnet-2"
  ip_cidr_range = "192.168.102.0/24"
  network       = "${google_compute_network.auto-vpc.self_link}"
  region        = "${var.region}"
  private_ip_google_access = "false"
}

resource "google_compute_subnetwork" "auto-subnet-3" {
  name          = "${var.project_tag}-subnet-3"
  ip_cidr_range = "192.168.103.0/24"
  network       = "${google_compute_network.auto-vpc.self_link}"
  region        = "${var.region}"
  private_ip_google_access = "false"
}

resource "google_compute_firewall" "auto-firewall-rule-deny-all" {
  name    = "${var.project_tag}-firewall-rule-deny-all"
  network = "${google_compute_network.auto-vpc.self_link}"
  priority = "65534"
  deny {
    protocol = "all"
  }
}

resource "google_compute_firewall" "auto-firewall-rule-allow-internal" {
  name    = "${var.project_tag}-firewall-rule-allow-internal"
  network = "${google_compute_network.auto-vpc.self_link}"

  allow {
    protocol = "all"
  }
  source_ranges = [
    "192.168.101.0/24",
    "192.168.102.0/24",
    "192.168.103.0/24"
  ]
}

resource "google_compute_firewall" "auto-firewall-rule-bastion" {
  name    = "${var.project_tag}-firewall-rule-bastion"
  network = "${google_compute_network.auto-vpc.self_link}"
  target_tags = ["${var.bastion_tag}"]
  allow {
    protocol = "all"
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
}
