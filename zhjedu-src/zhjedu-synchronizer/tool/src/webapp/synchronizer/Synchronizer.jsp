<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<jsp:useBean id="msgs" class="org.sakaiproject.util.ResourceLoader" scope="session">
   <jsp:setProperty name="msgs" property="baseName" value="org.sakaiproject.tool.synchronizer.bundle.Messages"/>
</jsp:useBean>
 
<f:view>
	
	<sakai:view_container title="#{msgs.title}">
		<style type="text/css">
			@import url("/sakai-synchronizer-tool/css/Synchronizer.css");
		</style>

		<sakai:view_content>
			<h:form id="perms">

			 	<sakai:view_title value="#{msgs.title}"/>
	
				<f:subview id="msg">
					<h:message for="msg" infoClass="success" fatalClass="alertMessage" style="margin-top: 15px;" showDetail="true"/>
				</f:subview>

				<t:dataTable id="courseList" 
					value="#{SynchronizerBean.allCourses}"
					var="entry"
					headerClass="headerAlignment" 
					styleClass="listHier">
				
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.courseid}" />
						</f:facet>
						<h:outputText value="#{entry.courseId}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.coursename}" />
						</f:facet>
						<h:outputText value="#{entry.courseName}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:outputText value="#{msgs.institutionid}" />
						</f:facet>
						<h:outputText value="#{entry.midInstitutionId}" />
					</h:column>
				</t:dataTable>
				
				<sakai:button_bar>
					<sakai:button_bar_item id="CreateDemoSite"
						action="#{SynchronizerBean.processActionCreateDemoSite}"
						value="#{msgs.CreateDemoSite}"/>
					<sakai:button_bar_item id="DeleteDemoSite"
						action="#{SynchronizerBean.processActionDeleteDemoSite}"
						value="#{msgs.DeleteDemoSite}"/>
					<sakai:button_bar_item id="SynchronizeZ"
						action="#{SynchronizerBean.processActionSynchronizer}"
						value="#{msgs.Synchronize}"
						styleClass="active"/>
				</sakai:button_bar>
			    
			 </h:form>
  		</sakai:view_content>	
	</sakai:view_container>
</f:view> 