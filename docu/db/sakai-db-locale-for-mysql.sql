/* ִ�з�ʽ�� mysql>source sakai-db-locale.sql */

set names 'GBK';

/* 1. Table: sakai_site, Column: Title,Short_desc,Description */
	
		# Administration Workspace 
		update sakai_site set title='ϵͳ����',description='ϵͳ����Աר��վ�� !admin' where SITE_ID='!admin';
		
		# Site Unavailable,The site you requested is not available. */
		update sakai_site set title='վ�㲻����',description='��������ǲ����õ�վ��' where SITE_ID='!error';
		
		# Gateway��The Gateway Site
		update sakai_site set title='��¼',description='ѧϰ����ϵͳ���ҳ��' where SITE_ID='!gateway';
	
		# Invalid URL��The URL you entered is invalid.  SOLUTIONS: Please check for spelling errors or typos.  Make sure you are using the right URL.  Type a URL to try again.
		update sakai_site set title='�����URL',description='û���ҵ�ҳ�档��ʾ���鿴����������Ƿ����󣬲鿴�����URL�Ƿ���ȷ����������URL����' where SITE_ID='!urlError';
	
		# My Workspace��My Workspace Site
		update sakai_site set title='�ҵĿռ�',description='�ҵĿռ�' where SITE_ID='!user';
	
		# worksite
		update sakai_site set title='�ռ�',description='' where SITE_ID='!worksite';
	
		# mercury site
		update sakai_site set title='mercury վ��',description='mercury վ��' where SITE_ID='mercury';
	
		# Administration Workspace
		update sakai_site set title='�ҵĿռ�',description='�ҵĿռ� - ϵͳ����Ա' where SITE_ID='~admin';
	
