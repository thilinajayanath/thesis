resource "aws_vpc" "platform" {
  cidr_block = "172.30.0.0/16"
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.platform.id
  cidr_block              = "172.30.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.platform.id

  tags = {
    Name = "main-internet-gateway"
  }
}

resource "aws_route_table" "public_subnet" {
  vpc_id = aws_vpc.platform.id
  
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_route_table_association" "igw" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_subnet.id
}

resource "aws_route" "internet" {
  route_table_id            = aws_route_table.public_subnet.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_security_group" "default_sg" {
  name        = "default-sg"
  description = "Default security group"
  vpc_id      = aws_vpc.platform.id
}

resource "aws_security_group_rule" "allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default_sg.id
}

# Outputs

output "default_sg" {
  value = aws_security_group.default_sg.id
}

output "public_subnet" {
  value = aws_subnet.public_subnet_1.id
}
