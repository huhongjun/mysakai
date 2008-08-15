package org.sakaiproject.birt.tool.jsf;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.faces.model.SelectItem;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.component.cover.ServerConfigurationService;
import org.sakaiproject.tool.api.Placement;
import org.sakaiproject.tool.cover.ToolManager;

public class ReportListBean {

	// use commons logger
	private static Log LOG = LogFactory.getLog(ReportListBean.class);

	private Map<String, String> reportList = null;
	private String selectedReport;
	private String siteId;
	
	// Constructor
	public ReportListBean()
	{
		
	}
	
	public String getSelectedReport() {
		return selectedReport;
	}
	
	public void setSelectedReport(String selectedReport) {
		this.selectedReport = selectedReport;
	}
	
	public String getBIRTUrl() {	
		String reportUrl = ServerConfigurationService.getString("reportUrl","http://localhost:9080/birtviewer/");
		
		return reportUrl = reportUrl+"run";
	}
	
	public String getSiteId(){
		Placement pm = ToolManager.getCurrentPlacement();
		String courseId = pm.getContext();
		return courseId;
	}
	public Map<String, String> getReportList() {

//        String report1Name = ServerConfigurationService.getString("report1.name");
//        String report1Label = ServerConfigurationService.getString("report1.label");
//        String report2Name = ServerConfigurationService.getString("report2.name");
//        String report2Label = ServerConfigurationService.getString("report2.label");
//
//        reportList = new ArrayList<SelectItem>();
//        reportList.add(new SelectItem("report/JforumTopics80.rptdesign", "Report-80"));
//        reportList.add(new SelectItem("report/JforumTopics.rptdesign", "Report-zhjedu"));
        
		return reportList;
	}

	/**
	 * @param reportList the reportList to set
	 */
	public void setReportList(Map<String, String> reportList) {
		this.reportList = reportList;
	}

	public String processReportChanged() {
		String reportUrl = this.getBIRTUrl() +"?__report=" + this.getSelectedReport() + "&courseid=" + this.getSiteId();
		FacesContext facesContext = FacesContext.getCurrentInstance();
		facesContext.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO,"选中报表："+reportUrl, "processReset方法" ) );
		
		return "main";
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}	
}
