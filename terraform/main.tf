terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
 }
resource "aws_vpc" "ownvpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags={
    Name="own-vpc"
  }
}
module "my-subnet"{
  source="./modules/subnet"
  vpc_id=aws_vpc.ownvpc.id
  subnet_cidr_block=var.subnet_cidr_block
  env=var.env
  az=var.az
}
module "my-webserver"{
  source="./modules/webserver"
  vpc_id=aws_vpc.ownvpc.id
  subnet_id=module.my-subnet.subnet.id
  env=var.env
  instance_type=var.instance_type
}
