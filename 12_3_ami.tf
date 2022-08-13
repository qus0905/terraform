resource "aws_ami_from_instance" "web_ami" {
  name = "web_ami"
  source_instance_id = aws_instance.web-a.id
  
  depends_on = [
    aws_instance.web-a
  ]

  tags = {
    "Name" = "web-ami"
  }
}

resource "aws_ami_from_instance" "was_ami" {
  name= "was_ami"
  source_instance_id = aws_instance.was-a.id
  depends_on = [
    aws_instance.was-a
  ]
  tags = {
    "Name" = "was-ami"
  }
}