locals {
  tags = {
    Environment  = "dev"
    project_name = "my_project"
    Owner        = "your_name"

  }
}

resource "aws_vpc" "project_vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = local.tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.project_vpc.id
  cidr_block = "10.0.0.0/24"
}

resource "aws_internet_gateway" "igtw" {
  vpc_id = aws_vpc.project_vpc.id
  tags = merge(local.tags, {
    Name = "IGTW"
  })
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igtw.id
  }
  tags = local.tags
}

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
  depends_on     = [aws_internet_gateway.igtw]

}
