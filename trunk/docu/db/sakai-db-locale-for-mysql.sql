/* 执行方式： mysql>source sakai-db-locale.sql */

set names 'GBK';

/* 1. Table: sakai_site, Column: Title,Short_desc,Description */
	
		# Administration Workspace 
		update sakai_site set title='系统管理',description='系统管理员专用站点 !admin' where SITE_ID='!admin';
		
		# Site Unavailable,The site you requested is not available. */
		update sakai_site set title='站点不可用',description='你请求的是不可用的站点' where SITE_ID='!error';
		
		# Gateway，The Gateway Site
		update sakai_site set title='登录',description='学习管理系统入口页面' where SITE_ID='!gateway';
	
		# Invalid URL，The URL you entered is invalid.  SOLUTIONS: Please check for spelling errors or typos.  Make sure you are using the right URL.  Type a URL to try again.
		update sakai_site set title='错误的URL',description='没有找到页面。提示：查看输入的内容是否有误，查看输入的URL是否正确，尝试其他URL类型' where SITE_ID='!urlError';
	
		# My Workspace，My Workspace Site
		update sakai_site set title='我的空间',description='我的空间' where SITE_ID='!user';
	
		# worksite
		update sakai_site set title='空间',description='' where SITE_ID='!worksite';
	
		# mercury site
		update sakai_site set title='mercury 站点',description='mercury 站点' where SITE_ID='mercury';
	
		# Administration Workspace
		update sakai_site set title='我的空间',description='我的空间 - 系统管理员' where SITE_ID='~admin';
	
