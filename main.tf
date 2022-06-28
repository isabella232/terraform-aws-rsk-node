terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.15.1"
    }
  }
}

data "aws_subnet" "selected" {
  id = var.subnet_id
}

locals {
  rsk_network = lower(var.rsk_network)

  rsk_pd_ports_map = {
    mainnet = 5050
    testnet = 50505
    regtest = 50501
  }
  rsk_pd_port = local.rsk_pd_ports_map[local.rsk_network]
}

module "rsk_pd_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "rsk-${local.rsk_network}-peer-discovery"
  description = "Allow world access to RSK ${local.rsk_network} Peer Discovery."
  vpc_id      = data.aws_subnet.selected.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_ipv6_cidr_blocks = ["::/0"]

  ingress_with_cidr_blocks = [
    {
      from_port = local.rsk_pd_port
      to_port   = local.rsk_pd_port
      protocol  = "tcp"
    },
    {
      from_port = local.rsk_pd_port
      to_port   = local.rsk_pd_port
      protocol  = "udp"
    },
  ]
  ingress_with_ipv6_cidr_blocks = [
    {
      from_port = local.rsk_pd_port
      to_port   = local.rsk_pd_port
      protocol  = "tcp"
    },
    {
      from_port = local.rsk_pd_port
      to_port   = local.rsk_pd_port
      protocol  = "udp"
    },
  ]
}

module "allow_outgoing_internet_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name        = "exit-to-Inet-sg"
  description = "Allow outgoing traffic to the Internet."
  vpc_id      = data.aws_subnet.selected.vpc_id

  egress_cidr_blocks      = ["0.0.0.0/0"]
  egress_ipv6_cidr_blocks = ["::/0"]

  egress_with_cidr_blocks = [
    {
      from_port = -1
      to_port   = -1
      protocol  = -1
    },
  ]
  egress_with_ipv6_cidr_blocks = [
    {
      from_port = -1
      to_port   = -1
      protocol  = -1
    },
  ]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.0.0"

  name = var.name

  ami           = var.ami_id
  key_name      = var.key_name
  instance_type = var.instance_type

  ebs_optimized = true

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 200
    }
  ]

  subnet_id = var.subnet_id

  vpc_security_group_ids = concat(
    [
      module.rsk_pd_sg.security_group_id,
      module.allow_outgoing_internet_sg.security_group_id,
    ],
    var.additional_security_group_ids,
  )
}
