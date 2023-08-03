terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "cassandra_client_request_unavailable_write_incident" {
  source    = "./modules/cassandra_client_request_unavailable_write_incident"

  providers = {
    shoreline = shoreline
  }
}