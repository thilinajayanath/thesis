variable "assume_role_policy" {
  description = "Assume role for the instance profile"
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  type        = string
}

variable "instance_count" {
  description = "Number of instance to be created"
  default     = 1
  type        = number
}

variable "instance_name" {
  description = "Instance name"
}

variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
  type        = string
}

variable "key_name" {
  description = "Name of the ssh key"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs for the instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnets IDs where the instance should be created"
  type        = list(string)
}

variable "root_volume_size" {
  description = "Root volume disk size in GB"
  default     = 20
  type        = number
}

variable "root_volume_type" {
  description = "Root volume type"
  default     = "gp2"
  type        = string
}
