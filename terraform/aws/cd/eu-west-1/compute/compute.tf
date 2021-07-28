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

resource "aws_iam_policy" "ssm_agent" {
  name        = "ssm-agent"
  description = "Allow jenkins to connect to SSM"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply",
          "ssm:ListInstanceAssociations",
          "ssm:UpdateInstanceInformation",
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_agent" {
  role       = module.jenkins.instance_role_name
  policy_arn = aws_iam_policy.ssm_agent.arn
}

# Outputs
output "jenkins_public_ip" {
  value = module.jenkins.public_ip
}
