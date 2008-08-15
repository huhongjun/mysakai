maven 好像只认user.home下的build.properties


mvn -o -Psakai -Dmaven.test.skip=true clean install sakai:deploy -Dmaven.tomcat.home=D:\ASakai\apache-tomcat-5.5.23-2.5

mvn -Psakai -Dmaven.test.skip=true clean install sakai:deploy -Dmaven.tomcat.home=D:\ASakai\apache-tomcat-5.5.23-2.5

mvn sakai:deploy -Dmaven.tomcat.home=D:\ASakai\apache-tomcat-5.5.23-2.5