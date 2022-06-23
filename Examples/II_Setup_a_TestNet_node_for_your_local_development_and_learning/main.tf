module "rsk-node" {
  source                        = "../../../terraform-aws-rsk-node"
  rsk_network                   = "testnet"
  public_ssh_key                = "ssh-rsa XXXXXXXXXX"
  allowed_ssh_ips               = ["${chomp(data.http.myip.body)}/32"]
  additional_security_group_ids = [module.rsk_ssh_sg.security_group_id]
  key_name                      = aws_key_pair.rsk_deployer.key_name
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

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

resource "aws_key_pair" "rsk_deployer" {
  key_name   = "rsk-deployer-key"
  public_key = var.public_ssh_key
}

module "rsk_ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "rsk-node-ssh-access"
  description = "Allow ssh access to RSK Server."
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks      = var.allowed_ssh_ips
  ingress_ipv6_cidr_blocks = var.allowed_ssh_ip6s

  ingress_with_cidr_blocks = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
    },
  ]
  ingress_with_ipv6_cidr_blocks = [
    {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
    },
  ]
}
