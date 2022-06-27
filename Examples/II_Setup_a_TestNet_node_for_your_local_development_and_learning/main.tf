module "rsk-node" {
  source                        = "../../../terraform-aws-rsk-node"
  rsk_network                   = var.rsk_network
  key_name                      = aws_key_pair.rsk_developer.key_name
  vpc_id                        = data.aws_vpc.default.id
  additional_security_group_ids = [module.rsk_developer_sg.security_group_id]
}

# Retrieve user's IP to whitelist
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

# Use default VPC
data "aws_vpc" "default" {}

# Upload developer provided public key to AWS
resource "aws_key_pair" "rsk_developer" {
  key_name   = "rsk-developer-key"
  public_key = var.public_ssh_key
}

# Grant developer's IP access to ports 22 (ssh) and 4444 (RPC)
module "rsk_developer_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "rsk-developer-ssh-rpc-access"
  description = "Allow ssh and RPC access to RSK Server."
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks      = ["${chomp(data.http.myip.body)}/32"]
  ingress_ipv6_cidr_blocks = ["::1/128"]

  ingress_with_cidr_blocks = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
    },
    {
      from_port = 4444
      to_port   = 4444
      protocol  = "tcp"
    },
  ]

  ingress_with_ipv6_cidr_blocks = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
    },
    {
      from_port = 4444
      to_port   = 4444
      protocol  = "tcp"
    },
  ]
}

# This will create an Ansible inventory file used to deploy RSKj (see README.md)
resource "local_file" "ansible_inventory" {
  content = templatefile(
    "inventory.tpl",
    {
      public_ip   = module.rsk-node.public_ip
      rsk_network = module.rsk-node.rsk_network
    }
  )
  filename = "./inventory"
}
