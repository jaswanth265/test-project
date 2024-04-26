
provider "aws" {
  #shared_credentials_files = ["/Users/jaswanthkarnam/.aws/credentials"]
  #access_key = ""
  #secret_key = ""
  region                   = "us-west-2"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}