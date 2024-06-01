#FROM tomcat:8
FROM tomcat:10.1.24
LABEL maintainer=”Ashok2931mail@gmail.com”
# Take the war and copy to webapps of tomcat
COPY target/*.war /usr/local/tomcat/webapps/dockerjenkinsdemo.war
