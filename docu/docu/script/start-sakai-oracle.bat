

call d:\ADeveloper\setEnvJDK1.5.bat

rem Sakai启动环境变量

set CATALINA_OPTS=-server -Xms256m -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m
set JAVA_OPTS=-server -Xms256m -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m

rem Define default language locale: Japanese / Japan
set JAVA_OPTS=%JAVA_OPTS% -Duser.language=zh -Duser.region=CN

set CATALINA_HOME=.\apache-tomcat-5.5.23
set TOMCAT_HOME=.\apache-tomcat-5.5.23

set JAVA_OPTS=%JAVA_OPTS% -Dsakai.home=%CATALINA_HOME%\sakai-oracle

.\apache-tomcat-5.5.23\bin\startup.bat