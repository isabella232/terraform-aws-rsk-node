module "rsk-node" {
  source  = "app.terraform.io/juan-rsk-test/rsk-node/aws"
  version = "1.0.5"

  rsk_network = "testnet"

  key_name = aws_key_pair.deployer.key_name

  additional_security_group_ids = [module.ssh_security_group.security_group_id]
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-ed25519 AAAAC3NzaXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX john@example.com"
}

module "ssh_security_group" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name = "Allow SSH access"

  vpc_id = data.aws_vpc.default.id

  ingress_cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
}
