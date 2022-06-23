output "public_ip" {
  description = "The public IP for the EC2 instance where your RSK node run"
  value       = module.ec2_instance.public_ip
}
output "rsk_network" {
  description = "The RSK blockchain network"
  value       = var.rsk_network
}