/* 2. Table: sakai_site_page */

    /**********    sakai_site_page中英文对照列表    **********************************
     
    Home:主页                                *        Job Scheduler：日程安排
    Become User：帐号切换                    *        User Membership：用户查询
    Users：用户管理                          *        Aliases：别名设置
    Sites：站点创建                          *        Realms：权限管理
    Worksite Setup：站点管理                 *        MOTD：今日信息
    Resources：课程资源                        *        On-Line：在线信息
    Memory：内存管理                         *        Site Archive：站点归档
    Site Unavailable：站点不可用             *        Welcome:欢迎
    About：关于                              *        Features：功能搜索
    Training：练习                           *        Acknowledgments：东方创远
    New Account：新用户注册                  *        Invalid URL：错误 url
    Profile：个人信息                        *        Membership：用户查询
    Schedule：日程管理                       *        Announcements：公告浏览
    Preferences：个人偏好                    *        Account：账号管理
    Discussion：论坛                         *        Assignments：作业
    Drop Box：投递箱                         *        Chat：聊天室
    Email Archive：邮件工具
    
    **********************************************************************************/
    
    
    #显示在admin用户管理的administration workspace 站点左侧列表
    
		    # Home
		    update sakai_site_page set title='主页'	where PAGE_ID in('!admin-100');
		    # Job Scheduler
		    	update sakai_site_page set title='定时任务'	where PAGE_ID in('!admin-1000');
				# Become User
				update sakai_site_page set title='帐号切换'	where PAGE_ID in('!admin-1100');  
				# Membership
				update sakai_site_page set title='用户查询'	where PAGE_ID in('!admin-1200');
				# Users
				update sakai_site_page set title='用户管理'	where PAGE_ID in('!admin-200');
		    # Aliases
		    update sakai_site_page set title='别名设置'	where PAGE_ID in('!admin-250');
		    # Sites
		    	update sakai_site_page set title='站点设计'	where PAGE_ID in('!admin-300');
				# Realms
				update sakai_site_page set title='权限管理'	where PAGE_ID in('!admin-350');        
				# Worksite Setup
				update sakai_site_page set title='站点管理'	where PAGE_ID in('!admin-360');
				# MOTD
				update sakai_site_page set title='今日消息'	where PAGE_ID in('!admin-400');
		    # Resources
		    	update sakai_site_page set title='资源仓库'	where PAGE_ID in('!admin-500');
		    # On-Line
		    	update sakai_site_page set title='在线信息'	where PAGE_ID in('!admin-600');
				# Memory
				update sakai_site_page set title='缓存管理'	where PAGE_ID in('!admin-700');        
				# Site Archive
				update sakai_site_page set title='备份恢复'	where PAGE_ID in('!admin-900');
				# Site Unavailable
				update sakai_site_page set title='站点不可用'	where PAGE_ID in('!error-100');
    
		#未登录页面显示左侧列表
		
				#Welcome
				update sakai_site_page set title='欢迎'	where PAGE_ID in('!gateway-100');
				#About
				update sakai_site_page set title='关于'	where PAGE_ID in('!gateway-200');
				#Features
				update sakai_site_page set title='功能简介'	where PAGE_ID in('!gateway-300');
				# Sites
				update sakai_site_page set title='课程搜索'	where PAGE_ID in('!gateway-400');
				#Training
				update sakai_site_page set title='用户培训'	where PAGE_ID in('!gateway-500');
				#Acknowledgments
				update sakai_site_page set title='东方创远'	where PAGE_ID in('!gateway-600');
				#New Account
				update sakai_site_page set title='用户注册'	where PAGE_ID in('!gateway-700');
				#Invalid URL
				update sakai_site_page set title='错误URL'	where PAGE_ID in('!urlError-100');
		
		#普通用户管理my workspace站点左侧列表

				#Home
				update sakai_site_page set title='主页'	where PAGE_ID in('!user-100');
				#Profile
				update sakai_site_page set title='个人信息'	where PAGE_ID in('!user-150');
				#Membership
				update sakai_site_page set title='我的课程'	where PAGE_ID in('!user-200');
				#Schedule
				update sakai_site_page set title='日程管理'	where PAGE_ID in('!user-300');
				#Resources
				update sakai_site_page set title='课程资源'	where PAGE_ID in('!user-400');
				#Announcements
				update sakai_site_page set title='公告浏览'	where PAGE_ID in('!user-450');
				#Worksite Setup
				update sakai_site_page set title='站点管理'	where PAGE_ID in('!user-500');
				#Preferences
				update sakai_site_page set title='个人偏好'	where PAGE_ID in('!user-600');
				#Account
				update sakai_site_page set title='帐号管理'	where PAGE_ID in('!user-700');
		  
		#worksite站点左侧列表

				#Home
				update sakai_site_page set title='主页'	where PAGE_ID in('!worksite-100');
				#Schedule
				update sakai_site_page set title='日程管理'	where PAGE_ID in('!worksite-200');
				#Announcements
				update sakai_site_page set title='公告浏览'	where PAGE_ID in('!worksite-300');
				#Resources
				update sakai_site_page set title='课程资源'	where PAGE_ID in('!worksite-400');
				#Discussion
				update sakai_site_page set title='课程论坛'	where PAGE_ID in('!worksite-500');
				#Assignments
				update sakai_site_page set title='作业管理'	where PAGE_ID in('!worksite-600');
				#Drop Box
				update sakai_site_page set title='投递箱'	where PAGE_ID in('!worksite-700');
				#Chat
				update sakai_site_page set title='聊天室'	where PAGE_ID in('!worksite-800');
				#Email Archive
				update sakai_site_page set title='邮件工具'	where PAGE_ID in('!worksite-900');
			
	  #显示在admin用户管理的mercury 站点左侧列表
			  #Home
				update sakai_site_page set title='主页'	where PAGE_ID in('mercury-100');
				#Schedule
				update sakai_site_page set title='日程管理'	where PAGE_ID in('mercury-200');
				#Announcements
				update sakai_site_page set title='公告浏览'	where PAGE_ID in('mercury-300');
				#Resources
				update sakai_site_page set title='课程资源'	where PAGE_ID in('mercury-400');
				#Discussion
				update sakai_site_page set title='论坛'	where PAGE_ID in('mercury-500');
				#Assignments
				update sakai_site_page set title='作业'	where PAGE_ID in('mercury-600');
				# Drop Box
				update sakai_site_page set title='投递箱'	where PAGE_ID in('mercury-700');
				#Chat
				update sakai_site_page set title='聊天室'	where PAGE_ID in('mercury-800');
				#Email Archive
				update sakai_site_page set title='邮件工具'	where PAGE_ID in('mercury-900');
		
		#显示在admin用户管理的my workspace 站点左侧列表
				#Home
				update sakai_site_page set title='主页'	where PAGE_ID in('~admin-100');
				#Job Scheduler
				update sakai_site_page set title='定时任务'	where PAGE_ID in('~admin-1000');
				#Become User
				update sakai_site_page set title='帐号切换'	where PAGE_ID in('~admin-1100');
				#Membership
				update sakai_site_page set title='用户查询'	where PAGE_ID in('~admin-1200');
				#Users
				update sakai_site_page set title='用户管理'	where PAGE_ID in('~admin-200');
				#Aliases
				update sakai_site_page set title='别名设置'	where PAGE_ID in('~admin-250');
				#Sites
				update sakai_site_page set title='站点设计'	where PAGE_ID in('~admin-300');
				#Realms
				update sakai_site_page set title='权限管理'	where PAGE_ID in('~admin-350');
				#Worksite Setup
				update sakai_site_page set title='站点管理'	where PAGE_ID in('~admin-360');
				#MOTD
				update sakai_site_page set title='今日消息'	where PAGE_ID in('~admin-400');
				#Resources
				update sakai_site_page set title='课程资源'	where PAGE_ID in('~admin-500');
				#On-Line
				update sakai_site_page set title='在线信息'	where PAGE_ID in('~admin-600');
				#Memory
				update sakai_site_page set title='缓存管理'	where PAGE_ID in('~admin-700');
				#Site Archive
				update sakai_site_page set title='备份恢复'	where PAGE_ID in('~admin-900');
    
