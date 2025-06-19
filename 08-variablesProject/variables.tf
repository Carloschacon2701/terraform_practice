variable "ec2_volume_config" {
  type = object({
    type = string
    size = number
  })

  description = "EC2 instance size and type for ec2"

  default = {
    size = 10
    type = "t2.micro"
  }
}

variable "ec2_volume_size" {
  type        = number
  default     = 10
  description = "The size and type of the root block volume for ec2 instances."
}


variable "additional_tags" {
  type = map(string)
}
