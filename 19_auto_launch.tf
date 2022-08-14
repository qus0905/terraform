resource "aws_launch_configuration" "web_launch_conf" {
  name = "web-launch_conf"
  image_id = aws_ami_from_instance.web_ami.id
  instance_type = "t2.micro"
  iam_instance_profile = "admin_role"
  security_groups = [aws_security_group.web-sg.id]
  key_name = "jybyun"
  user_data = <<-EOF
                #! /bin/bash
                sudo su -
                yum -y update

                yum install -y httpd
                systemctl start httpd
                systemctl enable httpd

                cd~
                yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
                yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
                sed -i '35d' /etc/yum.repos.d/mysql-community.repo 
                sed -i '35i gpgcheck=0' /etc/yum.repos.d/mysql-community.repo 
                yum install -y mysql-community-client

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

depends_on = [
  aws_ami_from_instance.web_ami
]
}

resource "aws_launch_configuration" "was_launch_conf" {
  name = "was-launch-conf"
  image_id = aws_ami_from_instance.was_ami.id
  instance_type = "t2.micro"
  iam_instance_profile = "admin_role"
  security_groups = [aws_security_group.was-sg.id]
  key_name = "jybyun"
  user_data= file("./tomcat.sh")

  depends_on = [
    aws_ami_from_instance.was_ami
  ]
}