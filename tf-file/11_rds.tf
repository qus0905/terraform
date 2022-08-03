resource "aws_db_instance" "pro_rds" {
  allocated_storage = 50
  max_allocated_storage = 80
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "5.7.21"
  instance_class = "db.t2.micro"
  identifier= "tf-db"
  db_name="BBS"
  username = "admin"
  password = "It12345!"
  availability_zone = "ap-northeast-2a"
  db_subnet_group_name = aws_db_subnet_group.tf_rdsg.id
  vpc_security_group_ids = [aws_security_group.pro_sec.id]
  backup_retention_period = 0
  skip_final_snapshot = true
  apply_immediately=true

  tags={
    "Name"="tf_db"
  }
}