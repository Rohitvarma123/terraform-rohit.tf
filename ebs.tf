resource "aws_ebs_volume" "my_volume" {
  availability_zone = "us-west-1a"
  size              = 8
  tags = {
    Name = "MyEBSVolume"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.my_volume.id
  instance_id = aws_instance.web.id
  force_detach = true
}
