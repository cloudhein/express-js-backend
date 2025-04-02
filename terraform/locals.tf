locals {

   frontend_instance_type = var.instance_config.frontend_instance_type
  frontend_instance_name = var.instance_config.frontend_instance_name
  frontend_environment   = var.instance_config.frontend_environment

  backend_instance_type = var.instance_config.backend_instance_type
  backend_instance_name = var.instance_config.backend_instance_name
  backend_environment   = var.instance_config.backend_environment


  anywhere            = "0.0.0.0/0"
  ssh_port            = 22
  all_protocols_ports = "-1"
  tcp_protocol        = "tcp"
  icmp_protocol       = "icmp"

  backendapp_port = 80

  backendapp_port = 3000

}