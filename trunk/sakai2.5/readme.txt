contrib project
	mneme
	sitestats
	sakai-wicket
	scorm

定制编译集合 - huhj
	- blog，osp，podcasts，presentation，samples
	+ scorm，mneme，sitestats，jforum
		
Maven 配置（顶层目录下的pom.xml）	
    <profile>
      <id>huhj</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <modules>
        <module>master</module>
        <module>access</module>
        <module>alias</module>
        <module>announcement</module>
        <module>archive</module>
        <module>assignment</module>
        <module>authz</module>
        <module>calendar</module>
        <module>chat</module>
        <module>citations</module>
        <module>cluster</module>
        <module>component</module>
        <module>content</module>
        <module>content-review</module>
        <module>courier</module>
        <module>course-management</module>
        <module>dav</module>
        <module>db</module>
        <module>email</module>
        <module>entity</module>
        <module>entitybroker</module>
        <module>event</module>
        <module>gradebook</module>
        <module>help</module>
        <module>jobscheduler</module>
        <module>jcr</module>        
        <module>jsf</module>
        <module>login</module>
        <module>mailarchive</module>
        <module>memory</module>
        <module>message</module>
        <module>metaobj</module>
        <module>msgcntr</module>
        <module>portal</module>
        <module>presence</module>
        <module>privacy</module>
        <module>profile</module>
        <module>providers</module>
        <module>reference</module>
        <module>rights</module>
        <module>roster</module>
        <module>rwiki</module>
        <module>sam</module>
        <module>search</module>
        <module>site</module>
        <module>site-manage</module>
        <module>syllabus</module>
        <module>test-harness</module>
        <module>textarea</module>
        <module>tool</module>
        <module>user</module>
        <module>util</module>
        <module>velocity</module>
        <module>web</module>
        <module>webservices</module>
        <module>mailtool</module>
        <module>polls</module>
        <module>usermembership</module>
        <module>sakai-mock</module>
	<module>reset-pass</module>

        <module>sakai-wicket</module>
	<module>scorm</module>
        
      </modules>
    </profile>