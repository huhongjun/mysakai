<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8"
	language="java"%>

<%@ page import="org.sakaiproject.user.api.User"%>
<%@ page import="org.sakaiproject.tool.api.Placement"%>
<%@ page import="org.sakaiproject.site.api.Site"%>
<%@ page import="org.sakaiproject.site.cover.SiteService"%>
<%@ page import="org.sakaiproject.tool.api.Session"%>
<%@ page import="org.sakaiproject.tool.cover.SessionManager"%>
<%@ page import="org.sakaiproject.tool.api.ToolSession"%>

<%@ page import="org.sakaiproject.user.cover.UserDirectoryService"%>
<%@ page import="org.sakaiproject.tool.cover.ToolManager"%>
<%@ page import="org.sakaiproject.component.cover.ServerConfigurationService"%>

<%
	String mts = ServerConfigurationService.getString("mtsUrl","http://192.168.0.99/mts");
	User user = UserDirectoryService.getCurrentUser();
	String userId = user.getEid();

	Placement pm = ToolManager.getCurrentPlacement();
	String as = pm.getTitle();
	String courseId = pm.getContext();

	String mtsUrl = mts + "&" + "courseId=" + courseId + "&" + "userId="
			+ userId + "&" + "logintype=zhj";
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>机考</title>
	</head>
	<body>
		<br>
		<br>
		<table border align=center width=400>
			<tr align=center>
				<th width=150>
					<font color=Navy>进入作业系统</font>
				</th>
				<td>
					<a href="#"
						onclick="javascript:window.open('<%=mtsUrl%>', 'newwindow','')">打开</a>
				</td>
			</tr>
			<tr align=center>
				<th width=150>
					<font color=Navy>进入作业系统</font>
				</th>
				<td>
					<a href="#"
						onclick="javascript:window.open('<%=mtsUrl%>', 'newwindow','')">打开</a>
				</td>
			</tr>
			<tr align=center>
				<th width=150>
					<font color=Navy>进入作业系统</font>
				</th>
				<td>
					<a href="#"
						onclick="javascript:window.open('<%=mtsUrl%>', 'newwindow','')">打开</a>
				</td>
			</tr>
		</table>

	</body>
</html>
