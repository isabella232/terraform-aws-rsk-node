variable "public_ssh_key" {
  description = "SSH Public Key to access the RSK node. Used also to deploy the configuration."
  type        = string
  validation {
    condition     = length(var.public_ssh_key) > 0
    error_message = "Please define a public ssh key"
  }
}
