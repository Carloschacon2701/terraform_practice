output "last_ami" {
  value       = data.aws_ami.latest_ubuntu.image_id
  description = "aws UBUNTU ami id"

}
