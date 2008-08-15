<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
   <jsp:setProperty name="msgs" property="baseName" value="org.sakaiproject.tool.permission.bundle.Messages"/>
</jsp:useBean>
  
<f:view>
	
	<sakai:view_container title="#{msgs.permissions_title}">
		<style type="text/css">
			@import url("/sakai-permission-tool/css/Permission.css");
		</style>

		<sakai:view_content>
			<h:form id="perms">
				<t:panelGroup style="width: 100%">
					<sakai:tool_bar >
						<sakai:tool_bar_item action="PermissionsViewAll" value="#{msgs.permissionsViewAll}" />
						<sakai:tool_bar_item action="PermissionsAnnouncement" value="#{msgs.permissionsAnnouncement}" />
						<sakai:tool_bar_item action="PermissionsCalendar" value="#{msgs.permissionsCalendar}" />
						<sakai:tool_bar_item action="PermissionsContent" value="#{msgs.permissionsContent}" />
					</sakai:tool_bar>
				</t:panelGroup>

			 	<sakai:view_title value="#{msgs.permissions_title} - #{msgs.permissions_success}"/>			 	
	
				<f:subview id="msg">
					<h:message for="msg" infoClass="success" fatalClass="alertMessage" style="margin-top: 15px;" showDetail="true"/>
				</f:subview>
				
				<sakai:button_bar>
					<sakai:button_bar_item id="List"
						action="#{PermissionListBean.processActionCancel}"
						value="#{msgs.permissions_cancel}"/>
				</sakai:button_bar>
			 </h:form>
  		</sakai:view_content>	
	</sakai:view_container>
</f:view> 