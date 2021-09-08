#variable "region" {
#  description = "The AWS region where the RSKj node is gonna run"
#  type        = string
#  default     = "us-east-1"
#}

variable "vpc_id" {
  description = "The ID of the VPC in which the nodes will be deployed. Uses default VPC if not supplied."
  type        = string
  default     = null
}

variable "name" {
  description = "The name for your the EC2 instance that will be running the RSKj node"
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
