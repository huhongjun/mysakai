启动基本指令：
   0、点击contextmenu-cmd-sakai.reg，此后可右键点击进入Dos窗口
   1、进入vcle目录，执行setEnvSakaiMaven1.0.2.bat；
   2、进入sakai-src，执行maven bld dpl；	【benq - (build 12 min + deploy 4 min)】
   3、运行mysql.bat sakai.bat				【benq - 8分钟】
   4、浏览器输入 http://localhost:8080/portal;

关于备份：
   先执行maven cln；
   需要备份的目录：	sakai-src
   
sakai扩展：
	https://source.sakaiproject.org/contrib/
	https://source.edtech.vt.edu/svn/sakai/
	https://svn.oucs.ox.ac.uk/projects/vle/sakai/
********************************************************************************************
2008/4/29
	同步工具、助教管理乱码问题：是在源码中写的中文造成的，关键在于eclipse中编译时代了javac 后面的-encoding选项，maven中编译时没带
	隐藏工具问题：sakai.properties中不能有空格
	birt viewer web应用报找不到驱动的错误：将驱动拷贝到plugin目录下jdbc驱动目录
	birt viewer web应用报字段关联错误：重写sql语句，全部手工加上as 字段名
	
2008/3/9
	mvn clean test   # Test against in-memory hsqldb
	mvn -Dtest.sakai.home=C:/java/sakaisettings/oracle-sakai/ clean test
	mvn -Dtest.sakai.home=C:/java/sakaisettings/mysql-sakai/ clean test

	web services测试
		/sakai-axis/SakaiSite.jws?wsdl

2008/3/7 收集EclipseVCLE的任务与注释
	新增站点类型: 
		http://bugs.sakaiproject.org/confluence/display/ENC/Adding+a+Site+Type
		sakai.sitesetup.xml,ToolOrder.xml
	portal user display
	sakai portal flow=》写文档搞清portal生成流程
	
2008/3/6
	测试=》Sakai 2.4.1 + mysql 5.0 全新系统的安装
		sakai 2.4.1
			Gateway英文
			新用户：我的空间英文
			管理员：我的空间左栏中文，系统管理站点左栏英文
		Melete
			需要手工建一个表 melete_migrate_status
		jforum
			初试崩溃，发现没建表：原因需要mysql支持innoDB，默认的mysql.ini中是屏蔽的(做法：注释掉skipinnodb)
			要用admin登录建站加jforum工局，然后点击manage链接进行系统配置
			只需给maintenance和instructor角色赋jforum_manage权限即可
				具有与admin不通的管理权限，正对本站点的栏目设置
		polls
			为调查问题加选项时出错，在jira上发现是开发者merge了不正确的代码，在2.4.x维护分支中已解决，下载覆盖即可

		补充：
			加载demo数据不成功是因为启动sakai的脚本文件中设置了用户语言和国别。

	测试=》sakai 2.5 + scorm player
		scorm 导入eclipse有不少工作要做
		scorm 界面的中英文情况受浏览器语言设置的影响

2008/3/6
	Agora/SCORMPlayer调通的都是sakai 2.5
	
2008/1/4
	考虑直接修改初始化sql脚本，实现数据库内容的本地化
	
2007/12/31
	keytool -genkey -alias agora -keystore agora.keystore

2007/12/26
	待办：
		整理在Redhat AS 4上配置Sakai开发、发布环境的文档和相应配置文件；
		实践如何维护本地源码分支和生成Patch；
		mysql样例数据导出成为标准sql语句，以后可重用；
		整理一份最新的修改清单；
		实践功能扩展-agora/osp(有模板)；
		
	sakai未解决问题：
		编辑HTML乱码；
		-日程管理=》时间段文字【没有年是英文中本来就没有】
		-创建课程=》"需要站点"改为"创建站点"
			【/sakai/sakai/site-manage/site-manage-tool/tool/src/bundle/sitesetupgeneric_zh_CN.properties】
		课程类型、用户类型还是英文=》course、project、student、
		测验=》模板类别是英文
		最近论坛条目=》标题是英文
		-页脚=》站点bar左右竖线去掉[无所谓]
		个性偏好：页面标题没问题，工具标题是preferenceTool；工具栏按钮【定制Tabs】改为定制标签页
		课程管理=》
			访问控制的文字说明
			首页外观后无冒号
			PageOrder有英文，不用删除
		我的空间中仍是今日信息
		站点设计=》页面=》表：描述（版面设计、特征=》翻译不准确）
		日历：summary
			按×显示下拉列表：按月份显示、按周显示的日程表（没有统一文字）
			选项=》低优先级为英文
			12月，2007【少了"年"字】
		我的空间（JS001）=》×号管理改为帐号管理
		JingBaoChen连oracle提示表或视图不存在（sakai_real开头的表有7个未自动创建）
	记录：
		了解了首页layout如何制定: 1,1 表示1行1列，都是从0开始计数。
		sakai 2.5用css为左边的工具菜单增加图标
	
2007/12/02
	Tomcat 启动出错，有时 maven cln bld dpl就又可以了。

2007/11/30
	sakai-mini 有rwiki Tomcat能行，没有不行？奇怪。
2007/11/28
	发现URL中用localhost和127.0.0.1显示不同的皮肤，且前者有favicon
		清除firefox的cache就没问题了，而且favicon都出来了。
		确定favicon用的是Tomcat/ROOT下的文件。
	mysql日志文件可删去
	发现PageOrder有英文，未解决，删去此模块。
2007/11/27
	整理两个gmail上的备份资料和scrabook上收集的资料，整合到VCLE和edlt；
	整理VCLE中的文档文件。

2007/10/16  
	系统登录用户：administrator
	相关目录：
		D:\VCLE
		D:\var
		D:\ADeveloper\Java\jdk1.5.0
		D:\ADeveloper\maven-1.0.2
		D:\ADeveloper\Tomcat-5.5.23
		D:\ADeveloper\Tomcat-5.5.23\sakai

		C:\Documents and Settings\Administrator\build.properties
		C:\Documents and Settings\Administrator\.maven

2007/10/12 这里的内容来自IBM-edlt电脑，今天又做了一番整理。