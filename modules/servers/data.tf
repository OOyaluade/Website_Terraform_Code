# Purpose: This file is used to define the data sources that will be used to create the servers.
data "aws_ami" "amazon_machine_image" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.6.20250303.0-kernel-6.1-x86_64"]
  }
}



# data "aws_instance" "name" {

# }