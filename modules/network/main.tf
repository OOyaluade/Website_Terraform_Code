resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = {
    Name = "HomeLab"
  }
}


resource "aws_subnet" "public_subnet" {
  for_each                = tomap(local.public_regon_subnet)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = "us-east-1${each.value}"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_HomeLab_us-east-1-${each.value}"
  }
}


resource "aws_subnet" "private_subnet" {
  for_each          = tomap(local.private_regon_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.key
  availability_zone = "us-east-1${each.value}"

  tags = {
    Name = "Private_HomeLab_us-east-1-${each.value}"
  }
}




resource "aws_security_group" "instance_security_groups" {
  name        = "allow_ICMP_HTTP_SSH"
  description = "Allows http, ssh, and ICMP traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "Instance_security_group"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}


resource "aws_route_table_association" "public_association" {
  for_each       = aws_subnet.public_subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_default_route.id
}

resource "aws_route_table" "public_default_route" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public_default_route"
  }
}

resource "aws_route" "public_route_default" {
  depends_on             = [aws_route_table.public_default_route]
  route_table_id         = aws_route_table.public_default_route.id
  gateway_id             = aws_internet_gateway.gw.id
  destination_cidr_block = "0.0.0.0/0"

}


resource "aws_security_group_rule" "ping_in" {
  type              = "ingress"
  to_port           = 0
  protocol          = "icmp"
  from_port         = 8
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance_security_groups.id
}

resource "aws_security_group_rule" "ping_out" {
  type              = "egress"
  to_port           = 0
  protocol          = "icmp"
  from_port         = 8
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance_security_groups.id
}

resource "aws_security_group_rule" "inbound_http_80" {
  type              = "ingress"
  to_port           = 80
  protocol          = "tcp"
  from_port         = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance_security_groups.id
}


resource "aws_security_group_rule" "outbound_http_443" {
  type              = "egress"
  to_port           = 443
  protocol          = "tcp"
  from_port         = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance_security_groups.id
}
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  to_port           = 22
  protocol          = "tcp"
  from_port         = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance_security_groups.id
}

