
call d:\ADeveloper\setEnvJDK1.5.bat

rem Sakai启动环境变量
set JAVA_OPTS=-server -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m
set CATALINA_OPTS=-server -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m

set JPDA_TRANSPORT=dt_socket
set JPDA_ADDRESS=8000

set CATALINA_HOME=D:\vcle\tomcat-5.5.23
set TOMCAT_HOME=D:\vcle\tomcat-5.5.23

D:\vcle\tomcat-5.5.23\bin\catalina jpda start