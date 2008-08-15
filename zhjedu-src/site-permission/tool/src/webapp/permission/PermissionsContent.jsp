<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
   <jsp:setProperty name="msgs" property="baseName" value="org.sakaiproject.tool.permission.bundle.Messages"/>
</jsp:useBean>
 
<f:view>
	
	<sakai:view_container title="#{msgs.permissionsContent}">
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
			 	<sakai:view_title value="#{msgs.permissions_title} - #{msgs.permissionsContent}"/>
	
				<f:subview id="msg">
					<h:message for="msg" infoClass="success" fatalClass="alertMessage" style="margin-top: 15px;" showDetail="true"/>
				</f:subview>
						
				<!-- zml add Announcement start -->
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
						<h:selectBooleanCheckbox id="contentNew" value="#{entry.contentNew}"/>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentRead}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentRead" value="#{entry.contentRead}"/>
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentReviseAny}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentReviseAny" value="#{entry.contentReviseAny}"/>
					</h:column>					
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentReviseOwn}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentReviseOwn" value="#{entry.contentReviseOwn}"/>
					</h:column>							
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentDeleteAny}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentDeleteAny" value="#{entry.contentDeleteAny}" />
					</h:column>												
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentDeleteOwn}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentDeleteOwn" value="#{entry.contentDeleteOwn}"/>
					</h:column>						
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentAllGroups}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentAllGroups" value="#{entry.contentAllGroups}"/>
					</h:column>	
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.ContentHidden}" />
						</f:facet>
						<h:selectBooleanCheckbox id="contentHidden" value="#{entry.contentHidden}"/>
					</h:column>							
				</t:dataTable>
				<!-- zml add Announcement end -->	
				
				<sakai:button_bar>
					<sakai:button_bar_item id="save"
						action="#{PermissionListBean.processActionSavePermissions}"
						value="#{msgs.permissions_save}"
                		styleClass="active"/>
					<sakai:button_bar_item id="cancel"
						action="PermissionsContent"
						value="#{msgs.permissions_cancel}"/>
				</sakai:button_bar>
			    

			 </h:form>
  		</sakai:view_content>	
	</sakai:view_container>
</f:view> 