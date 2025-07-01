terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket         = "edwh-terraform-state"
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "components_tf-lockid"
    encrypt        = true
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c087b865e2e7ab6a"
  instance_type = "t3.micro"

  tags = {
    Name = var.instance_name
  }
}
