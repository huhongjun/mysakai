@echo off

set JAVA_OPTS=-server -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m
set CATALINA_OPTS=-server -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m

set CATALINA_HOME=D:\vcle\tomcat-5.5.23
set TOMCAT_HOME=D:\vcle\tomcat-5.5.23

call D:\vcle\tomcat-5.5.23\bin\shutdown.bat
