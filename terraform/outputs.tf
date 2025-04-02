output "frontend_server_address" {
  description = "frontend server url address"
  value       = "http://${aws_instance.frontend_server[0].public_ip}"
  sensitive   = false
}

output "backend_server_address" {
  description = "backend server url address"
  value       = "http://${aws_instance.backend_server[0].public_ip}:3000/api/v1/hello"
  sensitive   = false
}
