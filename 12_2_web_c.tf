resource "aws_instance" "web-c" {
 ami= "ami-0e1d09d8b7c751816"
  instance_type = "t2.micro"
  key_name = "jybyun"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  availability_zone = "ap-northeast-2c"
  subnet_id = aws_subnet.webc.id
  private_ip = "12.0.3.10"
  user_data = <<-EOF
                #! /bin/bash
                sudo su -
                yum -y update

                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd

                cd~

                    sed -i '362a <VirtualHost *:80>'  /etc/httpd/conf/httpd.conf
                    sed -i '363a ProxyRequests Off '  /etc/httpd/conf/httpd.conf
                    sed -i '364a ProxyPreserveHost On'  /etc/httpd/conf/httpd.conf
                    sed -i '365a <Proxy *>'  /etc/httpd/conf/httpd.conf
                    sed -i '366a Order deny,allow'  /etc/httpd/conf/httpd.conf
                    sed -i '367a Allow from all '  /etc/httpd/conf/httpd.conf
                    sed -i '368a  </Proxy>'  /etc/httpd/conf/httpd.conf
                    sed -i '369a  ProxyPass / http://${aws_lb.pro_internal_lb.dns_name}:8080/ disablereuse=on'  /etc/httpd/conf/httpd.conf
                    sed -i '370a ProxyPassReverse / http://${aws_lb.pro_internal_lb.dns_name}:8080/ '  /etc/httpd/conf/httpd.conf
                    sed -i '371a </VirtualHost>'  /etc/httpd/conf/httpd.conf

                    systemctl restart httpd
                    cat > /var/www/html/index.html << EOF
                    <html>
                        <body>
                        <h1> jybyun's Terraform Server-c for health-check</h1>
                        </body>
                    </html> 
            EOF

  
  tags = {
    "Name" = "tf_web_c"
  }
}

