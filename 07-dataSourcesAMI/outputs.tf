output "last_ami" {
  value       = data.aws_ami.latest_ubuntu.image_id
  description = "aws UBUNTU ami id"

}

output "vpc_id" {
  value = data.aws_vpc.selected.id
}


output "iam_policy" {
  value = data.aws_iam_policy_document.iam_policy.json

}
