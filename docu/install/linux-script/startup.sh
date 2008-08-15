#!/bin/bash

source /opt/setenv.sh

if [[ $UID -eq 0 ]]; then
    echo "Please don't start Tomcat as root."
    exit 1
fi

umask 002

OPTS="-Xms2048m"
OPTS="${OPTS} -Xmx2048m"
OPTS="${OPTS} -XX:PermSize=128m"
OPTS="${OPTS} -XX:MaxPermSize=256m"
OPTS="${OPTS} -XX:NewSize=400m"
OPTS="${OPTS} -XX:MaxNewSize=400m"
OPTS="${OPTS} -server"
OPTS="${OPTS} -Djava.net.preferIPv4Stack=true"
OPTS="${OPTS} -Djava.awt.headless=true"
if [ -f "${CATALINA_HOME}/sakai/log4j.properties" ];
then
  OPTS="${OPTS} -Dlog4j.configuration=file:${CATALINA_HOME}/sakai/log4j.properties "
fi
export CATALINA_OPTS="${OPTS}"

USER=tomcat

pid=`ps axo user,pid,command | grep "^${USER}.*catalina.home=${CATALINA_HOME}.*java" | grep -v grep | awk '{print $2}'`

if [ -n "$pid" ]; then
    echo "Tomcat is already running.  Run shutdown.sh to shut it down."
    exit 1
fi

exec ${CATALINA_HOME}/bin/startup.sh