output "instance_role_name" {
  value = aws_iam_role.role.name
}

output "public_ip" {
  value = aws_instance.instance.*.public_ip
}
