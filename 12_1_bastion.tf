resource "aws_instance" "bastion" {
  ami= "ami-0e1d09d8b7c751816"
  instance_type = "t2.micro"
  key_name = "jybyun"
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  availability_zone = "ap-northeast-2a"
  subnet_id = aws_subnet.public_sub.id
  associate_public_ip_address = true
  user_data = <<-EOF
                #! /bin/bash
                sudo su -
                yum -y update

                cd~
                yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
                yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
                sed -i '35d' /etc/yum.repos.d/mysql-community.repo 
                sed -i '35i gpgcheck=0' /etc/yum.repos.d/mysql-community.repo 
                yum install -y mysql-community-client
            EOF
            
  private_ip = "12.0.0.10"
  tags = {
    "Name" = "bastion"
  }
  
}

output "public_ip_bastion" {
    value = aws_instance.bastion.public_ip
  
}
