resource "aws_instance" "web" {
  ami                         = "ami-010e099e651d8635e"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  vpc_id      = aws_vpc.project_vpc.id
  description = "Security group for web server"

}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.web_sg.id
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  description       = "Allow HTTPS traffic"
}
