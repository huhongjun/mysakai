<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" language="java" %>

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
	out.println("Started:");
	String mtsUrl = ServerConfigurationService.getString("mtsUrl","no config");
	out.println(mtsUrl);
	User user = UserDirectoryService.getCurrentUser();
	String userEid = user.getEid();
	
	Placement pm = ToolManager.getCurrentPlacement();
	String as = pm.getTitle();
	String courseId = pm.getContext();
	
	mtsUrl = mtsUrl+"?userEid="+userEid+"&"+"courseId="+courseId;
	
	out.println("mtsURL: "+mtsUrl);

%>