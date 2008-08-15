#!/bin/sh

JAVA_OPTS="-server -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m -Dsakai.demo=true"
export JAVA_OPTS

CATALINA_OPTS="-server -Xmx1024m -XX:MaxNewSize=256m -XX:MaxPermSize=256m -Dsakai.demo=true"
export CATALINA_OPTS

/opt/tomcat-5.5.23/bin/shutdown.sh
