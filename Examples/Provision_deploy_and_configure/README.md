# Provision, install, configure and spin up RSKj node

This example shows the whole process of:
* Provision the infraestructure.
* Install and configure the software.
* Start a MainNet RSKj node.


```bash
$ git clone https://github.com/rsksmart/ansible-role-rsk-node.git
$ terraform init
$ terraform apply
$ ansible-playbook -i inventory -u ubuntu ansible-role-rsk-node/deploy-rsk-node.yml
```
