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

module "cloud-sql-gdpr-us" {
  source = "/home/sharad/PG_GIT/terraform-module-pg-cloud-sql"
# source = "/home/sharad/PG_GIT/terraform-module-pg-cloud-sql?ref=ds/ip-config-fix"
  project_id = "spikey-prem"
  mysql_name = "gdprsql-${random_id.instance_id.hex}"
  mysql_version = "MYSQL_5_6"
  region = "us-east4"
  zone = "a"
  private_network = "vpc-prem"
  additional_users = [
  {
  name = "GDPRSegAggregate"
  password = "4sk2u2Ab7jH"
  },
  {
  name = "GDPRSegGenerate"
  }

  ]
}
