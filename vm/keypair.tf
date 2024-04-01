#Creation of keypair and saving locally

resource "tls_private_key" "ed" {
  algorithm = "ED25519"
  #rsa_bits = 1024
}

resource "aws_key_pair" "dev" {
  key_name = "dev-key"
  public_key = tls_private_key.ed.public_key_openssh
}

resource "local_file" "lf" {
  content = tls_private_key.ed.private_key_pem
  filename = "dev-key"
}
