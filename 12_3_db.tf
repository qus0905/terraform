resource "aws_instance" "db" {
  ami= "ami-0e1d09d8b7c751816"
  instance_type = "t2.micro"
  key_name = "jybyun"
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  availability_zone = "ap-northeast-2c"
  subnet_id = aws_subnet.dbc.id
  private_ip = "12.0.7.10"
  user_data=file("db.sh")
  tags = {
    "Name" = "db"
  }
  
}