/* 2. Table: sakai_site_page */

    /**********    sakai_site_page��Ӣ�Ķ����б�    **********************************
     
    Home:��ҳ                                *        Job Scheduler���ճ̰���
    Become User���ʺ��л�                    *        User Membership���û���ѯ
    Users���û�����                          *        Aliases����������
    Sites��վ�㴴��                          *        Realms��Ȩ�޹���
    Worksite Setup��վ�����                 *        MOTD��������Ϣ
    Resources���γ���Դ                        *        On-Line��������Ϣ
    Memory���ڴ����                         *        Site Archive��վ��鵵
    Site Unavailable��վ�㲻����             *        Welcome:��ӭ
    About������                              *        Features����������
    Training����ϰ                           *        Acknowledgments��������Զ
    New Account�����û�ע��                  *        Invalid URL������ url
    Profile��������Ϣ                        *        Membership���û���ѯ
    Schedule���ճ̹���                       *        Announcements���������
    Preferences������ƫ��                    *        Account���˺Ź���
    Discussion����̳                         *        Assignments����ҵ
    Drop Box��Ͷ����                         *        Chat��������
    Email Archive���ʼ�����
    
    **********************************************************************************/
    
    
    #��ʾ��admin�û������administration workspace վ������б�
    
		    # Home
		    update sakai_site_page set title='��ҳ'	where PAGE_ID in('!admin-100');
		    # Job Scheduler
		    	update sakai_site_page set title='��ʱ����'	where PAGE_ID in('!admin-1000');
				# Become User
				update sakai_site_page set title='�ʺ��л�'	where PAGE_ID in('!admin-1100');  
				# Membership
				update sakai_site_page set title='�û���ѯ'	where PAGE_ID in('!admin-1200');
				# Users
				update sakai_site_page set title='�û�����'	where PAGE_ID in('!admin-200');
		    # Aliases
		    update sakai_site_page set title='��������'	where PAGE_ID in('!admin-250');
		    # Sites
		    	update sakai_site_page set title='վ�����'	where PAGE_ID in('!admin-300');
				# Realms
				update sakai_site_page set title='Ȩ�޹���'	where PAGE_ID in('!admin-350');        
				# Worksite Setup
				update sakai_site_page set title='վ�����'	where PAGE_ID in('!admin-360');
				# MOTD
				update sakai_site_page set title='������Ϣ'	where PAGE_ID in('!admin-400');
		    # Resources
		    	update sakai_site_page set title='��Դ�ֿ�'	where PAGE_ID in('!admin-500');
		    # On-Line
		    	update sakai_site_page set title='������Ϣ'	where PAGE_ID in('!admin-600');
				# Memory
				update sakai_site_page set title='�������'	where PAGE_ID in('!admin-700');        
				# Site Archive
				update sakai_site_page set title='���ݻָ�'	where PAGE_ID in('!admin-900');
				# Site Unavailable
				update sakai_site_page set title='վ�㲻����'	where PAGE_ID in('!error-100');
    
		#δ��¼ҳ����ʾ����б�
		
				#Welcome
				update sakai_site_page set title='��ӭ'	where PAGE_ID in('!gateway-100');
				#About
				update sakai_site_page set title='����'	where PAGE_ID in('!gateway-200');
				#Features
				update sakai_site_page set title='���ܼ��'	where PAGE_ID in('!gateway-300');
				# Sites
				update sakai_site_page set title='�γ�����'	where PAGE_ID in('!gateway-400');
				#Training
				update sakai_site_page set title='�û���ѵ'	where PAGE_ID in('!gateway-500');
				#Acknowledgments
				update sakai_site_page set title='������Զ'	where PAGE_ID in('!gateway-600');
				#New Account
				update sakai_site_page set title='�û�ע��'	where PAGE_ID in('!gateway-700');
				#Invalid URL
				update sakai_site_page set title='����URL'	where PAGE_ID in('!urlError-100');
		
		#��ͨ�û�����my workspaceվ������б�

				#Home
				update sakai_site_page set title='��ҳ'	where PAGE_ID in('!user-100');
				#Profile
				update sakai_site_page set title='������Ϣ'	where PAGE_ID in('!user-150');
				#Membership
				update sakai_site_page set title='�ҵĿγ�'	where PAGE_ID in('!user-200');
				#Schedule
				update sakai_site_page set title='�ճ̹���'	where PAGE_ID in('!user-300');
				#Resources
				update sakai_site_page set title='�γ���Դ'	where PAGE_ID in('!user-400');
				#Announcements
				update sakai_site_page set title='�������'	where PAGE_ID in('!user-450');
				#Worksite Setup
				update sakai_site_page set title='վ�����'	where PAGE_ID in('!user-500');
				#Preferences
				update sakai_site_page set title='����ƫ��'	where PAGE_ID in('!user-600');
				#Account
				update sakai_site_page set title='�ʺŹ���'	where PAGE_ID in('!user-700');
		  
		#worksiteվ������б�

				#Home
				update sakai_site_page set title='��ҳ'	where PAGE_ID in('!worksite-100');
				#Schedule
				update sakai_site_page set title='�ճ̹���'	where PAGE_ID in('!worksite-200');
				#Announcements
				update sakai_site_page set title='�������'	where PAGE_ID in('!worksite-300');
				#Resources
				update sakai_site_page set title='�γ���Դ'	where PAGE_ID in('!worksite-400');
				#Discussion
				update sakai_site_page set title='�γ���̳'	where PAGE_ID in('!worksite-500');
				#Assignments
				update sakai_site_page set title='��ҵ����'	where PAGE_ID in('!worksite-600');
				#Drop Box
				update sakai_site_page set title='Ͷ����'	where PAGE_ID in('!worksite-700');
				#Chat
				update sakai_site_page set title='������'	where PAGE_ID in('!worksite-800');
				#Email Archive
				update sakai_site_page set title='�ʼ�����'	where PAGE_ID in('!worksite-900');
			
	  #��ʾ��admin�û������mercury վ������б�
			  #Home
				update sakai_site_page set title='��ҳ'	where PAGE_ID in('mercury-100');
				#Schedule
				update sakai_site_page set title='�ճ̹���'	where PAGE_ID in('mercury-200');
				#Announcements
				update sakai_site_page set title='�������'	where PAGE_ID in('mercury-300');
				#Resources
				update sakai_site_page set title='�γ���Դ'	where PAGE_ID in('mercury-400');
				#Discussion
				update sakai_site_page set title='��̳'	where PAGE_ID in('mercury-500');
				#Assignments
				update sakai_site_page set title='��ҵ'	where PAGE_ID in('mercury-600');
				# Drop Box
				update sakai_site_page set title='Ͷ����'	where PAGE_ID in('mercury-700');
				#Chat
				update sakai_site_page set title='������'	where PAGE_ID in('mercury-800');
				#Email Archive
				update sakai_site_page set title='�ʼ�����'	where PAGE_ID in('mercury-900');
		
		#��ʾ��admin�û������my workspace վ������б�
				#Home
				update sakai_site_page set title='��ҳ'	where PAGE_ID in('~admin-100');
				#Job Scheduler
				update sakai_site_page set title='��ʱ����'	where PAGE_ID in('~admin-1000');
				#Become User
				update sakai_site_page set title='�ʺ��л�'	where PAGE_ID in('~admin-1100');
				#Membership
				update sakai_site_page set title='�û���ѯ'	where PAGE_ID in('~admin-1200');
				#Users
				update sakai_site_page set title='�û�����'	where PAGE_ID in('~admin-200');
				#Aliases
				update sakai_site_page set title='��������'	where PAGE_ID in('~admin-250');
				#Sites
				update sakai_site_page set title='վ�����'	where PAGE_ID in('~admin-300');
				#Realms
				update sakai_site_page set title='Ȩ�޹���'	where PAGE_ID in('~admin-350');
				#Worksite Setup
				update sakai_site_page set title='վ�����'	where PAGE_ID in('~admin-360');
				#MOTD
				update sakai_site_page set title='������Ϣ'	where PAGE_ID in('~admin-400');
				#Resources
				update sakai_site_page set title='�γ���Դ'	where PAGE_ID in('~admin-500');
				#On-Line
				update sakai_site_page set title='������Ϣ'	where PAGE_ID in('~admin-600');
				#Memory
				update sakai_site_page set title='�������'	where PAGE_ID in('~admin-700');
				#Site Archive
				update sakai_site_page set title='���ݻָ�'	where PAGE_ID in('~admin-900');
    
