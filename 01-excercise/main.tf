terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}
resource "aws_vpc" "demo_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "demo-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = "10.0.0.0/24"  
  
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.demo_vpc.id
  cidr_block = "10.0.1.0/24"
  
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.demo_vpc.id

  
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.demo_vpc.id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }
  
}

resource "aws_route_table_association" "public_route_table_association" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}