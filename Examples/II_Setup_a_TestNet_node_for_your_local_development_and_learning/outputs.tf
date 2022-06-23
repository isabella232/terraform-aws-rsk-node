output "public_ip" {
  description = "The public IP for the EC2 instance where your RSK node run"
  value       = module.rsk-node.public_ip
}
