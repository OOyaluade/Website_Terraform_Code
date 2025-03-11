output "ami_id_output" {
  value = data.aws_ami.amazon_machine_image.id
}



output "ami_details" {
  value = data.aws_ami.amazon_machine_image.image_type

}

output "webserver_address" {
  value = "http://${aws_instance.aws_ami.public_ip}"

}

# output "aws_instance_name" {
# value = data.aws_instance.name.key_name
# }