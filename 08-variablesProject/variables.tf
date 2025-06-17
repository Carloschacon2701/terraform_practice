variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "ec2 instance type"

  validation {
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only t2.micro and t3.micro instances are supported."
  }
}

variable "volumen_type" {
  type        = string
  description = "volume type"
  default     = "gp3"
}

variable "ec2_volume_size" {
  type        = number
  default     = 10
  description = "The size and type of the root block volume for ec2 instances."
}
