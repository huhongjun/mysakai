��������ָ�
   0�����contextmenu-cmd-sakai.reg���˺���Ҽ��������Dos����
   1������vcleĿ¼��ִ��setEnvSakaiMaven1.0.2.bat��
   2������sakai-src��ִ��maven bld dpl��	��benq - (build 12 min + deploy 4 min)��
   3������mysql.bat sakai.bat				��benq - 8���ӡ�
   4����������� http://localhost:8080/portal;

���ڱ��ݣ�
   ��ִ��maven cln��
   ��Ҫ���ݵ�Ŀ¼��	sakai-src
   
sakai��չ��
	https://source.sakaiproject.org/contrib/
	https://source.edtech.vt.edu/svn/sakai/
	https://svn.oucs.ox.ac.uk/projects/vle/sakai/
********************************************************************************************
2008/4/29
	ͬ�����ߡ����̹����������⣺����Դ����д��������ɵģ��ؼ�����eclipse�б���ʱ����javac �����-encodingѡ�maven�б���ʱû��
	���ع������⣺sakai.properties�в����пո�
	birt viewer webӦ�ñ��Ҳ��������Ĵ��󣺽�����������pluginĿ¼��jdbc����Ŀ¼
	birt viewer webӦ�ñ��ֶι���������дsql��䣬ȫ���ֹ�����as �ֶ���
	
2008/3/9
	mvn clean test   # Test against in-memory hsqldb
	mvn -Dtest.sakai.home=C:/java/sakaisettings/oracle-sakai/ clean test
	mvn -Dtest.sakai.home=C:/java/sakaisettings/mysql-sakai/ clean test

	web services����
		/sakai-axis/SakaiSite.jws?wsdl

2008/3/7 �ռ�EclipseVCLE��������ע��
	����վ������: 
		http://bugs.sakaiproject.org/confluence/display/ENC/Adding+a+Site+Type
		sakai.sitesetup.xml,ToolOrder.xml
	portal user display
	sakai portal flow=��д�ĵ�����portal��������
	
2008/3/6
	����=��Sakai 2.4.1 + mysql 5.0 ȫ��ϵͳ�İ�װ
		sakai 2.4.1
			GatewayӢ��
			���û����ҵĿռ�Ӣ��
			����Ա���ҵĿռ��������ģ�ϵͳ����վ������Ӣ��
		Melete
			��Ҫ�ֹ���һ���� melete_migrate_status
		jforum
			���Ա���������û����ԭ����Ҫmysql֧��innoDB��Ĭ�ϵ�mysql.ini�������ε�(������ע�͵�skipinnodb)
			Ҫ��admin��¼��վ��jforum���֣�Ȼ����manage���ӽ���ϵͳ����
			ֻ���maintenance��instructor��ɫ��jforum_manageȨ�޼���
				������admin��ͨ�Ĺ���Ȩ�ޣ����Ա�վ�����Ŀ����
		polls
			Ϊ���������ѡ��ʱ������jira�Ϸ����ǿ�����merge�˲���ȷ�Ĵ��룬��2.4.xά����֧���ѽ�������ظ��Ǽ���

		���䣺
			����demo���ݲ��ɹ�����Ϊ����sakai�Ľű��ļ����������û����Ժ͹���

	����=��sakai 2.5 + scorm player
		scorm ����eclipse�в��ٹ���Ҫ��
		scorm �������Ӣ�������������������õ�Ӱ��

2008/3/6
	Agora/SCORMPlayer��ͨ�Ķ���sakai 2.5
	
2008/1/4
	����ֱ���޸ĳ�ʼ��sql�ű���ʵ�����ݿ����ݵı��ػ�
	
2007/12/31
	keytool -genkey -alias agora -keystore agora.keystore

2007/12/26
	���죺
		������Redhat AS 4������Sakai�����������������ĵ�����Ӧ�����ļ���
		ʵ�����ά������Դ���֧������Patch��
		mysql�������ݵ�����Ϊ��׼sql��䣬�Ժ�����ã�
		����һ�����µ��޸��嵥��
		ʵ��������չ-agora/osp(��ģ��)��
		
	sakaiδ������⣺
		�༭HTML���룻
		-�ճ̹���=��ʱ������֡�û������Ӣ���б�����û�С�
		-�����γ�=��"��Ҫվ��"��Ϊ"����վ��"
			��/sakai/sakai/site-manage/site-manage-tool/tool/src/bundle/sitesetupgeneric_zh_CN.properties��
		�γ����͡��û����ͻ���Ӣ��=��course��project��student��
		����=��ģ�������Ӣ��
		�����̳��Ŀ=��������Ӣ��
		-ҳ��=��վ��bar��������ȥ��[����ν]
		����ƫ�ã�ҳ�����û���⣬���߱�����preferenceTool����������ť������Tabs����Ϊ���Ʊ�ǩҳ
		�γ̹���=��
			���ʿ��Ƶ�����˵��
			��ҳ��ۺ���ð��
			PageOrder��Ӣ�ģ�����ɾ��
		�ҵĿռ������ǽ�����Ϣ
		վ�����=��ҳ��=����������������ơ�����=�����벻׼ȷ��
		������summary
			������ʾ�����б����·���ʾ��������ʾ���ճ̱�û��ͳһ���֣�
			ѡ��=�������ȼ�ΪӢ��
			12�£�2007������"��"�֡�
		�ҵĿռ䣨JS001��=�����Ź����Ϊ�ʺŹ���
		JingBaoChen��oracle��ʾ�����ͼ�����ڣ�sakai_real��ͷ�ı���7��δ�Զ�������
	��¼��
		�˽�����ҳlayout����ƶ�: 1,1 ��ʾ1��1�У����Ǵ�0��ʼ������
		sakai 2.5��cssΪ��ߵĹ��߲˵�����ͼ��
	
2007/12/02
	Tomcat ����������ʱ maven cln bld dpl���ֿ����ˡ�

2007/11/30
	sakai-mini ��rwiki Tomcat���У�û�в��У���֡�
2007/11/28
	����URL����localhost��127.0.0.1��ʾ��ͬ��Ƥ������ǰ����favicon
		���firefox��cache��û�����ˣ�����favicon�������ˡ�
		ȷ��favicon�õ���Tomcat/ROOT�µ��ļ���
	mysql��־�ļ���ɾȥ
	����PageOrder��Ӣ�ģ�δ�����ɾȥ��ģ�顣
2007/11/27
	��������gmail�ϵı������Ϻ�scrabook���ռ������ϣ����ϵ�VCLE��edlt��
	����VCLE�е��ĵ��ļ���

2007/10/16  
	ϵͳ��¼�û���administrator
	���Ŀ¼��
		D:\VCLE
		D:\var
		D:\ADeveloper\Java\jdk1.5.0
		D:\ADeveloper\maven-1.0.2
		D:\ADeveloper\Tomcat-5.5.23
		D:\ADeveloper\Tomcat-5.5.23\sakai

		C:\Documents and Settings\Administrator\build.properties
		C:\Documents and Settings\Administrator\.maven

2007/10/12 �������������IBM-edlt���ԣ�����������һ������