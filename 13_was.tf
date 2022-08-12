resource "aws_instance" "was-a" {
  ami= "ami-0e1d09d8b7c751816"
  instance_type = "t2.micro"
  key_name = "jybyun"
  vpc_security_group_ids = [aws_security_group.was-sg.id]
  availability_zone = "ap-northeast-2a"
  subnet_id = aws_subnet.wasa.id
  private_ip = "12.0.2.10"
  user_data=file("tomcat.sh")
  tags = {
    "Name" = "tf_was_a"
  }
  
}

resource "aws_instance" "was-c" {
  ami= "ami-0e1d09d8b7c751816"
  instance_type = "t2.micro"
  key_name = "jybyun"
  vpc_security_group_ids = [aws_security_group.was-sg.id]
  availability_zone = "ap-northeast-2c"
  subnet_id = aws_subnet.wasc.id
  private_ip = "12.0.3.10"
  user_data=file("tomcat_c.sh")
  tags = {
    "Name" = "tf_was_c"
  }
  
}