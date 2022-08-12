resource "aws_security_group" "db-sg" {
  name = "db-sg"
  description = "Allow, 22, 3306"
  vpc_id = aws_vpc.project_vpc.id

 ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups = [aws_security_group.web-sg.id]
    prefix_list_ids  = null
    self             = null
    }

  ingress {
    description      = "DB"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    prefix_list_ids  = null
    security_groups  = [aws_security_group.was-sg.id]
    self             = null
    }
     ingress {
    description      = "DB"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["3.0.0.0/24"]
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
   "Name" = "DB-SG"
 }
}