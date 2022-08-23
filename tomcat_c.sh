#! /bin/bash
sudo su -
cat > /root/tomcat.sh << EOF
cd ~
yum -y update 
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz 
tar xvzf apache-tomcat-9.0.65.tar.gz 

yum install -y java-11-amazon-corretto.x86_64

sed -i '76a JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto.x86_64' /etc/profile
sed -i '77a CATALINA_HOME=/root/apache-tomcat-9.0.65' /etc/profile 
sed -i '78a CLASSPATH=$JAVA_HOME/jre/lib:$JAVA_HOME/lib/tools.jar:$CATALINA_HOME/lib-jsp-api.jar:$CATALINA_HOME/lib/servlet-api.jar' /etc/profile 
sed -i '79a PATH=$PATH:$JAVA_HOME/bin:/bin:/sbin' /etc/profile 
sed -i '80a export JAVA_HOME PATH CLASSPATH CATALINA_HOME' /etc/profile 

source /etc/profile 

cd /root/apache-tomcat-9.0.65/bin 
./startup.sh

cd ~

wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.30.tar.gz
tar xvfz mysql-connector-java-8.0.30.tar.gz
cd mysql-connector-java-8.0.30/
\cp -f mysql-connector-java-8.0.30.jar /usr/lib/jvm/jre/lib/ext/
\cp -f mysql-connector-java-8.0.30.jar /root/apache-tomcat-9.0.65/lib/

sed -i '30a <Resource name="jdbc/db"'  /root/apache-tomcat-9.0.65/conf/context.xml
sed -i '31a auth="Container"'  /root/apache-tomcat-9.0.65/conf/context.xml
sed -i '32a type="javax.sql.DataSource"' /root/apache-tomcat-9.0.65/conf/context.xml
sed -i '33a username="admin"'  /root/apache-tomcat-9.0.65/conf/context.xml
sed -i '34a password="It12345!"'  /root/apache-tomcat-9.0.65/conf/context.xml
sed -i '35a driverClassName="com.mysql.jdbc.Driver"'  /root/apache-tomcat-9.0.65/conf/context.xml
sed -i '36a url="jdbc:mysql://tf-db.chuu6jshlzzt.ap-northeast-2.rds.amazonaws.com:3306/BBS"'  /root/apache-tomcat-9.0.65/conf/context.xml
sed -i '37a maxActive="15"'  /root/apache-tomcat-9.0.65/conf/context.xml
sed -i '38a maxIdle="3"/>'  /root/apache-tomcat-9.0.65/conf/context.xml

sed -i '4737i  <resource-ref>'  /root/apache-tomcat-9.0.65/conf/web.xml
sed -i '4738i  <res-ref-name>jdbc/db</res-ref-name>'  /root/apache-tomcat-9.0.65/conf/web.xml
sed -i '4739i  <res-type>javax.sql.DataSource</res-type>'  /root/apache-tomcat-9.0.65/conf/web.xml
sed -i '4740i  <res-auth>Container</res-auth>'  /root/apache-tomcat-9.0.65/conf/web.xml
sed -i '4741i  </resource-ref>'  /root/apache-tomcat-9.0.65/conf/web.xml

EOF

sh /root/tomcat.sh

cd /root/apache-tomcat-9.0.65/bin 
./shutdown.sh 
./startup.sh 

cd /root/apache-tomcat-9.0.65/webapps/ROOT/

mv index.jsp index.jspp

cat > index.jsp << EOF
<%@ page import = "java.sql.*" %>
<%
try{
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://tf-db.chuu6jshlzzt.ap-northeast-2.rds.amazonaws.com:3306/BBS";
Connection conn = DriverManager.getConnection(url, "admin", "It12345!");
out.print("Success from c");
}
 catch(Exception e){
out.print(e.toString());
} 
%> 
EOF

cat > index.html << EOF
<html>
<body>
<h1> jybyun's Terraform Server-c for health-check</h1>
</body>
</html> 
EOF

cd /root/apache-tomcat-9.0.65/bin 
./shutdown.sh 
./startup.sh 

