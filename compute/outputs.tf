# Web Instance Outputs
output "web_instance_id" {
  description = "ID of the Web instance"
  value       = aws_instance.web.id
}

output "web_instance_private_ip" {
  description = "Private IP of the Web instance"
  value       = aws_instance.web.private_ip
}

# NAT Instance Outputs
output "nat_instance_id" {
  description = "ID of the NAT instance"
  value       = aws_instance.nat_instance.id
}

output "nat_instance_public_ip" {
  description = "Public IP of the NAT instance"
  value       = aws_instance.nat_instance.public_ip
}

# Bastion Host Outputs
output "bastion_instance_id" {
  description = "ID of the Bastion Host instance"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion Host instance"
  value       = aws_instance.bastion.public_ip
}

# IDS Instance Outputs
output "ids_instance_id" {
  description = "ID of the IDS instance"
  value       = aws_instance.ids_instance.id
}

output "ids_instance_private_ip" {
  description = "Private IP of the IDS instance"
  value       = aws_instance.ids_instance.private_ip
}

# IDS Instance Outputs
output "ids_instance_ids" {
  description = "The IDs of the IDS instances"
  value       = aws_instance.ids_instance[*].id
}

output "ids_instance_private_ips" {
  description = "The private IPs of the IDS instances"
  value       = aws_instance.ids_instance[*].private_ip
}
