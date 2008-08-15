

call d:\ADeveloper\setEnvJDK1.5.bat

rem Sakai启动环境变量

set CATALINA_OPTS=-server -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m
set JAVA_OPTS=-server -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m

set CATALINA_HOME=.\apache-tomcat-5.5.23
set TOMCAT_HOME=.\apache-tomcat-5.5.23

.\apache-tomcat-5.5.23\bin\startup.bat