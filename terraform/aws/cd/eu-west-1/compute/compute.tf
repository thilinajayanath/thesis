module "jenkins" {
  source = "../../../../modules/aws/instance"

  instance_name      = "jenkins"
  key_name           = "htpc"
  instance_type      = "t3.medium"
  security_group_ids = list(data.terraform_remote_state.networking.outputs.default_sg)
  subnet_id          = list(data.terraform_remote_state.networking.outputs.public_subnet)

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "aws:SourceVpc": "vpc-0d569db4ca6d650af"
        }
      }
    }
  ]
}
EOF
}

# Outputs
output "jenkins_public_ip" {
  value = module.jenkins.public_ip
}
