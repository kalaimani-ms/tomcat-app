FROM tomcat:8

COPY target/newapp.war /usr/local/tomcat/webapps/

