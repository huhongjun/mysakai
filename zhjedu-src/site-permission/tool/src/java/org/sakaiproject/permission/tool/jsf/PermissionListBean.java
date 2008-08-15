/**********************************************************************************
 *
 * Copyright (c) 2003, 2004, 2005, 2006 The Sakai Foundation.
 * 
 * Licensed under the Educational Community License, Version 1.0 (the "License"); 
 * you may not use this file except in compliance with the License. 
 * You may obtain a copy of the License at
 * 
 *      http://www.opensource.org/licenses/ecl1.php
 * 
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, 
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 * See the License for the specific language governing permissions and 
 * limitations under the License.
 *
 **********************************************************************************/

package org.sakaiproject.permission.tool.jsf;

import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Set;

import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.authz.api.AuthzGroup;
import org.sakaiproject.authz.api.AuthzPermissionException;
import org.sakaiproject.authz.api.GroupNotDefinedException;
import org.sakaiproject.authz.api.Role;
import org.sakaiproject.authz.cover.AuthzGroupService;
import org.sakaiproject.permission.tool.model.PermissionWrapper;
import org.sakaiproject.site.api.Site;
import org.sakaiproject.site.cover.SiteService;
import org.sakaiproject.tool.api.Placement;
import org.sakaiproject.tool.cover.ToolManager;


import org.sakaiproject.tool.api.Session;
import org.sakaiproject.tool.api.ToolSession;
import org.sakaiproject.tool.cover.SessionManager;

public class PermissionListBean {
	
	// permission functions
	private org.sakaiproject.authz.api.SecurityService securityService;
	
    //zml add others Permission start
	//permission functions ------Announcement
	public static String	FUNCTION_ANNOUNCEMENT_READ		    = "annc.read";
	public static String	FUNCTION_ANNOUNCEMENT_NEW		    = "annc.new";
	public static String	FUNCTION_ANNOUNCEMENT_DELETEANY		= "annc.delete.any"; 
	public static String	FUNCTION_ANNOUNCEMENT_REVISEANY		= "annc.revise.any";
	public static String	FUNCTION_ANNOUNCEMENT_ALLGROUPS  	= "annc.all.groups";
	public static String	FUNCTION_ANNOUNCEMENT_READDRAFTS	= "annc.read.drafts";  
	//permission functions ------Calendar
	public static String	FUNCTION_CALENDAR_NEW		    = "calendar.new";
	public static String	FUNCTION_CALENDAR_DELETEOWN		= "calendar.delete.own";
	public static String	FUNCTION_CALENDAR_DELETEANY		= "calendar.delete.any"; 
	public static String	FUNCTION_CALENDAR_REVISEOWN		= "calendar.revise.own";
	public static String	FUNCTION_CALENDAR_REVISEANY		= "calendar.revise.any";
	public static String	FUNCTION_CALENDAR_IMPORT    	= "calendar.import";  
	public static String	FUNCTION_CALENDAR_READ		    = "calendar.read";
	public static String	FUNCTION_CALENDAR_ALLGROUPS  	= "calendar.all.groups";
	//permission functions ------Content
	public static String	FUNCTION_CONTENT_NEW		    = "content.new";
	public static String	FUNCTION_CONTENT_READ		    = "content.read";
	public static String	FUNCTION_CONTENT_REVISEANY		= "content.revise.any";
	public static String	FUNCTION_CONTENT_REVISEOWN		= "content.revise.own";
	public static String	FUNCTION_CONTENT_DELETEANY		= "content.delete.any"; 
	public static String	FUNCTION_CONTENT_DELETEOWN		= "content.delete.own";
	public static String	FUNCTION_CONTENT_ALLGROUPS  	= "content.all.groups";
	public static String	FUNCTION_CONTENT_HIDDEN     	= "content.hidden";  
	//zml add others Permission end

	// use commons logger
	private static Log log = LogFactory.getLog(PermissionListBean.class);

	private DataModel permsModelTaskList;

	// Constructor
	public PermissionListBean() 
	{

	}

