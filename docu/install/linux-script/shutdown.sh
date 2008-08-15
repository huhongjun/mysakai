#!/bin/bash

source /opt/setenv.sh

USER=tomcat

# time to wait before sending TERM signal
WAIT_BEFORE_TERM=20

# time to wait after TERM before sending KILL signal
WAIT_BEFORE_KILL=10

function getPid {
  echo `ps axo user,pid,command | grep "^${USER}.*catalina.home=${CATALINA_HOME}.*java" | grep -v grep | awk '{print $2}'`
}

function catalinaShutdown {
  ${CATALINA_HOME}/bin/shutdown.sh
  echo -n "waiting for Tomcat to exit normally..."
}

function waitForShutdown {
  for i in `seq 1 ${1}`; do
    if [[ `getPid` -ne 0 ]]; 
    then
      echo -n "."
      sleep 1
    else
      echo ""
      echo "Tomcat shutdown complete."
      exit 0;
    fi
  done
}

function sendKillSignal {
  if [[ `getPid` -ne 0 ]]; 
  then
    echo ""
    echo -n "sending ${1} signal to Tomcat..."
    kill -s ${1} `getPid`
  fi
}

# Check if actually running
if [[ `getPid` -eq 0 ]]; 
then
  echo "Tomcat [${CATALINA_HOME}] not running."
  exit 0;
fi

# Shut it down the "Right" way
catalinaShutdown
waitForShutdown ${WAIT_BEFORE_TERM}

# Try nicely
sendKillSignal "SIGTERM"
waitForShutdown ${WAIT_BEFORE_KILL}

# Kill it
sendKillSignal "SIGKILL"
waitForShutdown 5

# No idea what would cause it to get here...
echo "Tomcat's having trouble shuting down..."