# Subnet
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.6.0/24"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true
}

# Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  vpc_id      = aws_vpc.main.id
  description = "Allow SSH and NFS"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_efs_file_system" "my_efs" {
  creation_token = "my-efs-token"
  tags = {
    Name = "MyEFS"
  }
}

resource "aws_efs_mount_target" "my_efs_target" {
  file_system_id  = aws_efs_file_system.my_efs.id
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.ec2_sg.id]
}
