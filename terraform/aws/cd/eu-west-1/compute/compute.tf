module "jenkins" {
  source = "../../../../modules/aws/instance"

  instance_name      = "jenkins"
  key_name           = "htpc"
  instance_type      = "t3.medium"
  security_group_ids = list(data.terraform_remote_state.networking.outputs.default_sg)
  subnet_id          = list(data.terraform_remote_state.networking.outputs.public_subnet)
}

resource "aws_iam_policy" "allow_jenkins_live_role" {
  name        = "jenkins-live-role"
  description = "Allow jenkins to assume the jenkins role in the live account"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "sts:AssumeRole"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:iam::118657673301:role/jenkins"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = module.jenkins.instance_role_name
  policy_arn = aws_iam_policy.allow_jenkins_live_role.arn
}

# Outputs
output "jenkins_public_ip" {
  value = module.jenkins.public_ip
}
