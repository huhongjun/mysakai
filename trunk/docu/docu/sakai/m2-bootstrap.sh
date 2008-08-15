#!/bin/sh

# To run this type 
# cd ~/dev
# bash svn-bootstrap.sh

# Pick your Sakai Tag  and checkout type

# Head Check out
SVNPATH=sakai/trunk
DIRECTORY=sakai

# set Tomcats ports and version
TC_PORT=8080
TC_SHUT=8005
TC_JK=8009
TOMCAT=5.5.23

# set the Maven Version
MAVEN_VERSION=2.0.7
DESIRED_MAVEN_OPTS="-Xms256m -Xmx512m -XX:PermSize=64m -XX:MaxPermSize=128m"

# desired JAVA Opts
DESIRED_JAVA_OPTS="-server -Xmx768m -Xms512m -XX:PermSize=96m -XX:MaxPermSize=160m -XX:NewSize=192m -XX:+UseConcMarkSweepGC -XX:+UseParNewGC"

# MySql Connector Version to use
CONNECTOR=mysql-connector-java-3.1.12.jar

echo Sakai Bootstrap Script 
echo
echo To override parameters, add them to the bootstrap command 
echo 
echo $0 SVNPATH DIRECTORY TC_HTTP_PORT TC_SHUTDOWN_PORT TC_JK_PORT TOMCAT_VERSION
echo 
echo 'For example (these are the default parameters):'
echo
echo sh $0 $SVNPATH $DIRECTORY $TC_PORT $TC_SHUT $TC_JK $TOMCAT
echo 
echo To setup with MySql, you must specify the first six parameters and add the 
echo string "mysql" and five more parameters
echo
echo $0 SVNPATH DIRECTORY TC_HTTP_PORT TC_SHUTDOWN_PORT TC_JK_PORT TOMCAT_VERSION mysql ROOTUSER ROOTPW DATABASENAME SAKAIUSER SAKAIPW
echo 
echo If the root user has no password you can put "none" in for the root password
echo