/* 3. Table: sakai_site_tool */

     /**********    sakai_site_tool��Ӣ�Ķ����б�    ********************************
     
     Recent Announcements:���¹������        *         Job Scheduler���ճ̰���
     Become User���ʺ��л�                    *         User Membership���û���ѯ
     Users���û�����                          *         Aliases����������
     Sites��վ�㴴��                          *         Realms��Ȩ�޹���
     Worksite Setup��վ�����                 *         MOTD��������Ϣ
     Resources���γ���Դ                        *         On-Line��������Ϣ
     Memory���ڴ����                         *         My Workspace Information:�ҵĿռ���Ϣ
     Site Unavailable��վ�㲻����             *         Welcome:��ӭ
     About������                              *         Features����������
     Training����ϰ                           *         Acknowledgments��������Զ
     New Account�����û�ע��                  *         Invalid URL������ url
     Profile��������Ϣ                        *         Site Archive / Import:վ�� �浵/���� 
     Schedule���ճ̹���                       *         Announcements���������
     Preferences������ƫ��                    *         Account���˺Ź���
     Discussion����̳                         *         Assignments����ҵ
     Drop Box��Ͷ����                         *         Chat��������
     Email Archive���ʼ�����                  *         Recent Discussion Items:������̳�б�
     Calendar:����                            *         Message of the Day:������Ϣ
     Membership:�û���ѯ                      *         Recent Chat Messages:����������Ϣ
    
    ********************************************************************************/
    
    #��ʾ��admin�û������administration workspace վ���Ҳ����
    #�ճ̰���
    	update sakai_site_tool set title='��ʱ����' where TOOL_ID in('!admin-1010');
    #MOTD
    	update sakai_site_tool set title='������Ϣ' where TOOL_ID in('!admin-110');
    #Become User
    	update sakai_site_tool set title='�ʺ��л�' where TOOL_ID in('!admin-1110');
    #My Workspace Information
    	update sakai_site_tool set title='�����ҵĿռ�' where TOOL_ID in('!admin-120');
    #User Membership
    update sakai_site_tool set title='�û���ѯ' where TOOL_ID in('!admin-1210');
    #Users
    update sakai_site_tool set title='�û�����' where TOOL_ID in('!admin-210');
    #Aliases
    update sakai_site_tool set title='��������' where TOOL_ID in('!admin-260');
    #Sites
    update sakai_site_tool set title='վ�����' where TOOL_ID in('!admin-310');
    #Realms
    update sakai_site_tool set title='Ȩ�޹���' where TOOL_ID in('!admin-355');
    #Worksite Setup
    update sakai_site_tool set title='վ�����' where TOOL_ID in('!admin-365');
    #MOTD
    update sakai_site_tool set title='������Ϣ' where TOOL_ID in('!admin-410');
    #Resources
    update sakai_site_tool set title='��Դ�ֿ�' where TOOL_ID in('!admin-510');
    #On-Line
    update sakai_site_tool set title='������Ϣ' where TOOL_ID in('!admin-610');
    #Memory
    update sakai_site_tool set title='�������' where TOOL_ID in('!admin-710');
    #Site Archive / Import
    update sakai_site_tool set title='վ��Ĵ浵/����' where TOOL_ID in('!admin-910');
    #Site Unavailable
    update sakai_site_tool set title='վ�㲻����' where TOOL_ID in('!error-110');
    
   #��ʾ��δ��¼ҳ���Ҳ����
    #MOTD
    update sakai_site_tool set title='������Ϣ' where TOOL_ID in('!gateway-110');
    #Welcome
    update sakai_site_tool set title='��ӭ - ��������ѧϰ����ϵͳ!' where TOOL_ID in('!gateway-120');
    #About
    update sakai_site_tool set title='����......' where TOOL_ID in('!gateway-210');
    #Features
    update sakai_site_tool set title='ѧϰ����ϵͳ���ܼ��' where TOOL_ID in('!gateway-310');
    #Sites
    update sakai_site_tool set title='�γ�����' where TOOL_ID in('!gateway-410');
    #Training
    update sakai_site_tool set title='�û���ѵ' where TOOL_ID in('!gateway-510');
    #Acknowledgments
    update sakai_site_tool set title='������Զ' where TOOL_ID in('!gateway-610');
    #New Account
    update sakai_site_tool set title='�û�ע��' where TOOL_ID in('!gateway-710');
    #Invalid URL
    update sakai_site_tool set title='����URL' where TOOL_ID in('!urlError-110');
    
    
    #��ͨ�û�����my workspaceվ���Ҳ����
    #MOTD
    update sakai_site_tool set title='������Ϣ' where TOOL_ID in('!user-110');
    #My Workspace Information
    update sakai_site_tool set title='�����ҵĿռ�' where TOOL_ID in('!user-120');
    #Calendar
    update sakai_site_tool set title='����' where TOOL_ID in('!user-130');
    #Recent Announcements
    update sakai_site_tool set title='���¹������' where TOOL_ID in('!user-140');
    #Profile
    update sakai_site_tool set title='������Ϣ' where TOOL_ID in('!user-165');
    #Membership
    update sakai_site_tool set title='�û���ѯ' where TOOL_ID in('!user-210');
    #Schedule
    update sakai_site_tool set title='�ճ̹���' where TOOL_ID in('!user-310');
    #Resources
    update sakai_site_tool set title='�γ���Դ' where TOOL_ID in('!user-410');
    #Announcements
    update sakai_site_tool set title='�������' where TOOL_ID in('!user-455');
    #Worksite Setup
    update sakai_site_tool set title='վ�����' where TOOL_ID in('!user-510');
    #Preferences
    update sakai_site_tool set title='����ƫ��' where TOOL_ID in('!user-610');
    #Account
    update sakai_site_tool set title='�ʺŹ���' where TOOL_ID in('!user-710');
    
    
    #worksiteվ���Ҳ����
    #My Workspace Information
    update sakai_site_tool set title='�����ҵĿռ�' where TOOL_ID in('!worksite-110');
    #Recent Announcements
    update sakai_site_tool set title='���¹������' where TOOL_ID in('!worksite-120');
    #Recent Discussion Items
    update sakai_site_tool set title='������̳�б�' where TOOL_ID in('!worksite-130');
    #Recent Chat Messages
    update sakai_site_tool set title='����������Ϣ' where TOOL_ID in('!worksite-140');
    #Schedule
    update sakai_site_tool set title='�ճ̹���' where TOOL_ID in('!worksite-210');
    #Announcements
    update sakai_site_tool set title='�������' where TOOL_ID in('!worksite-310');
    #Resources
    update sakai_site_tool set title='�γ���Դ' where TOOL_ID in('!worksite-410');
    #iscussion
    update sakai_site_tool set title='��̳' where TOOL_ID in('!worksite-510');
    #Assignments
    update sakai_site_tool set title='��ҵ' where TOOL_ID in('!worksite-610');
    #Drop Box
    update sakai_site_tool set title='Ͷ����' where TOOL_ID in('!worksite-710');
    # Chat
    update sakai_site_tool set title='������' where TOOL_ID in('!worksite-810');
    #Email Archive
    update sakai_site_tool set title='�ʼ�����' where TOOL_ID in('!worksite-910');
    
    
    #��ʾ��admin�û������mercury վ���Ҳ����
    #My Workspace Information
    update sakai_site_tool set title='�ҵĿռ���Ϣ' where TOOL_ID in('mercury-110');
    #Recent Announcements
    update sakai_site_tool set title='���¹������' where TOOL_ID in('mercury-120');
    #Recent Discussion Items
    update sakai_site_tool set title='������̳�б�' where TOOL_ID in('mercury-130');
    #Recent Chat Messages
    update sakai_site_tool set title='����������Ϣ' where TOOL_ID in('mercury-140');
    #Schedule
    update sakai_site_tool set title='�ճ̹���' where TOOL_ID in('mercury-210');
    #Announcements
    update sakai_site_tool set title='�������' where TOOL_ID in('mercury-310');
    #Drop Box
    update sakai_site_tool set title='�γ���Դ' where TOOL_ID in('mercury-410');
    #Discussion
    update sakai_site_tool set title='��̳' where TOOL_ID in('mercury-510');
    #Assignments
    update sakai_site_tool set title='��ҵ' where TOOL_ID in('mercury-610');
    #Drop Box
    update sakai_site_tool set title='Ͷ����' where TOOL_ID in('mercury-710');
    #Chat
    update sakai_site_tool set title='������' where TOOL_ID in('mercury-810');
    #Email Archive
    update sakai_site_tool set title='�ʼ�����' where TOOL_ID in('mercury-910');
    
    

    #��ʾ��admin�û������my workspace վ���Ҳ����
    #Job Scheduler
    update sakai_site_tool set title='��ʱ����' where TOOL_ID in('~admin-1010');
    #Message of the Day
    update sakai_site_tool set title='������Ϣ' where TOOL_ID in('~admin-110');
    #Become User
    update sakai_site_tool set title='�ʺ��л�' where TOOL_ID in('~admin-1110');
    #My Workspace Information
    update sakai_site_tool set title='�����ҵĿռ�' where TOOL_ID in('~admin-120');
    #User Membership
    update sakai_site_tool set title='�û���ѯ' where TOOL_ID in('~admin-1210');
    #Users
    update sakai_site_tool set title='�û�����' where TOOL_ID in('~admin-210');
    #Aliases
    update sakai_site_tool set title='��������' where TOOL_ID in('~admin-260');
    #Sites
    update sakai_site_tool set title='վ�����' where TOOL_ID in('~admin-310');
    #Realms
    update sakai_site_tool set title='Ȩ�޹���' where TOOL_ID in('~admin-355');
    #Worksite Setup
    update sakai_site_tool set title='վ�����' where TOOL_ID in('~admin-365');
    #Message of the Day
    update sakai_site_tool set title='������Ϣ' where TOOL_ID in('~admin-410');
    #Resources
    update sakai_site_tool set title='�γ���Դ' where TOOL_ID in('~admin-510');
    #On-Line
    update sakai_site_tool set title='������Ϣ' where TOOL_ID in('~admin-610');
    #Memory
    update sakai_site_tool set title='�������' where TOOL_ID in('~admin-710');
    #Site Archive / Import
    update sakai_site_tool set title='վ��浵/����' where TOOL_ID in('~admin-910');
    

