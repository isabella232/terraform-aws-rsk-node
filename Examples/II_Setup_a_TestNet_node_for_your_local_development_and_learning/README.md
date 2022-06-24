# Setup a TestNet for your local development and learning
In this example, you will create the infra for an RSKj TestNet node to work; Your current public IP will be whitelisted and you'll be able to access the EC2 instance throuth SSH and to make JSON-RPC calls to the node.

## Create the Infrastructure using Terraform
In `terraform.tfvars` fill the value for `ssh_public_key` with your SSH public key. For example: the content of `~/.ssh/id_ed25519` is a valid value for `public_key`. If you don't do this step, you will be asked for your key when you try to apply.

```bash
$ terraform init
$ terraform apply
```

## Access your EC2 Instance
To access your newly provision server via SSH do

```bash
$ RSK_NODE_IP=$(terraform output -raw public_ip)
$ ssh ubuntu@$RSK_NODE_IP
```

## Setup RSKj server
To install and setup the RSKJ node use any of the following:

### Ansible Instalation
For this you can use RSK provided ansible playbook

```bash
$ git clone https://github.com/rsksmart/ansible-role-rsk-node.git
$ ansible-playbook -i inventory -u ubuntu ansible-role-rsk-node/deploy-rsk-node.yml
```

### Ubuntu PPA installation
Follow the [documentation](https://developers.rsk.co/rsk/node/install/ubuntu/) to install the node using Ubuntu's PPA

### Manual installation
Clone the [repo](https://github.com/rsksmart/rskj) and perform a manual install.

## Testing the node
For example, if you want to know the height of the blockchain you could run

```bash
$ curl  -X POST -H "Content-Type: application/json" --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id} http://$RSK_NODE_IP:4444
```
> You could check other methods in the official [documentation](https://developers.rsk.co/rsk/node/architecture/json-rpc/)
