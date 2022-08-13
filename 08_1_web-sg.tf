resource "aws_security_group" "elb-sg" {
  name = "elb-sg"
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
    from_port        = 80
    to_port          = 80
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
   "Name" = "external-lb-SG"
 }
}

resource "aws_security_group" "web-sg" {
  name = "web-sg"
  description = "Allow, 22, HTTP"
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
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    prefix_list_ids  = null
    security_groups  = [aws_security_group.elb-sg.id]
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

  depends_on = [
    aws_security_group.elb-sg
  ]

 tags = {
   "Name" = "WEB-SG"
 }
}