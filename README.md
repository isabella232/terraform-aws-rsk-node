# Provisioning the infrastructure to run an RSKj node using Terraform module

## Summary
Terraform [module](https://www.terraform.io/docs/language/modules/index.html) which provision the necessary infraestructure to run a RSK node on an EC2 AWS instance.

The most important things that this module will create are: an EC2 instance (using a default type `t3a.large`) and two Security Groups attached to the instance, one to allow world access to RSK Peer Discovery and other to let the instance connect to the world (this is needed to install the RSKj implementation).

> Using this module will only give you the infraestructure needed to deploy the RSKj node. Then you could do the deploy using this Ansible [role](https://github.com/rsksmart/ansible-role-rsk-node). Here you have an [example](./Examples/Provision_deploy_and_configure/README.md) of the complete procedure.

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|additional_security_group_ids|List of security group IDs to associate with|`list`|`[]`|no|
|instance_type|EC2 instance type|`string`|`"t3a.large"`|no|
|public_ssh_key|SSH Public Key to access the RSK node. Used also to deploy the configuration.|`string`| ""|yes|
|name|The name for your the EC2 instance that will be running the RSKj node.|`string`|`"rsk-node"`|no|
| rsk_network | Could be one of `mainnet`, `testnet` or `regtest`. Refere to [RSK Dev portal](https://developers.rsk.co/rsk/node/configure/reference/#blockchainconfigname) for more details | `string` |`n/a` | yes |
|vpc_id|The ID of the VPC in which the nodes will be deployed. Uses default VPC if not supplied.|`string`|`null`|no|
|allowed_ssh_ips|List of IPs CIDR to whitelist for ssh access to the RSK server.|`list`|`[0.0.0.0/0]`|no|
|allowed_ssh_ip6s|List of IPv6 CIDR to whitelist for ssh access to the RSK server.|`list`|`[::/0]`|no|

## Outputs
| Name | Description |
|------|-------------|
| public_ip | The public IP address of the instance |
| rsk_network | The RSK blockchain network |


## Usage example
* [Provision, deploy, configure and spin up an RSKj node](./Examples/Provision_deploy_and_configure/README.md) 
