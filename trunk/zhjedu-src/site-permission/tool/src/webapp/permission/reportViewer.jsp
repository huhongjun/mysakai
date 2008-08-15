<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="org.sakaiproject.user.api.User" %>
<%@ page import="org.sakaiproject.tool.api.Placement" %>
<%@ page import="org.sakaiproject.site.api.Site" %>
<%@ page import="org.sakaiproject.site.cover.SiteService" %>
<%@ page import="org.sakaiproject.tool.api.Session" %>
<%@ page import="org.sakaiproject.tool.api.ToolSession" %>

<%@ page import="org.sakaiproject.user.cover.UserDirectoryService" %>
<%@ page import="org.sakaiproject.tool.cover.ToolManager" %>
<%@ page import="org.sakaiproject.component.cover.ServerConfigurationService" %>

<%     
	String reportUrl = ServerConfigurationService.getString("reportUrl","http://192.168.0.80:9080/birtviewer/");
	
	Placement pm = ToolManager.getCurrentPlacement();
	String as = pm.getTitle();
	String courseId = pm.getContext();
	
	reportUrl = reportUrl+"run";
	
	//获得birtviewer的url,输入报表参数，拼成报表带参数的url，设置为frame的url
	//增加多个报表，使报表可选
	out.println("reportURL: " + reportUrl);
%>

<HTML>
	<HEAD>
	 
	</HEAD>
	<BODY>
		<table width="100%">
			<tr >
				<td>
					<p align="center">报表参数设置</p>
					<form name="myform" action="<%=reportUrl%>" method="post" target="downframe">
						<p align="center">
							<input type="hidden" name="__report" value="report/JforumTopics80.rptdesign" >
							<input type="hidden" name="courseid" value="<%=courseId%>" >
							<input type="submit" value="确定">
						</p>
					</form>
				</td>
			</tr>

			<tr>
			<td>
			<iframe name="downframe" width="100%" height="1000" src="#"></iframe>
			</td>
			</tr>
		</table>

	 	</BODY>
</HTML>
