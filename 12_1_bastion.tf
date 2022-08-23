resource "aws_instance" "bastion" {
  ami= "ami-0e1d09d8b7c751816"
  instance_type = "t2.micro"
  key_name = "jybyun"
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  availability_zone = "ap-northeast-2a"
  subnet_id = aws_subnet.public_sub.id
  associate_public_ip_address = true

  private_ip = "12.0.0.10"
  tags = {
    "Name" = "bastion"
  }
  
}

output "public_ip_bastion" {
    value = aws_instance.bastion.public_ip
  
}
