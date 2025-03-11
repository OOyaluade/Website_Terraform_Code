

output "instance_webserver_address_1" {
  value = module.server_1[*].webserver_address
}


output "aws_route53_zone_details" {
  value = module.network.aws_route53_zone_details
  
}