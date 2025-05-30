terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

resource "aws_instance" "ubuntu" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = tolist(data.aws_subnets.default.ids)[0]
  key_name      = var.key_name

  root_block_device {
    volume_size = var.volume_size
  }

  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "Ubuntu-EC2-Terraform"
  }
}