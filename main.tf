// Configure the Google Cloud provider
provider "google" {
 project     = "spikey-prem"
 region      = "us-east4"
 credentials = "${file("account.json")}"
}

provider "google-beta" {
  project     = "spikey-prem"
  region      = "us-east4"
  credentials = "${file("account.json")}"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

module "cloud-sql-gdpr-us" {
# source = "git@github.com:procter-gamble/terraform-module-pg-cloud-sql?ref=v1.2.0"
  source = "/home/sharad/PG_GIT/terraform-module-pg-cloud-sql"
  project_id = "spikey-prem"
  mysql_name = "gdprsql"
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