/* 4. Table: sakai_realm_role_desc */

    #Can read, revise, delete and add both content and participants to a site.
		update sakai_realm_role_desc set description='���Զ�վ������ݺͲ����߽��в鿴,�޸�,������ɾ��' where ROLE_KEY='5';
		#Can read content, and add content to a site where appropriate.
		update sakai_realm_role_desc set description='���Զ�վ��������ʵ��Ĳ鿴������' where ROLE_KEY='8';
		#Can read, add, and revise most content in their sections.
		update sakai_realm_role_desc set description='���Զ�վ��Ĳ������ݲ鿴��������ɾ��' where ROLE_KEY='9';


/* 5. Table: sam_type_t */

    #Access Denied
		update sam_type_t set description='�ܾ�����' where TYPEID='30';
		#Read Only
		update sam_type_t set description='�Ķ�' where TYPEID='31';
		#Read and Copy
		update sam_type_t set description='�Ķ��͸���' where TYPEID='32';
		#Read/Write
		update sam_type_t set description='�Ķ����޸�' where TYPEID='33';
		#Adminstration
		update sam_type_t set description='����' where TYPEID='34';
		#Stanford Question Pool
		update sam_type_t set description='˹̹�����' where TYPEID='65'; 
		#Taking Assessment
		update sam_type_t set description='��ȡ����' where TYPEID='81';
		#A Published Assessment
		update sam_type_t set description='��������' where TYPEID='101';


/* 6. Table: sam_functiondata_t */
    #Take Assessment
		update sam_functiondata_t set displayname='���ܲ���',description='���ܲ���' where functionid='1';
		#View Assessment
		update sam_functiondata_t set displayname='�鿴����',description='�鿴����' where functionid='2';
		#Submit Assessment
		update sam_functiondata_t set displayname='�ύ����',description='�ύ����' where functionid='3';
		#Submit Assessment For Grade
		update sam_functiondata_t set displayname='��������',description='��������' where functionid='4';

/* 7. Table: sakai_user */
    #administrator
    update sakai_user set last_name='ѧϰ����ϵͳ',first_name='ϵͳ����Ա' where user_id='admin';
    #postmaster
    update sakai_user set last_name='ѧϰ����ϵͳ',first_name='�������Ա' where user_id='postmaster';