/* 3. Table: sakai_site_tool */

     /**********    sakai_site_tool中英文对照列表    ********************************
     
     Recent Announcements:最新公告浏览        *         Job Scheduler：日程安排
     Become User：帐号切换                    *         User Membership：用户查询
     Users：用户管理                          *         Aliases：别名设置
     Sites：站点创建                          *         Realms：权限管理
     Worksite Setup：站点管理                 *         MOTD：今日信息
     Resources：课程资源                        *         On-Line：在线信息
     Memory：内存管理                         *         My Workspace Information:我的空间信息
     Site Unavailable：站点不可用             *         Welcome:欢迎
     About：关于                              *         Features：功能搜索
     Training：练习                           *         Acknowledgments：东方创远
     New Account：新用户注册                  *         Invalid URL：错误 url
     Profile：个人信息                        *         Site Archive / Import:站点 存档/导入 
     Schedule：日程管理                       *         Announcements：公告浏览
     Preferences：个人偏好                    *         Account：账号管理
     Discussion：论坛                         *         Assignments：作业
     Drop Box：投递箱                         *         Chat：聊天室
     Email Archive：邮件工具                  *         Recent Discussion Items:近期论坛列表
     Calendar:日历                            *         Message of the Day:今日信息
     Membership:用户查询                      *         Recent Chat Messages:最新聊天信息
    
    ********************************************************************************/
    
    #显示在admin用户管理的administration workspace 站点右侧标题
    #日程安排
    	update sakai_site_tool set title='定时任务' where TOOL_ID in('!admin-1010');
    #MOTD
    	update sakai_site_tool set title='今日消息' where TOOL_ID in('!admin-110');
    #Become User
    	update sakai_site_tool set title='帐号切换' where TOOL_ID in('!admin-1110');
    #My Workspace Information
    	update sakai_site_tool set title='关于我的空间' where TOOL_ID in('!admin-120');
    #User Membership
    update sakai_site_tool set title='用户查询' where TOOL_ID in('!admin-1210');
    #Users
    update sakai_site_tool set title='用户管理' where TOOL_ID in('!admin-210');
    #Aliases
    update sakai_site_tool set title='别名设置' where TOOL_ID in('!admin-260');
    #Sites
    update sakai_site_tool set title='站点设计' where TOOL_ID in('!admin-310');
    #Realms
    update sakai_site_tool set title='权限管理' where TOOL_ID in('!admin-355');
    #Worksite Setup
    update sakai_site_tool set title='站点管理' where TOOL_ID in('!admin-365');
    #MOTD
    update sakai_site_tool set title='今日消息' where TOOL_ID in('!admin-410');
    #Resources
    update sakai_site_tool set title='资源仓库' where TOOL_ID in('!admin-510');
    #On-Line
    update sakai_site_tool set title='在线信息' where TOOL_ID in('!admin-610');
    #Memory
    update sakai_site_tool set title='缓存管理' where TOOL_ID in('!admin-710');
    #Site Archive / Import
    update sakai_site_tool set title='站点的存档/导入' where TOOL_ID in('!admin-910');
    #Site Unavailable
    update sakai_site_tool set title='站点不可用' where TOOL_ID in('!error-110');
    
   #显示在未登录页面右侧标题
    #MOTD
    update sakai_site_tool set title='今日消息' where TOOL_ID in('!gateway-110');
    #Welcome
    update sakai_site_tool set title='欢迎 - 天行在线学习管理系统!' where TOOL_ID in('!gateway-120');
    #About
    update sakai_site_tool set title='关于......' where TOOL_ID in('!gateway-210');
    #Features
    update sakai_site_tool set title='学习管理系统功能简介' where TOOL_ID in('!gateway-310');
    #Sites
    update sakai_site_tool set title='课程搜索' where TOOL_ID in('!gateway-410');
    #Training
    update sakai_site_tool set title='用户培训' where TOOL_ID in('!gateway-510');
    #Acknowledgments
    update sakai_site_tool set title='东方创远' where TOOL_ID in('!gateway-610');
    #New Account
    update sakai_site_tool set title='用户注册' where TOOL_ID in('!gateway-710');
    #Invalid URL
    update sakai_site_tool set title='错误URL' where TOOL_ID in('!urlError-110');
    
    
    #普通用户管理my workspace站点右侧标题
    #MOTD
    update sakai_site_tool set title='今日消息' where TOOL_ID in('!user-110');
    #My Workspace Information
    update sakai_site_tool set title='关于我的空间' where TOOL_ID in('!user-120');
    #Calendar
    update sakai_site_tool set title='日历' where TOOL_ID in('!user-130');
    #Recent Announcements
    update sakai_site_tool set title='最新公告浏览' where TOOL_ID in('!user-140');
    #Profile
    update sakai_site_tool set title='个人信息' where TOOL_ID in('!user-165');
    #Membership
    update sakai_site_tool set title='用户查询' where TOOL_ID in('!user-210');
    #Schedule
    update sakai_site_tool set title='日程管理' where TOOL_ID in('!user-310');
    #Resources
    update sakai_site_tool set title='课程资源' where TOOL_ID in('!user-410');
    #Announcements
    update sakai_site_tool set title='公告浏览' where TOOL_ID in('!user-455');
    #Worksite Setup
    update sakai_site_tool set title='站点管理' where TOOL_ID in('!user-510');
    #Preferences
    update sakai_site_tool set title='个人偏好' where TOOL_ID in('!user-610');
    #Account
    update sakai_site_tool set title='帐号管理' where TOOL_ID in('!user-710');
    
    
    #worksite站点右侧标题
    #My Workspace Information
    update sakai_site_tool set title='关于我的空间' where TOOL_ID in('!worksite-110');
    #Recent Announcements
    update sakai_site_tool set title='最新公告浏览' where TOOL_ID in('!worksite-120');
    #Recent Discussion Items
    update sakai_site_tool set title='近期论坛列表' where TOOL_ID in('!worksite-130');
    #Recent Chat Messages
    update sakai_site_tool set title='最新聊天信息' where TOOL_ID in('!worksite-140');
    #Schedule
    update sakai_site_tool set title='日程管理' where TOOL_ID in('!worksite-210');
    #Announcements
    update sakai_site_tool set title='公告浏览' where TOOL_ID in('!worksite-310');
    #Resources
    update sakai_site_tool set title='课程资源' where TOOL_ID in('!worksite-410');
    #iscussion
    update sakai_site_tool set title='论坛' where TOOL_ID in('!worksite-510');
    #Assignments
    update sakai_site_tool set title='作业' where TOOL_ID in('!worksite-610');
    #Drop Box
    update sakai_site_tool set title='投递箱' where TOOL_ID in('!worksite-710');
    # Chat
    update sakai_site_tool set title='聊天室' where TOOL_ID in('!worksite-810');
    #Email Archive
    update sakai_site_tool set title='邮件工具' where TOOL_ID in('!worksite-910');
    
    
    #显示在admin用户管理的mercury 站点右侧标题
    #My Workspace Information
    update sakai_site_tool set title='我的空间信息' where TOOL_ID in('mercury-110');
    #Recent Announcements
    update sakai_site_tool set title='最新公告浏览' where TOOL_ID in('mercury-120');
    #Recent Discussion Items
    update sakai_site_tool set title='近期论坛列表' where TOOL_ID in('mercury-130');
    #Recent Chat Messages
    update sakai_site_tool set title='最新聊天信息' where TOOL_ID in('mercury-140');
    #Schedule
    update sakai_site_tool set title='日程管理' where TOOL_ID in('mercury-210');
    #Announcements
    update sakai_site_tool set title='公告浏览' where TOOL_ID in('mercury-310');
    #Drop Box
    update sakai_site_tool set title='课程资源' where TOOL_ID in('mercury-410');
    #Discussion
    update sakai_site_tool set title='论坛' where TOOL_ID in('mercury-510');
    #Assignments
    update sakai_site_tool set title='作业' where TOOL_ID in('mercury-610');
    #Drop Box
    update sakai_site_tool set title='投递箱' where TOOL_ID in('mercury-710');
    #Chat
    update sakai_site_tool set title='聊天室' where TOOL_ID in('mercury-810');
    #Email Archive
    update sakai_site_tool set title='邮件工具' where TOOL_ID in('mercury-910');
    
    

    #显示在admin用户管理的my workspace 站点右侧标题
    #Job Scheduler
    update sakai_site_tool set title='定时任务' where TOOL_ID in('~admin-1010');
    #Message of the Day
    update sakai_site_tool set title='今日消息' where TOOL_ID in('~admin-110');
    #Become User
    update sakai_site_tool set title='帐号切换' where TOOL_ID in('~admin-1110');
    #My Workspace Information
    update sakai_site_tool set title='关于我的空间' where TOOL_ID in('~admin-120');
    #User Membership
    update sakai_site_tool set title='用户查询' where TOOL_ID in('~admin-1210');
    #Users
    update sakai_site_tool set title='用户管理' where TOOL_ID in('~admin-210');
    #Aliases
    update sakai_site_tool set title='别名设置' where TOOL_ID in('~admin-260');
    #Sites
    update sakai_site_tool set title='站点设计' where TOOL_ID in('~admin-310');
    #Realms
    update sakai_site_tool set title='权限管理' where TOOL_ID in('~admin-355');
    #Worksite Setup
    update sakai_site_tool set title='站点管理' where TOOL_ID in('~admin-365');
    #Message of the Day
    update sakai_site_tool set title='今日消息' where TOOL_ID in('~admin-410');
    #Resources
    update sakai_site_tool set title='课程资源' where TOOL_ID in('~admin-510');
    #On-Line
    update sakai_site_tool set title='在线信息' where TOOL_ID in('~admin-610');
    #Memory
    update sakai_site_tool set title='缓存管理' where TOOL_ID in('~admin-710');
    #Site Archive / Import
    update sakai_site_tool set title='站点存档/导入' where TOOL_ID in('~admin-910');
    

