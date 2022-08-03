resource "aws_db_subnet_group" "tf_rdsg" {
  name = "tf-rdsg"
  subnet_ids = [aws_subnet.dba.id, aws_subnet.dbc.id]
}