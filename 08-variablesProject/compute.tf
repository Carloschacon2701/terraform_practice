data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

resource "aws_instance" "compute" {
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = var.ec2_volume_config.type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_size
    volume_type           = "gp3"
  }

  tags = merge(var.additional_tags, {
    managedBy = "terraform"
  })
}
