<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" contentType="text/html; charset=utf-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://myfaces.apache.org/tomahawk" prefix="t"%>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<f:view>
	
	<sakai:view_container title="查询统计">

		<sakai:view_content>
			<h:messages></h:messages><br><h:outputText value="#{reportListBean.BIRTUrl}"></h:outputText>
			<h:panelGrid border="1" columns="2">
				<h:form id="myform">
					<h:outputLabel for="__report">
						<h:outputText value="选择要显示的报表："></h:outputText>
					</h:outputLabel>

					<h:selectOneMenu id="__report" style="width: 332px" value="#{reportListBean.selectedReport}" >
						<f:selectItems value="#{reportListBean.reportList}"/>
					</h:selectOneMenu>
					
					<h:inputHidden value="#{reportListBean.siteId}" id="courseid"></h:inputHidden>
					<h:commandButton type="submit" value="选中报表" action="#{reportListBean.processReportChanged}"></h:commandButton>
					<h:commandButton type="reset" value="查看报表" onclick="document.frames('reportframe').location = '#{reportListBean.BIRTUrl}?__report=#{reportListBean.selectedReport}&courseid=#{reportListBean.siteId}';return false;"></h:commandButton>
				</h:form>		
			</h:panelGrid>
			<iframe name="reportframe" width="100%" height="1000" src="#"></iframe>
  		</sakai:view_content>	
	</sakai:view_container>
</f:view> 