	public DataModel getAllPermissions() {
		Collection wrappedPerms = new LinkedList();
		AuthzGroup group;
		try{
			group = AuthzGroupService.getAuthzGroup(SiteService.siteReference(getSiteId()));
			Set roles = group.getRoles();
			Iterator i = roles.iterator();
			while (i.hasNext()) {
				Role role = (Role)i.next();
				wrappedPerms.add(new PermissionWrapper(
						role, 
						//zml add Announcement
						role.isAllowed(FUNCTION_ANNOUNCEMENT_READ),
						role.isAllowed(FUNCTION_ANNOUNCEMENT_NEW),
						role.isAllowed(FUNCTION_ANNOUNCEMENT_DELETEANY),
						role.isAllowed(FUNCTION_ANNOUNCEMENT_REVISEANY),
						role.isAllowed(FUNCTION_ANNOUNCEMENT_ALLGROUPS),
						role.isAllowed(FUNCTION_ANNOUNCEMENT_READDRAFTS),
						//zml add Calendar
						role.isAllowed(FUNCTION_CALENDAR_NEW),
						role.isAllowed(FUNCTION_CALENDAR_DELETEOWN),
						role.isAllowed(FUNCTION_CALENDAR_DELETEANY),
						role.isAllowed(FUNCTION_CALENDAR_REVISEOWN),
						role.isAllowed(FUNCTION_CALENDAR_REVISEANY),
						role.isAllowed(FUNCTION_CALENDAR_IMPORT),
						role.isAllowed(FUNCTION_CALENDAR_READ),
						role.isAllowed(FUNCTION_CALENDAR_ALLGROUPS),
						//zml add Content
						role.isAllowed(FUNCTION_CONTENT_NEW),
						role.isAllowed(FUNCTION_CONTENT_READ),
						role.isAllowed(FUNCTION_CONTENT_REVISEANY),
						role.isAllowed(FUNCTION_CONTENT_REVISEOWN),
						role.isAllowed(FUNCTION_CONTENT_DELETEANY),
						role.isAllowed(FUNCTION_CONTENT_DELETEOWN),
						role.isAllowed(FUNCTION_CONTENT_ALLGROUPS),
						role.isAllowed(FUNCTION_CONTENT_HIDDEN)
				));
			}
		}catch(GroupNotDefinedException e){
			e.printStackTrace();
		}
		
		permsModelTaskList = new ListDataModel();
		permsModelTaskList.setWrappedData(wrappedPerms);
		
		return permsModelTaskList;
	}

	public String processActionSavePermissions() {
		if(permsModelTaskList != null){
			Collection perms = (Collection) permsModelTaskList.getWrappedData();
			boolean ret = applyTaskListPermissions(perms);
			if(ret == true){
				return "SuccessReturn";
			}else{
				return "SuccessReturn";
			}
		}
		return "SuccessReturn";
	}
	
//	zml add start
	public boolean applyTaskListPermissions(Collection perms){
		return applyPermissions(perms, new String[]{
				//zml add Announcement
				FUNCTION_ANNOUNCEMENT_READ,
				FUNCTION_ANNOUNCEMENT_NEW,
				FUNCTION_ANNOUNCEMENT_DELETEANY,
				FUNCTION_ANNOUNCEMENT_REVISEANY,
				FUNCTION_ANNOUNCEMENT_ALLGROUPS,
				FUNCTION_ANNOUNCEMENT_READDRAFTS,
				//zml add Calendar
				FUNCTION_CALENDAR_NEW,
				FUNCTION_CALENDAR_DELETEOWN,
				FUNCTION_CALENDAR_DELETEANY,
				FUNCTION_CALENDAR_REVISEOWN,
				FUNCTION_CALENDAR_REVISEANY,
				FUNCTION_CALENDAR_IMPORT,
				FUNCTION_CALENDAR_READ,
				FUNCTION_CALENDAR_ALLGROUPS,
				//zml add Content
				FUNCTION_CONTENT_NEW,
				FUNCTION_CONTENT_READ,
				FUNCTION_CONTENT_REVISEANY,
				FUNCTION_CONTENT_REVISEOWN,
				FUNCTION_CONTENT_DELETEANY,
				FUNCTION_CONTENT_DELETEOWN,
				FUNCTION_CONTENT_ALLGROUPS,
				FUNCTION_CONTENT_HIDDEN
				});
	}
	

