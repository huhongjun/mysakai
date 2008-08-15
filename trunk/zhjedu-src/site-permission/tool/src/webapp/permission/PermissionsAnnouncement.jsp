<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
   <jsp:setProperty name="msgs" property="baseName" value="org.sakaiproject.tool.permission.bundle.Messages"/>
</jsp:useBean>
 
<f:view>
	
	<sakai:view_container title="#{msgs.permissionsAnnouncement}">
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

			 	<sakai:view_title value="#{msgs.permissions_title} - #{msgs.permissionsAnnouncement}"/>
	
				<f:subview id="msg">
					<h:message for="msg" infoClass="success" fatalClass="alertMessage" style="margin-top: 15px;" showDetail="true"/>
				</f:subview>
						
				<!-- zml add Announcement start -->
				<t:dataTable id="permissionlistAnnouncement" 
					value="#{PermissionListBean.allPermissions}"
					var="entry"
					headerClass="headerAlignment" 
					styleClass="listHier">
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.permissions_roles}" />
						</f:facet>
						<h:outputText value="#{entry.role.description}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementRead}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementRead" value="#{entry.announcementRead}"/>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementNew}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementNew" value="#{entry.announcementNew}"/>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementDeleteAny}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementDeleteAny" value="#{entry.announcementDeleteAny}"/>
					</h:column>					
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementReviseAny}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementReviseAny" value="#{entry.announcementReviseAny}"/>
					</h:column>							
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementAllGroups}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementAllGroups" value="#{entry.announcementAllGroups}"/>
					</h:column>												
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementReadDrafts}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementReadDrafts" value="#{entry.announcementReadDrafts}"/>
					</h:column>										
				</t:dataTable>
				<!-- zml add Announcement end -->	
				
				<sakai:button_bar>
					<sakai:button_bar_item id="save"
						action="#{PermissionListBean.processActionSavePermissions}"
						value="#{msgs.permissions_save}"
                		styleClass="active"/>
					<sakai:button_bar_item id="cancel"
						action="PermissionsAnnouncement"
						value="#{msgs.permissions_cancel}"/>
				</sakai:button_bar>
			    

			 </h:form>
  		</sakai:view_content>	
	</sakai:view_container>
</f:view> 