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
<%@ page import="org.sakaiproject.birt.tool.jsf.BirtBean" %>


<%     
	String reportUrl = ServerConfigurationService.getString("reportUrl","http://192.168.0.79:8888/birtviewer/");
	
	Placement pm = ToolManager.getCurrentPlacement();
	String as = pm.getTitle();
	String courseId = pm.getContext();
	
	reportUrl = reportUrl+"run";
	
	//获得birtviewer的url,输入报表参数，拼成报表带参数的url，设置为frame的url
	//增加多个报表，使报表可选
%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>


<%@ page import="org.sakaiproject.site.api.Site" %>
<%@ page import="org.sakaiproject.site.cover.SiteService" %>
<%@ page import="org.sakaiproject.tool.api.Session" %>
<%@ page import="org.sakaiproject.tool.api.ToolSession" %>

<%@ page import="org.sakaiproject.user.cover.UserDirectoryService" %>
<%@ page import="org.sakaiproject.tool.cover.ToolManager" %>
<%@ page import="org.sakaiproject.component.cover.ServerConfigurationService" %>

<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
   <jsp:setProperty name="msgs" property="baseName" value="org.sakaiproject.tool.permission.bundle.Messages"/>
</jsp:useBean>
 
<f:view>
	
	<sakai:view_container title="#{msgs.permissions_title}">
		<style type="text/css">
			@import url("/sakai-permission-tool/css/Permission.css");
		</style>

		<sakai:view_content>

<table width="100%"><tbody>
			<tr >
				<td>
					<p align="center">报表参数设置</p>
					<form name="myform" action="<%=reportUrl%>" method="post" target="downframe">
						<p align="center">

		<t:div styleClass="indnt1">
        	<t:panelGrid columns="2">
            	<t:outputLabel for="selectViewMode" value=""/>
                 <h:selectOneMenu 
                	id="selectViewMode"
                    immediate="false"
                    value="#{BirtBean.selectedViewMode}">
                   	<f:selectItems value="#{BirtBean.viewModes}"/>
				   </h:selectOneMenu>  
			</t:panelGrid>
		</t:div>

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
			</tr>  </tbody>
</table>
  		</sakai:view_content>	
	</sakai:view_container>
</f:view> 