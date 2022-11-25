From tomcat:8.5.72-jdk17-openjdk-buster
add https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war /usr/local/tomcat/webapps
expose 8080
cmd ["catalina.sh", "run"]