# check parameterers
if [ $# -ge  1 ] ; 
then 
   SVNPATH=$1
fi

if [ $# -ge  2 ] ; 
then
  DIRECTORY=$2
fi

if [ $# -ge  3 ] ; 
then
  TC_PORT=$3
fi

if [ $# -ge  4 ] ; 
then
  TC_SHUT=$4
fi

if [ $# -ge  5 ] ; 
then
  TC_JK=$5
fi

if [ $# -ge  6 ] ; 
then
  TOMCAT=$6
fi

# Check for MySql version - Making sure mysql is installed and available

if [ $# -eq 12 -a "$7" = "mysql" ] ;
then
  if [ -f /"`which mysql`" ] ;
  then
    echo MySql setup enabled for this run
  else
    echo Cannot find the mysql command using the which command
    echo which mysql
    which mysql
    exit 1
  fi
else
  if [ $# -ge 7 ] ;
  then
    echo 
    echo MySQL version of command line requires 12 parameters.
    echo
    exit 1
  fi
fi

MYPATH=`pwd`

echo Sakai Checkout Type: $SVNPATH Directory: $DIRECTORY
echo Working Directory: $MYPATH
echo Port:$TC_PORT  Shutdown port:$TC_SHUT JK port: $TC_JK TOMCAT Version:$TOMCAT 

# Check Pre-requisites before going further
java -version 
if [ $? -ne 0 ] ;
then
   echo This script requires a running Java 1.5 as a pre-requisite
   echo Script stopped.
   exit
else
   echo Java Detected
fi

svnVersion=`svn --version`
if [ $? -ne 0 ] ;
then
   echo This script requires a running svn as a pre-requisite
   echo See http://subversion.tigris.org/ for installation instructions
   echo Script stopped.
   exit
else
   # trim to just the version
   svnVersion=`svn --version | head -1`
   echo SVN Version Detected: $svnVersion
fi


################ Make function(s)

function warning_error {
  echo =================================================
  echo $*
  echo =================================================
}

function fatal_error {
  warning_error $*
  exit 1
}

# Sample
#
# download apache-tomcat-compat-$TOMCAT.zip tomcat/zips
# 
# if the second parameter is not a url, this uses Sakai's
# ibiblio mirror
#

function download  {
  local GOBACK=`pwd`
  cd $MYPATH

  if [ -d keepzips ] ; 
  then
    echo keepzips directory exists...
  else
    echo Creating keepzips directory ...
    mkdir keepzips
  fi

  if [ -f keepzips/$1 ] ; 
  then
    fileSize=`wc -c < keepzips/$1`
    if [ $fileSize -lt 10000 ] ;
    then
	echo keepzips/$1 is less than 10K - re-downloading...
    else
      echo keepzips/$1 $fileSize bytes
      cd $GOBACK
      return
    fi
  fi

    echo Downloading keepzips/$1 ...
    cd keepzips

    local urlPath=$2
    local isHttp=${2:0:4}

    if [ "$isHttp" = "http" ] ;
    then
      echo Downloading $urlPath/$1
    else
      urlPath="http://source.sakaiproject.org/mirrors/ibiblio/maven/$2"
      echo Downloading $urlPath/$1
    fi
    curl -O $urlPath/$1

  cd $GOBACK
}

############### End of function(s)

# Insure we have Maven 2 > $MAVEN_VERSION
function installMaven {

  # first, make sure Maven 2 options are properly set
  mvnOptsWarn=0
  if [[ "$MAVEN_OPTS" = "" ]] ;
  then
    echo Setting '$MAVEN_OPS'=$DESIRED_MAVEN_OPTS
    MAVEN_OPTS=$DESIRED_MAVEN_OPTS
    export MAVEN_OPTS
    mvnOptsWarn=1
  else
    if [[ "$MAVEN_OPTS" = "$DESIRED_MAVEN_OPTS" ]] ;
    then
      echo MAVEN_OPTS Set properly
    else
      echo Your '$MAVEN_OPTS' may not be set properly
      echo "Your setting: " $MAVEN_OPTS
      echo "Recommended:  " $DESIRED_MAVEN_OPTS
    fi
  fi

  mvnCmd="mvn"
  mvnWarning=0
  mvnVersion=`$mvnCmd -version`
  if [ $? -ne 0 ] ;
  then
    echo "Maven 2 not installed..."
    mvnVersion="Maven version: 0.0.0"
  else
    # trim to just the version
    mvnVersion=`$mvnCmd -version | head -1`
    echo "Current Maven Version " $mvnVersion
  fi
  if [[ "$mvnVersion" > "Maven version: $MAVEN_VERSION" ]] ;
  then
    echo "Maven version above $MAVEN_VERSION detected: " $mvnVersion
    cd $GOBACK
    return
  fi
  
  # record the fact that we do not have mvn in the path
  mvnWarning=1
  if [ -f maven-$MAVEN_VERSION/bin/mvn ] ;
  then
    echo Maven $MAVEN_VERSION already installed but not in path...
  else
    echo "Downloading Maven $MAVEN_VERSION"
    download maven-$MAVEN_VERSION-bin.tar.gz http://mirrors.ibiblio.org/pub/mirrors/apache/maven/binaries/
    if [ -f keepzips/maven-$MAVEN_VERSION-bin.tar.gz ] ;
    then
      echo "Extracting maven ..."
      tar xfvz keepzips/maven-$MAVEN_VERSION-bin.tar.gz
      if [ -f maven-$MAVEN_VERSION/bin/mvn ] ;
      then
        echo Maven $MAVEN_VERSION extracted.
      else
        echo Unable to install Maven $MAVEN_VERSION - compile will probably fail...
        mvnCmd=mvn
        cd $GOBACK
        return
      fi
    fi
  fi

  mvnCmd=$MYPATH/maven-$MAVEN_VERSION/bin/mvn
  mvnVersion=`$mvnCmd -version`
  if [ $? -ne 0 ] ;
  then
    warning_error Failed executing $mvnCmd - compile will likely fail
    mvnCmd=mvn
  else
    # trim to just the version
    mvnVersion=`$mvnCmd -version | head -1`
  fi
  if [[ "$mvnVersion" < "Maven version: $MAVEN_VERSION" ]] ;
  then
    warning_error Version needs to be $MAVEN_VERSION or higher - compile may fail
  fi
  echo Maven command: $mvnCmd
  echo Returns Version: $mvnVersion
  cd $GOBACK
}

# Issue any maven warnings
function warnMaven {
  if [ $mvnWarning -eq 1 ] ;
  then
    echo
    if [ -f $mvnCmd ] ;
    then
      echo Maven 2 has been installed and will be used for this script but you should add
      echo $MYPATH/maven-$MAVEN_VERSION/bin to your path so that you can run mvn directly
    else
      echo You need to install Maven 2 $MAVEN_VERSION or above and add it to your path
    fi
    echo
  fi
  
  if [ $mvnOptsWarn -eq 1 ] ;
  then
    echo
    echo You do not have your '$MAVEN_OPTS' properly set, please add a line like this
    echo
    echo "MAVEN_OPTS=$DESIRED_MAVEN_OPTS ; export MAVEN_OPTS"
    echo
    echo To your login script or your maven compiles will run out of memory
    echo
  fi
}

# Check out the SVN and see if we get it
echo Renaming $DIRECTORY to old-$DIRECTORY
rm -rf old-$DIRECTORY
mv $DIRECTORY old-$DIRECTORY

svn co https://source.sakaiproject.org/svn/$SVNPATH $DIRECTORY

if [ -d $DIRECTORY/master -a -d $DIRECTORY/memory -a -d $DIRECTORY/velocity -a -d $DIRECTORY/util -a -d $DIRECTORY/component ] ; 
then
  echo Checkout completed.
else
  if [ -d old-$DIRECTORY ] ;
  then
    echo Previous $DIRECTORY contents saved at old-$DIRECTORY
  fi
  fatal_error failed Check out of SVN directory - build aborted
fi

# An example hack is removing a directory or two if something breaks the build 
# or if you want to pull in a contrib bit here.
# PLACE POST-CHECK OUT HACKS HERE 

# END OF HACKS

# Download Tomcat and the Compatibility Library
# download apache-tomcat-compat-$TOMCAT.zip tomcat/zips
download apache-tomcat-$TOMCAT.zip tomcat/zips

# Produce a new and clean Tomcat - the hard way if necessary
# The ps command would be different on LinuX

echo "Killing any tomcat running at " "`pwd`/apache-tomcat-$TOMCAT" 
ps -auxww | grep java | grep -v grep |  grep "`pwd`/apache-tomcat-$TOMCAT" | awk '{print "kill -9 " $2}' | csh -vx

rm -rf apache-tomcat-$TOMCAT/

echo Extracting Tomcat...
unzip -q keepzips/apache-tomcat-$TOMCAT.zip
echo NOT Extracting Tomcat JDK 1.5 Compatibility patch

chmod +x apache-tomcat-$TOMCAT/bin/*.sh

cd  apache-tomcat-$TOMCAT/conf
cp server.xml server.sav
cat server.sav | sed s/8080/$TC_PORT/ | sed s/8005/$TC_SHUT/ | sed s/8009/$TC_JK/> server.xml
diff server.sav server.xml
cd ../..

# Switch to the demo configuration - mostly to make HSQL DB store in a file

echo Switching to the demo configuration
mkdir apache-tomcat-$TOMCAT/sakai
echo cp $DIRECTORY/reference/demo/ apache-tomcat-$TOMCAT/sakai

cp $DIRECTORY/reference/demo/* apache-tomcat-$TOMCAT/sakai

echo "Clearing Maven 2 repository"
/bin/rm -rf ~/.m2/repository/org/sakaiproject

# download and install maven for the user if they do not have
# it set up yet
installMaven

# Actual Build
cd $MYPATH
cd $DIRECTORY

echo running Maven: $mvnCmd
$mvnCmd -Dmaven.test.skip=true -Dmaven.tomcat.home=$MYPATH/apache-tomcat-$TOMCAT/ clean install sakai:deploy
if [ $? -ne 0 ] ;
then
  warnMaven
  fatal_error Maven build of Sakai failed
fi

cd $MYPATH

####################### Function to set up MySQL - Called after the function

function patchMySQL {

# Create fresh a sakai user and sakai password and then make an 
# empty mysql database for Sakai to operate in
# Patch tomcat after installation to be a mysql system

if [ $# == 5 ] ;
then
 echo Provisioning MySql in Directory `pwd`
 echo Root account=$1/++++++
 echo Database $3
 echo Sakai account=$4/++++++++
 echo
else
  echo
  echo Patching MySQL requires five parameters
  echo
  echo rootuser rootpw databasename sakaiuser sakaipw
  echo
  echo rootpw can be "none" if the root user has no password
  echo
  echo This is common in dev environments before the mysqladmin has been run to set a root password
  exit 1
fi

host_name=`hostname`
echo Host $host_name

# Process the password - "none" means no password
passval=""
if [ $2 != "none" ];
then
   passval="--password=$2"
fi

echo mysql -u $1 $passval 
mysql -u $1 $passval << EOF-1
drop database $3;
EOF-1

if [ $? -eq 0 ];
then
  echo Existing database dropped...
else
  echo No existing database found.
fi

# Add -v to debug mysql
mysql -u $1 $passval << EOF
create database $3 default character set utf8;
grant all on $3.* to $4@'localhost' identified by '$5';
grant all on $3.* to $4@'127.0.0.1' identified by '$5';
grant all on $3.* to $4@'$host_name' identified by '$5';
EOF

if [ $? -eq 0 ];
then
    echo Grants greated in database $3 for user $4
else
   echo 
   fatal_error Mysql Setup failed - Unable to create grants for $4
fi


echo Test of the newly created account and database
mysql -u $4 --password=$5 << EOF-3
use $3;
show tables;
EOF-3

if [ $? -eq 0 ];
then
   echo Test of account passed.
else
   fatal_error Mysql Setup seems to have failed - account creation test not passed
fi

# Download the MySql Connector
download $CONNECTOR mysql/jars

# Copy the Connector
if [ -f keepzips/$CONNECTOR ];
then
    if cp keepzips/$CONNECTOR apache-tomcat-$TOMCAT/common/lib/
    then 
        echo MySql Connector installed: $CONNECTOR
    else
        fatal_error Mysql Setup failed copying $CONNECTOR
    fi
else
   fatal_error Mysql Setup cannot find $CONNECTOR
fi

echo Altering Sakai Properties to use MySql


PROPS=apache-tomcat-$TOMCAT/sakai/sakai.properties

if [ -f $PROPS ];
then
  echo Patching Properties file $PROPS
else
   fatal_error  Mysql Setup failed - cannot find properties file to patch $PROPS
fi

# Make sure we either save or restore the opriginal in case we run many times

if [ -f $PROPS.pre-mysql ];
then
  if cp $PROPS.pre-mysql $PROPS
  then
    echo We have patched this properties file before - Using original properties to patch.
  else
    fatal_error Mysql Setup cannot restore copy of $PROPS
  fi
else
  if cp $PROPS $PROPS.pre-mysql
  then
    echo Making backup of $PROPS
  else
    fatal_error Mysql Setup cannot backup copy of $PROPS
  fi
fi

cat apache-tomcat-$TOMCAT/sakai/sakai.properties \
        | grep -v 'vendor@org.sakaiproject.db.api.SqlService='\
        | grep -v 'driverClassName@javax.sql.BaseDataSource='\
        | grep -v 'url@javax.sql.BaseDataSource='\
        | grep -v 'username@javax.sql.BaseDataSource='\
        | grep -v 'password@javax.sql.BaseDataSource='\
        | grep -v 'hibernate.dialect=org.hibernate.dialect.MySQLDialect='\
        | grep -v 'validationQuery@javax.sql.BaseDataSource='\
        | grep -v 'defaultTransactionIsolationString@javax.sql.BaseDataSource='\
        | grep -v 'defaultTransactionIsolation'\
        > $PROPS.new

# Append these to the properties

cat << EOF-PROP  >> $PROPS.new

# Properties added by automatic MySQL setup

vendor@org.sakaiproject.db.api.SqlService=mysql
driverClassName@javax.sql.BaseDataSource=com.mysql.jdbc.Driver
url@javax.sql.BaseDataSource=jdbc:mysql://localhost:3306/$3?useUnicode=true&amp;characterEncoding=UTF-8
username@javax.sql.BaseDataSource=$4
password@javax.sql.BaseDataSource=$5
hibernate.dialect=org.hibernate.dialect.MySQLDialect
validationQuery@javax.sql.BaseDataSource=select 1 from DUAL
defaultTransactionIsolationString@javax.sql.BaseDataSource=TRANSACTION_READ_COMMITTED

# End of properties added by automatic MySQL setup

EOF-PROP

if [ $? -eq 0 ];
then
  echo Added new MySql specific properties
else
  fatal_error Mysql Setup Failed appending properties to  $PROPS
fi

/bin/rm -f PROPS.prev
mv $PROPS $PROPS.prev
mv $PROPS.new $PROPS

# debugging
# diff $PROPS.prev $PROPS

echo MySql Setup Complete

}

####################### End Function to set up MySQL

# Check to see if we are supposed to do the MySQL setup

if [ $# -eq 12 -a "$7" == "mysql" ] ;
then
  # Discard the first seven parameters
  shift ; shift ; shift ; shift ; shift ; shift ; shift
  patchMySQL $1 $2 $3 $4 $5
fi

# Set the Java_opts
JAVA_OPTS="$DESIRED_JAVA_OPTS"
export JAVA_OPTS

echo
echo Make sure that your JVM has enough memory - These are some recent recomended settings
echo
echo JAVA_OPTS="$JAVA_OPTS"
echo export JAVA_OPTS
echo 
echo On my Mac I add this line to my .bash_login and forget about it...
echo These settings do change over time.
echo

# emit any Maven warnings if necessary
warnMaven

echo Starting Tomcat ....

cd $MYPATH/apache-tomcat-$TOMCAT/logs
../bin/startup.sh

cd $MYPATH
