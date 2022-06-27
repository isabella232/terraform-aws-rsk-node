variable "public_ssh_key" {
  description = "SSH Public Key to access the RSK node. Used also to deploy the configuration."
  type        = string
  validation {
    condition     = length(var.public_ssh_key) > 0
    error_message = "Please define a public ssh key"
  }
}

variable "rsk_network" {
  description = "RSK network name. One of \"mainnet\", \"testnet\" or \"regtest\"."
  type        = string

  validation {
    condition     = anytrue([for network in ["mainnet", "testnet", "regtest"] : lower(var.rsk_network) == network])
    error_message = "Only \"mainnet\", \"testnet\" or \"regtest\" allowed."
  }
}
