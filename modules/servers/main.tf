resource "aws_instance" "aws_ami" {

  ami                         = data.aws_ami.amazon_machine_image.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  security_groups             = [var.security_groups]
  associate_public_ip_address = var.associate_public_ip
  key_name                    = aws_key_pair.login_key.key_name


  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file(local.ssh_private_key_local_file)
  }
  provisioner "remote-exec" {
    # remote exec must proceed using super user privilege
    inline = [
      "cd ~",
      "sudo rm /etc/systemd/system/website.service",
      "sudo yum update -y",
      "sudo yum install -y git python3 python3-pip",
      "pip3 install --updrade pip",
      "git clone https://github.com/OOyaluade/Website.git",
      "cd Website ",
      "yum install python3.12-venv",
      "python3 -m venv venv",
      "source venv/bin/activate",
      "python3 -m pip install --upgrade pip",
      "pip3 install -r requirements.txt ",
      "pip install gunicorn",
      "sudo mv website.service /etc/systemd/system/",
      "sudo systemctl daemon-reload",
      "sudo systemctl start website.service",
      "sudo systemctl enable website.service",
      "sudo yum install nginx -y",
      "sudo mv website.conf /etc/nginx/conf.d/",
      "sudo systemctl restart nginx",

      "curl http://$(hostname -I)",

      "exit"
    ]
  }
  tags = {
    Name = var.instance_name_tag
  }

}

resource "tls_private_key" "instance_rsa_key_generator" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "save_rsa_private_key_locally" {
  content  = local.ssh_private_key
  filename = local.ssh_private_key_local_file
  provisioner "local-exec" {
    command = "chmod 600 ${local.ssh_private_key_local_file}"

  }
}

resource "local_file" "save_rsa_public_key_locally" {
  content  = local.ssh_public_key
  filename = local.ssh_public_key_local_file
  provisioner "local-exec" {
    command = "chmod 644 ${local.ssh_public_key_local_file}"

  }
}


resource "random_id" "key_surffix" {
  byte_length = 3

}

resource "aws_key_pair" "login_key" {
  key_name   = "deployer_${random_id.key_surffix.hex}"
  public_key = local.ssh_public_key

}

