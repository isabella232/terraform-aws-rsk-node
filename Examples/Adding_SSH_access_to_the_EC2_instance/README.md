# Adding SSH access to the EC2 instance
In this example, you will create the infra for an RSKj TestNet node to work, and then you will access the EC2 instance from where Terraform was applied.
In `main.tf` replace the value for `public_key` with your SSH public key. 

> For example: the content of `~/.ssh/id_ed25519` is a valid value for `public_key`

Then you could provision the infra and access your new instance doing:
```bash
$ terraform init
$ terraform apply
$ RSK_NODE_IP=$(terraform output -raw public_ip)
$ ssh ubuntu@$RSK_NODE_IP
```
