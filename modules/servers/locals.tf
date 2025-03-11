locals {
  ssh_private_key_local_file = "${var.rsa_instance_private_keystore_location}/${var.save_rsa_private_key_locally_name}"
  ssh_public_key_local_file  = "${var.rsa_instance_public_keystore_location}/${var.save_rsa_public_key_locally_name}"
  ssh_public_key             = tls_private_key.instance_rsa_key_generator.public_key_openssh
  ssh_private_key            = tls_private_key.instance_rsa_key_generator.private_key_pem
}