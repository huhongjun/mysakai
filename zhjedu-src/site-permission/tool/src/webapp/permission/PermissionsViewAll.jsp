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
						<sakai:tool_bar_item action="PermissionsAnnouncement" value="#{msgs.permissionsAnnouncement}" rendered="#{PermissionListBean.siteOwner}"/>
						<sakai:tool_bar_item action="PermissionsCalendar" value="#{msgs.permissionsCalendar}" rendered="#{PermissionListBean.siteOwner}"/>
						<sakai:tool_bar_item action="PermissionsContent" value="#{msgs.permissionsContent}" rendered="#{PermissionListBean.siteOwner}"/>
					</sakai:tool_bar>
				</t:panelGroup>

			 	<sakai:view_title value="#{msgs.permissions_title} - #{msgs.permissionsViewAll}"/>
	
				<f:subview id="msg">
					<h:message for="msg" infoClass="success" fatalClass="alertMessage" style="margin-top: 15px;" showDetail="true"/>
				</f:subview>
						
				<!-- zml add Announcement start -->
				<sakai:view_title value="1.#{msgs.permissionsAnnouncement}"/>
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
						<h:selectBooleanCheckbox id="announcementRead" value="#{entry.announcementRead}" disabled="true"/>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementNew}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementNew" value="#{entry.announcementNew}" disabled="true"/>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementDeleteAny}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementDeleteAny" value="#{entry.announcementDeleteAny}" disabled="true"/>
					</h:column>					
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementReviseAny}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementReviseAny" value="#{entry.announcementReviseAny}" disabled="true"/>
					</h:column>							
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementAllGroups}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementAllGroups" value="#{entry.announcementAllGroups}" disabled="true"/>
					</h:column>												
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.AnnouncementReadDrafts}" />
						</f:facet>
						<h:selectBooleanCheckbox id="announcementReadDrafts" value="#{entry.announcementReadDrafts}" disabled="true"/>
					</h:column>										
				</t:dataTable>
				<!-- zml add Announcement end -->	
				
				<!-- zml add Calendar start -->
				<sakai:view_title value="2.#{msgs.permissionsCalendar}"/>				
				<t:dataTable id="permissionlistCalendar" 
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
							<h:outputText value="#{msgs.CalendarNew}" />
						</f:facet>
						<h:selectBooleanCheckbox id="calendarNew" value="#{entry.calendarNew}" disabled="true"/>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.CalendarDeleteOwn}" />
						</f:facet>
						<h:selectBooleanCheckbox id="calendarDeleteOwn" value="#{entry.calendarDeleteOwn}" disabled="true"/>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.CalendarDeleteAny}" />
						</f:facet>
						<h:selectBooleanCheckbox id="calendarDeleteAny" value="#{entry.calendarDeleteAny}" disabled="true"/>
					</h:column>					
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.CalendarReviseOwn}" />
						</f:facet>
						<h:selectBooleanCheckbox id="calendarReviseOwn" value="#{entry.calendarReviseOwn}" disabled="true"/>
					</h:column>							
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.CalendarReviseAny}" />
						</f:facet>
						<h:selectBooleanCheckbox id="calendarReviseAny" value="#{entry.calendarReviseAny}" disabled="true"/>
					</h:column>												
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.CalendarImport}" />
						</f:facet>
						<h:selectBooleanCheckbox id="calendarImport" value="#{entry.calendarImport}" disabled="true"/>
					</h:column>						
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.CalendarRead}" />
						</f:facet>
						<h:selectBooleanCheckbox id="calendarRead" value="#{entry.calendarRead}" disabled="true"/>
					</h:column>	
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.CalendarAllGroups}" />
						</f:facet>
						<h:selectBooleanCheckbox id="calendarAllGroups" value="#{entry.calendarAllGroups}" disabled="true"/>
					</h:column>						
				</t:dataTable>
				<!-- zml add Calendar end -->	
				
				<!-- zml add Content start -->
				<sakai:view_title value="3.#{msgs.permissionsContent}"/>								
				<t:dataTable id="permissionlistContent" 
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
							<h:outputText value="#{msgs.ContentNew}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentNew" value="#{entry.contentNew}" disabled="true" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentRead}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentRead" value="#{entry.contentRead}" disabled="true"/>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentReviseAny}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentReviseAny" value="#{entry.contentReviseAny}" disabled="true"/>
					</h:column>					
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentReviseOwn}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentReviseOwn" value="#{entry.contentReviseOwn}" disabled="true"/>
					</h:column>							
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentDeleteAny}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentDeleteAny" value="#{entry.contentDeleteAny}" disabled="true"/>
					</h:column>												
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentDeleteOwn}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentDeleteOwn" value="#{entry.contentDeleteOwn}" disabled="true"/>
					</h:column>						
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentAllGroups}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentAllGroups" value="#{entry.contentAllGroups}" disabled="true"/>
					</h:column>	
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentHidden}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentHidden" value="#{entry.contentHidden}" disabled="true"/>
					</h:column>						
				</t:dataTable>
				<!-- zml add Content end -->	

			 </h:form>
  		</sakai:view_content>	
	</sakai:view_container>
</f:view> 