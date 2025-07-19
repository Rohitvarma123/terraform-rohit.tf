resource "aws_instance" "web" {
  ami           = "ami-0b5358e1f13744bc7"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
