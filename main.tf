#Execute this first time before running "gcloud auth application-default login"
provider "google" {
  credentials = file("hybrid-life-319008-5e7bd073512b.json")
  project     = "hybrid-life-319008"
  region      = "us-west1"
  zone        = "us-west1-b"

}


module "network" {
    
    source = "terraform-google-modules/network/google"
#    version = "~> 3.3.0"
    network_name = "vpc-network-terraform"
        project_id = var.project

    subnets = [
        {
            subnet_name = "subnet-01"
            subnet_ip = var.cidr
            subnet_region = var.region
        }
    ]

    secondary_ranges = {
        subnet-01 = []
    }
}

module "net-firewall" {
  source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
#  version = "~> 1.3.0"
  project_id              = var.project
  network                 = module.network.network_name
 internal_ranges_enabled = true
 internal_ranges = ["10.0.0.0/16"]

}

