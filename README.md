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
|key_name|Name of the keypair for SSH access (must exists on the AWS region.|`string`| ""|no|
|name|The name for your the EC2 instance that will be running the RSKj node.|`string`|`"rsk-node"`|no|
| rsk_network | Could be one of `mainnet`, `testnet` or `regtest`. Refere to [RSK Dev portal](https://developers.rsk.co/rsk/node/configure/reference/#blockchainconfigname) for more details | `string` |`n/a` | yes |
|vpc_id|The ID of the VPC in which the nodes will be deployed. Uses default VPC if not supplied.|`string`|`null`|no|

## Outputs
| Name | Description |
|------|-------------|
| public_ip | The public IP address of the instance |

## Usage examples
* [Adding SSH access to the EC2 instance](./Examples/Adding_SSH_access_to_the_EC2_instance/README.md)
* [Provision, deploy, configure and spin up an RSKj node](./Examples/Provision_deploy_and_configure/README.md) 
