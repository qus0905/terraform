resource "aws_instance" "web-a" {
  ami= "ami-0e1d09d8b7c751816"
  instance_type = "t2.micro"
  key_name = "jybyun"
  vpc_security_group_ids = [aws_security_group.pro_sec.id]
  availability_zone = "ap-northeast-2a"
  subnet_id = aws_subnet.weba.id
  private_ip = "12.0.0.10"
  associate_public_ip_address = true
  user_data =file("apache_a.sh")
  
  tags = {
    "Name" = "tf_web_a"
  }
}

output "public_ip_a" {
  value = aws_instance.web-a.public_ip
}


resource "aws_instance" "web-c" {
 ami= "ami-0e1d09d8b7c751816"
  instance_type = "t2.micro"
  key_name = "jybyun"
  vpc_security_group_ids = [aws_security_group.pro_sec.id]
  availability_zone = "ap-northeast-2c"
  subnet_id = aws_subnet.webc.id
  private_ip = "12.0.1.10"
  associate_public_ip_address = true
  user_data =file("apache_c.sh")
  
  tags = {
    "Name" = "tf_web_c"
  }
}

output "public_ip_c" {
    value = aws_instance.web-c.public_ip
  
}
