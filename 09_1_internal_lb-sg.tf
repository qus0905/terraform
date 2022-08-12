resource "aws_security_group" "nlb-sg" {
  name = "nlb-sg"
  description = "Allow 22, 80"
  vpc_id = aws_vpc.project_vpc.id

  ingress {
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

  ingress {
    description      = "HTTP"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_groups  = [aws_security_group.web-sg.id]
    prefix_list_ids  = null
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
   "Name" = "internal-lb-SG"
 }
}