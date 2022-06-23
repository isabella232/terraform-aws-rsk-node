module "rsk-node" {
  source          = "../../../terraform-aws-rsk-node"
  rsk_network     = "testnet"
  public_ssh_key  = "ssh-rsa XXXXXXXXXX"
  allowed_ssh_ips = ["${chomp(data.http.myip.body)}/32"]
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
