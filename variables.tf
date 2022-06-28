variable "subnet_id" {
  description = "The ID of the VPC Subnet in which the nodes will be deployed."
  type        = string
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

variable "additional_security_group_ids" {
  description = "List of security group IDs to associate with."
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "SSH key pair name for RSK server"
  type        = string
  default     = null
}

variable "ami_id" {
  description = "AMI ID to be launched into the EC2 instances."
  type        = string
}
