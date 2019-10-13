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

module "private_service_access" {
  source  = "/home/sharad/test/tgsd/modules/private_service_access"
  project_id = "spikey-prem"
  vpc_network = "vpc-prem"
}

module "cloud-sql-gdpr-us" {
  source  = "/home/sharad/test/tgsd/modules/mysql"

  project_id = "spikey-prem"
  name = "gdprsql"
  database_version = "MYSQL_5_6"
  region = "us-east4"
  zone = "a"
 
  additional_users = [
  {
  name = "GDPRSegInAgr"
  password = "4sk2u2Ab7jH"
  },
  {
  name = "GDPRSegInGen"
  }

  ]
}
