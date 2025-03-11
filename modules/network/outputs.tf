output "subnet_id_list" {
  value = local.cidr_block
}

output "public_subnet" {
  value = aws_subnet.public_subnet

}


output "private_subnet" {
  value = aws_subnet.private_subnet

}

output "security_groups" {
  value = aws_security_group.instance_security_groups

}

output "route_tables_details" {
  value = data.aws_route_tables.route_tables_details

}


output "aws_route53_zone_details" {
  value = data.aws_route53_zone.personal
  
}