	private boolean applyPermissions(Collection perms, String[] functions){
		AuthzGroup group = null;
		try{
//			Session session = SessionManager.getCurrentSession();
//			// get the Tool session
//			ToolSession toolSession = SessionManager.getCurrentToolSession();
//			// get the Tool
//			Placement placement = ToolManager.getCurrentPlacement();			
//			String toolids = placement.getToolId();
//			org.sakaiproject.site.api.SiteService siteService = SiteService.getInstance();
//			Site site = null;
//			try {
//				site = siteService.getSite(placement.getContext());
//			} catch (Exception e) {
//				// assume we are not in a site then and do something about it
//			}
//			String siteid = site.getId();
//			group = AuthzGroupService.getAuthzGroup(SiteService.siteReference(siteid));
		group = AuthzGroupService.getAuthzGroup(SiteService.siteReference(getSiteId()));
		
		PermissionWrapper p = null;
		Iterator iter = perms.iterator();		
		while(iter.hasNext()) {
			p = (PermissionWrapper) iter.next();
			Role r = group.getRole(p.getRole().getId());
			// zml add Announcement
			setFunction(r, functions[0], p.getAnnouncementRead());
			setFunction(r, functions[1], p.getAnnouncementNew());
			setFunction(r, functions[2], p.getAnnouncementDeleteAny());
			setFunction(r, functions[3], p.getAnnouncementReviseAny());
			setFunction(r, functions[4], p.getAnnouncementAllGroups());
			setFunction(r, functions[5], p.getAnnouncementReadDrafts());
			// zml add Calendar
			setFunction(r, functions[6], p.getCalendarNew());
			setFunction(r, functions[7], p.getCalendarDeleteOwn());
			setFunction(r, functions[8], p.getCalendarDeleteAny());
			setFunction(r, functions[9], p.getCalendarReviseOwn());
			setFunction(r, functions[10], p.getCalendarReviseAny());
			setFunction(r, functions[11], p.getCalendarImport());
			setFunction(r, functions[12], p.getCalendarRead());
			setFunction(r, functions[13], p.getCalendarAllGroups());
			// zml add Content
			setFunction(r, functions[14], p.getContentNew());
			setFunction(r, functions[15], p.getContentRead());
			setFunction(r, functions[16], p.getContentReviseAny());
			setFunction(r, functions[17], p.getContentReviseOwn());
			setFunction(r, functions[18], p.getContentDeleteAny());
			setFunction(r, functions[19], p.getContentDeleteOwn());
			setFunction(r, functions[20], p.getContentAllGroups());
			setFunction(r, functions[21], p.getContentHidden());
		}
		}catch(GroupNotDefinedException e){
			e.printStackTrace();
		}
		try{
			AuthzGroupService.save(group);
		}catch(GroupNotDefinedException e){
			log.error("Group not defined", e);
			return false;
		}catch(AuthzPermissionException e){
			log.error("Permission exception", e);
			return false;
		}
		return true;
	}
	private void setFunction(Role role, String function, boolean allow) {
		if (allow)
			role.allowFunction(function);
		else
			role.disallowFunction(function);
	} 
	//zml add end
	public String processActionCancel() {
		return "PermissionsViewAll";
	}
	
	
	// Common methods
	public String getSiteId() {
		
		String siteId = ToolManager.getCurrentPlacement().getContext();
		return siteId;
	}
	
	public boolean getSiteOwner() {
		return securityService.unlock(SiteService.SECURE_UPDATE_SITE, SiteService.siteReference(this.getSiteId()));
		
	}

	public org.sakaiproject.authz.api.SecurityService getSecurityService() {
		return securityService;
	}

	public void setSecurityService(
			org.sakaiproject.authz.api.SecurityService securityService) {
		this.securityService = securityService;
	}	
}
