resource "aws_instance" "backend_server" {
  count = var.create_instances ? var.instance_count : 0

  ami           = data.aws_ami.ubuntu.id
  instance_type = local.backend_instance_type
  vpc_security_group_ids = [
    aws_security_group.backend_sg.id,
    aws_security_group.ssh_sg.id
  ]
  subnet_id = element(data.aws_subnets.default_vpc_subnets.ids, count.index) # create instances in different subnets

  tags = {
    Name        = "${local.backend_instance_name}-${count.index + 1}"
    Environment = local.backend_environment
  }

  user_data = templatefile("${path.module}/config/backend.sh.tftpl", {
     run_number = var.run_number
   })

  user_data_replace_on_change = true
}

# Create a Security Group for backend security group
resource "aws_security_group" "backend_sg" {
  name        = "backend_sg"
  description = "Allow backend app inbound and all outbound"
  vpc_id      = data.aws_vpc.default_vpc.id

  tags = {
    Name = "backend_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_backendapp_rules" {
  security_group_id = aws_security_group.backend_sg.id

  cidr_ipv4   = local.anywhere
  from_port   = local.backendapp_port
  ip_protocol = local.tcp_protocol
  to_port     = local.backendapp_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_backend" {
  security_group_id = aws_security_group.backend_sg.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = local.all_protocols_ports # semantically equivalent to all ports
}