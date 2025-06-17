terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }

  required_version = "~> 1.12.1"
}

provider "aws" {
  region = "us-east-2"

}
