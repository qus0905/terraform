resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow HTTP,SSH"
  vpc_id      = aws_vpc.project_vpc.id
   
   ingress{
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  egress = [
    {
      description      = "All Traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null

    }
  ]
  tags = {
    "Name" = "bastion-sg"
  }
}
