@echo off
@rem -Dsakai.demo=true  -Dsakai.demo=true

call d:\ADeveloper\setEnvJDK1.5.bat

set JAVA_OPTS=-server -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m
set CATALINA_OPTS=-server -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m

set JAVA_OPTS=%JAVA_OPTS% -Duser.language=zh -Duser.region=CN

set CATALINA_HOME=.\apache-tomcat-5.5.23-2.5
set TOMCAT_HOME=.\apache-tomcat-5.5.23-2.5

.\apache-tomcat-5.5.23-2.5\bin\startup.bat

