resource "aws_instance" "frontend_server" {
  count = var.create_instances ? var.instance_count : 0

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = local.frontend_instance_type
  vpc_security_group_ids = [
    aws_security_group.backend_sg.id,
    aws_security_group.ssh_sg.id
    ]
  subnet_id              = element(data.aws_subnets.default_vpc_subnets.ids, count.index) # create instances in different subnets

  tags = {
    Name        = "${local.frontend_instance_name}-${count.index + 1}"
    Environment = local.frontend_environment
  }

  user_data_base64 = filebase64("${path.module}/config/frontend.sh")

  user_data_replace_on_change = true
}

# Create a Security Group for frontend security group
resource "aws_security_group" "frontend_sg" {
  name        = "frontend_sg"
  description = "Allow frontendapp inbound and all outbound"
  vpc_id      = data.aws_vpc.default_vpc.id

  tags = {
    Name = "frontend_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_frontendapp_rules" {
  security_group_id = aws_security_group.frontend_sg.id

  cidr_ipv4   = local.anywhere
  from_port   = local.frontendapp_port
  ip_protocol = local.tcp_protocol
  to_port     = local.frontendapp_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_frontend" {
  security_group_id = aws_security_group.frontend_sg.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = local.all_protocols_ports # semantically equivalent to all ports
}