/* 4. Table: sakai_realm_role_desc */

    #Can read, revise, delete and add both content and participants to a site.
		update sakai_realm_role_desc set description='可以对站点的内容和参与者进行查看,修改,新增和删除' where ROLE_KEY='5';
		#Can read content, and add content to a site where appropriate.
		update sakai_realm_role_desc set description='可以对站点的内容适当的查看和新增' where ROLE_KEY='8';
		#Can read, add, and revise most content in their sections.
		update sakai_realm_role_desc set description='可以对站点的部分内容查看，新增和删除' where ROLE_KEY='9';


/* 5. Table: sam_type_t */

    #Access Denied
		update sam_type_t set description='拒绝访问' where TYPEID='30';
		#Read Only
		update sam_type_t set description='阅读' where TYPEID='31';
		#Read and Copy
		update sam_type_t set description='阅读和复制' where TYPEID='32';
		#Read/Write
		update sam_type_t set description='阅读和修改' where TYPEID='33';
		#Adminstration
		update sam_type_t set description='管理' where TYPEID='34';
		#Stanford Question Pool
		update sam_type_t set description='斯坦福题库' where TYPEID='65'; 
		#Taking Assessment
		update sam_type_t set description='获取测验' where TYPEID='81';
		#A Published Assessment
		update sam_type_t set description='发布测验' where TYPEID='101';


/* 6. Table: sam_functiondata_t */
    #Take Assessment
		update sam_functiondata_t set displayname='接受测验',description='接受测验' where functionid='1';
		#View Assessment
		update sam_functiondata_t set displayname='查看测验',description='查看测验' where functionid='2';
		#Submit Assessment
		update sam_functiondata_t set displayname='提交测验',description='提交测验' where functionid='3';
		#Submit Assessment For Grade
		update sam_functiondata_t set displayname='测验评分',description='测验评分' where functionid='4';

/* 7. Table: sakai_user */
    #administrator
    update sakai_user set last_name='学习管理系统',first_name='系统管理员' where user_id='admin';
    #postmaster
    update sakai_user set last_name='学习管理系统',first_name='邮箱管理员' where user_id='postmaster';