variable "vpc_id" {
  description = "The ID of the VPC in which the nodes will be deployed. Uses default VPC if not supplied."
  type        = string
  default     = null
}

variable "name" {
  description = "The name for your the EC2 instance that will be running the RSKj node."
  type        = string
  default     = "rsk-node"
}

variable "rsk_network" {
  description = "RSK network name. One of \"mainnet\", \"testnet\" or \"regtest\"."
  type        = string

  validation {
    condition     = anytrue([for network in ["mainnet", "testnet", "regtest"] : lower(var.rsk_network) == network])
    error_message = "Only \"mainnet\", \"testnet\" or \"regtest\" allowed."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3a.large"
}

variable "public_ssh_key" {
  description = "SSH Public Key to access the RSK node. Used also to deploy the configuration."
  type        = string
  validation {
    condition     = length(var.public_ssh_key) > 0
    error_message = "Please define a public ssh key"
  }
}

variable "additional_security_group_ids" {
  description = "List of security group IDs to associate with."
  type        = list(string)
  default     = []
}

variable "allowed_ssh_ips" {
  description = "List of IPs CIDR to whitelist for ssh access to the RSK server."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "allowed_ssh_ip6s" {
  description = "List of IPv6 CIDR to whitelist for ssh access to the RSK server."
  type        = list(string)
  default     = ["::/0"]
}
