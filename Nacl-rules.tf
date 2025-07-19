resource "aws_network_acl" "main_nacl" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-nacl"
  }
}

resource "aws_network_acl_rule" "inbound_ssh" {
  network_acl_id = aws_network_acl.main_nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "outbound_all" {
  network_acl_id = aws_network_acl.main_nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}


