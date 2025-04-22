output "ssh_connection_string" {
  description = "SSH connection string to connect to the instance"
  value       = "ssh -i ${abspath(local_file.private_key.filename)} ec2-user@${module.ec2_instance.public_ip}"
#  sensitive   = true
}