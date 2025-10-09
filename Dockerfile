FROM tomcat:8
LABEL app=docker-app
COPY target/*.war /usr/local/tomcat/webapps/myweb.war
