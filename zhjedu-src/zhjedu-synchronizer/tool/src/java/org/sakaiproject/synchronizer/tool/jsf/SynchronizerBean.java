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

package org.sakaiproject.synchronizer.tool.jsf;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

import junit.framework.Assert;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.authz.api.AuthzGroup;
import org.sakaiproject.authz.api.AuthzPermissionException;
import org.sakaiproject.authz.api.GroupNotDefinedException;
import org.sakaiproject.authz.api.Role;
import org.sakaiproject.authz.cover.AuthzGroupService;
import org.sakaiproject.component.cover.ComponentManager;
import org.sakaiproject.component.cover.ServerConfigurationService;
import org.sakaiproject.coursemanagement.api.CourseManagementAdministration;
import org.sakaiproject.entity.api.ResourcePropertiesEdit;
import org.sakaiproject.exception.IdUnusedException;
import org.sakaiproject.exception.PermissionException;
import org.sakaiproject.site.api.Site;
import org.sakaiproject.site.api.SitePage;
import org.sakaiproject.site.api.Group;
import org.sakaiproject.site.api.ToolConfiguration;
import org.sakaiproject.site.cover.SiteService;
import org.sakaiproject.tool.api.Session;
import org.sakaiproject.tool.api.Tool;
import org.sakaiproject.tool.cover.ToolManager;
import org.sakaiproject.user.api.User;
import org.sakaiproject.user.api.UserNotDefinedException;

import com.main.BaseMain;
import com.model.CourseModel;
import com.model.StudentModel;
import com.model.TeacherModel;

public class SynchronizerBean {

	// Names of state attributes corresponding to properties of a site
	private final static String PROP_SITE_CONTACT_EMAIL = "contact-email";
	private final static String PROP_SITE_CONTACT_NAME 	= "contact-name1";
	private final static String PROP_SITE_TERM 			= "term";
	private final static String PROP_SITE_TERM_EID 		= "term_eid";

	// use commons logger
	private static Log log = LogFactory.getLog(SynchronizerBean.class);
	private DataModel courseModel;

	// huhj for create site
	private org.sakaiproject.site.api.SiteService 			siteService;
	private org.sakaiproject.user.api.UserDirectoryService 	uds;
	private Site site;
	private List<CourseModel> courseList;
	private BaseMain base;
	private Map<String,String> toolsMap;
	
	// Constructor
	public SynchronizerBean() {
		base = new BaseMain();	
		courseList = base.getCourseManager1().getAllCourses();
	}

	public DataModel getAllCourses() {

		courseModel = new ListDataModel();
		courseModel.setWrappedData(courseList);
		
		return courseModel;
	}

	private Site createSakaiSite(String siteId, String siteType, String title) throws Exception
	{
		// Connect to the required services
		siteService = org.sakaiproject.site.cover.SiteService.getInstance();
		
		// Create a site
		site = siteService.addSite(siteId, siteType);

		site.setTitle(title);
		site.setShortDescription("");
		site.setPubView(true);
		site.setJoinable(true);
		site.setJoinerRole("Student");
		site.setPublished(true);
		
		// 给课程加属性： section属性（不从外部同步）
		ResourcePropertiesEdit rp = site.getPropertiesEdit();
		// site contact information
		rp.addProperty(PROP_SITE_CONTACT_NAME, "知金教务");
		rp.addProperty(PROP_SITE_CONTACT_EMAIL, "zhj@zhjedu.com");	
		rp.addProperty(PROP_SITE_TERM, "zhj-08");	
		rp.addProperty("sections_externally_maintained", "false");	
		
		// 给课程加页面和工具
		
//		addPageAndTool(site, "sakai.siteinfo", "课程信息");
//		addPageAndTool(site, "sakai.schedule", "日程管理");
//		addPageAndTool(site, "sakai.resources", "课程资源");
//		addPageAndTool(site, "sakai.melete", "课程章节");
//		addPageAndTool(site, "sakai.syllabus", "课程大纲");
//		addPageAndTool(site, "sakai.announcements", "课程公告");
//		addPageAndTool(site, "sakai.rwiki", "课程笔记");
//		addPageAndTool(site, "sakai.permission", "助教管理");		
//		addPageAndTool(site, "sakai.jforum.tool", "课程论坛");
//		addPageAndTool(site, "sakai.mailtool", "邮件工具");
		
		Set<Map.Entry<String, String>> meSet = toolsMap.entrySet();
		for(Map.Entry<String, String> me:meSet){
			addPageAndTool(site, me.getKey(), me.getValue());
		}
		
		// 给课程加课程主页
		SitePage page;

		page = site.addPage();	page.setTitle("课程主页");	page.setLayout(1);	//0-单列；1-双列
		addSynopticTool(page, "sakai.iframe.site", "课程介绍", "0,0");			//行，列   计数从0起	
		addSynopticTool(page, "sakai.iframe.myworkspace", "我的课程", "1,0");		
		addSynopticTool(page, "sakai.synoptic.announcement", "我的公告", "0,1");
		addSynopticTool(page, "sakai.summary.calendar", "日历", "1,1");	
		
		siteService.save(site);
			
		return site;
	}

	public String processActionSynchronizer() throws IdUnusedException, PermissionException, GroupNotDefinedException, AuthzPermissionException
	{
		// Connect to the required services
		siteService = org.sakaiproject.site.cover.SiteService.getInstance();
		uds = org.sakaiproject.user.cover.UserDirectoryService.getInstance();

		Session session = org.sakaiproject.tool.cover.SessionManager.getCurrentSession();
		session.setUserId("admin");
		session.setUserEid("admin");		

		// 课程循环
		boolean isNewSite = false;
		for(CourseModel cm:courseList){
			int courseId = cm.getCourseId();
			String siteId = String.valueOf(courseId);
			String courseName = cm.getCourseName();
			System.out.println("======>课程："+courseId+courseName);

			// 查询Sakai中是否有该门课程[course_id]
			try {
				site = siteService.getSite(siteId);
			} catch (IdUnusedException e) {
				// 需新增课程
				isNewSite = true;
			}
			
			if (isNewSite) {		//A. 如果Sakai中课程不存在
				
				// A-1、新增课程
				System.out.println("A-新增课程："+courseId+courseName);		
				try {
					site = this.createSakaiSite(siteId, "course", courseName);
					// 给课程加Web Content页面(课件查看)
					SitePage page;
					ToolConfiguration tool;					
					page = site.addPage();					page.setTitle("课件播放");
					tool = page.addTool("sakai.iframe");	tool.setTitle("课件播放");
					tool.getPlacementConfig().setProperty("source", cm.getUrl() );					
				} catch (Exception e) {
					// 
					e.printStackTrace();
				}
				
				// A-2、为本门课程增加成员
				// A-2.1 增加课程成员中的教师
				List<TeacherModel> teacherList = base.getCourseManager2().getTeacherOfCourse(courseId);
				for(TeacherModel tm:teacherList){
					String teacherName = tm.getRealName();
					int teacherId = tm.getTeacherId();
					int teacherType = tm.getTeacherType();
					String userEId = String.valueOf(teacherId);
					
					//  新增教师
					try {
						String userId = uds.getUserId(userEId);
						// TODO: 需判断是助教还是教师
						if(teacherType == 0){
							site.addMember(userId, "Teaching Assistant", true, false);													
							System.out.println("A-新增助教：" + teacherId + teacherName + "=>" + userId);
						}else{
							site.addMember(userId, "Instructor", true, false);													
							System.out.println("A-新增教师：" + teacherId + teacherName + "=>" + userId);
						}

					} catch (UserNotDefinedException e) {
						// 
						System.out.println("A-没有教师：" + teacherId + teacherName);
					}
					
				}
				// A-2.2 增加课程成员中的学生
				List<StudentModel> studentList = base.getCourseManager3().getStudentOfCourse(courseId);
				for(StudentModel stu:studentList){
					String studentName = stu.getRealName();
					int studentId = stu.getStudentId();
					String userEId = String.valueOf(studentId);					
					// TODO: 新增学生	
					try {
						String userId = uds.getUserId(userEId);
						site.addMember(userId, "Student", true, false);
						System.out.println("A-新增学生：" + studentId + studentName + "=>" + userId);						
					} catch (UserNotDefinedException e) {
						// TODO Auto-generated catch block
						System.out.println("A-没有学生：" + studentId + studentName);					}
				}
				
				siteService.save(site);		// Save the site and its new member	
				
				//Role 的描述修改
				String siteRef = site.getReference();	
				AuthzGroup azg = AuthzGroupService.getAuthzGroup(siteRef);
				Role role = azg.getRole("Student");			role.setDescription("学生");
				role = azg.getRole("Instructor");			role.setDescription("教师");
				role = azg.getRole("Teaching Assistant");	role.setDescription("助教");
				
				AuthzGroupService.save(azg);
				
			}else{						//B. 如果Sakai中课程已存在
				
				// B-2、为本门课程增加成员
				// B-2.1 增加课程成员中的教师
				List<TeacherModel> teacherList = base.getCourseManager2().getTeacherOfCourse(courseId);
				for(TeacherModel tm:teacherList){
					String teacherName = tm.getRealName();
					int teacherId = tm.getTeacherId();
					int teacherType = tm.getTeacherType();
					String userEId = String.valueOf(teacherId);
					
					//  新增教师
					try {
						String userId = uds.getUserId(userEId);
						// TODO: 需判断是助教还是教师
						if(teacherType == 0){
							site.addMember(userId, "Teaching Assistant", true, false);													
							System.out.println("B-新增助教：" + teacherId + teacherName + "=>" + userId);
						}else{
							site.addMember(userId, "Instructor", true, false);													
							System.out.println("B-新增教师：" + teacherId + teacherName + "=>" + userId);
						}
					} catch (UserNotDefinedException e) {
						// 
						System.out.println("A-没有教师：" + teacherId + teacherName);
					}					

				}
				// B-2.2 增加课程成员中的学生
				List<StudentModel> studentList = base.getCourseManager3().getStudentOfCourse(courseId);
				for(StudentModel stu:studentList){
					String studentName = stu.getRealName();
					int studentId = stu.getStudentId();
					String userEId = String.valueOf(studentId);					
					// TODO: 新增学生	
					try {
						String userId = uds.getUserId(userEId);
						site.addMember(userId, "Student", true, false);
						System.out.println("B-新增学生：" + studentId + studentName + "=>" + userId);						
					} catch (UserNotDefinedException e) {
						// TODO Auto-generated catch block
						System.out.println("B-没有学生：" + studentId + studentName);					}
				}
				
				siteService.save(site);		// Save the site and its new member	
			}
		}		
		
		return "index";
	}

	public String processActionCreateDemoSite() throws Exception
	{
		// Connect to the required services
		siteService = org.sakaiproject.site.cover.SiteService.getInstance();
		
		// Log in
		Session session = org.sakaiproject.tool.cover.SessionManager.getCurrentSession();
		session.setUserId("admin");
		session.setUserEid("admin");
		
		// Create a site
		site = siteService.addSite("CM-36idea", "course");

		site.setTitle("三十六计");
		site.setShortDescription("");
		site.setPubView(true);
		site.setJoinable(true);
		site.setJoinerRole("Student");
		site.setPublished(true);
		
		// 给课程加属性： section属性（不从外部同步）
		ResourcePropertiesEdit rp = site.getPropertiesEdit();
		// site contact information
		rp.addProperty(PROP_SITE_CONTACT_NAME, "");
		rp.addProperty(PROP_SITE_CONTACT_EMAIL, "");	
		
		// 给课程加页面和工具
		SitePage page = site.addPage();		page.setTitle("课程信息");
		ToolConfiguration tool = page.addTool("sakai.siteinfo");
		tool.setTitle("课程信息");
		
		page = site.addPage();					page.setTitle("日程管理");
		tool = page.addTool("sakai.schedule");	tool.setTitle("日程管理");		

		page = site.addPage();					page.setTitle("课程资源");
		tool = page.addTool("sakai.resources");	tool.setTitle("课程资源");		
		
		page = site.addPage();					page.setTitle("课程章节");
		tool = page.addTool("sakai.melete");	tool.setTitle("课程章节");		
		
		page = site.addPage();					page.setTitle("课程大纲");
		tool = page.addTool("sakai.syllabus");	tool.setTitle("课程大纲");		
		
		page = site.addPage();						page.setTitle("课程公告");
		tool = page.addTool("sakai.announcements");	tool.setTitle("课程公告");		
		page = site.addPage();					page.setTitle("课程笔记");
		tool = page.addTool("sakai.rwiki");		tool.setTitle("课程笔记");	
		
		page = site.addPage();								page.setTitle("课程介绍");
		tool = page.addTool("sakai.iframe.myworkspace");	tool.setTitle("课程介绍");		

		site.setPublished(true);
		siteService.save(site);
		
		// site member
		site.addMember("23094", "Student", true, true);
		site.addMember("28205", "Student", true, true);

		siteService.save(site);		// Save the site and its new member
		
		//Role 的描述修改
		String siteRef = site.getReference();	
		AuthzGroup azg = AuthzGroupService.getAuthzGroup(siteRef);
		azg.addMember("27768", "Student", true, true);
		Role role = azg.getRole("Student");			role.setDescription("学生");
		role = azg.getRole("Instructor");			role.setDescription("教师");
		role = azg.getRole("Teaching Assistant");	role.setDescription("助教");
		
		AuthzGroupService.save(azg);
		
		// 为站点建组
		Group group1 = site.addGroup();
		group1.setTitle("北京学习中心");
		siteService.save(site);

		// Add a user to a group
		group1.addMember("27768", "Student", true, true);
		// Save the group with its new member
		siteService.saveGroupMembership(site);
		
		return "index";
	}

	public String processActionDeleteDemoSite() throws Exception {
		log.debug("Tearing down an AuthzIntegrationTest test");

		// Connect to the required services
		siteService = org.sakaiproject.site.cover.SiteService.getInstance();
		
		// Log in
		Session session = org.sakaiproject.tool.cover.SessionManager.getCurrentSession();
		session.setUserId("admin");		

		site = siteService.getSite("CM-36idea");
		siteService.removeSite(site);
		
		return "index";
	}
	
	private void addSynopticTool(SitePage page, String toolId, String toolTitle, String layoutHint) {
		// Add synoptic tool
		ToolConfiguration tool = page.addTool();
		Tool reg = ToolManager.getTool(toolId);
		tool.setTool(toolId, reg);
		tool.setTitle(toolTitle);
		tool.setLayoutHints(layoutHint);
	}	
	
	private void addPageAndTool(Site site, String toolId, String toolTitle) {
		// 
		SitePage page = site.addPage();
		page.setTitle(toolTitle);
		ToolConfiguration tool = page.addTool(toolId);
		tool.setTitle(toolTitle);	
	}

	public Map<String, String> getToolsMap() {
		return toolsMap;
	}

	public void setToolsMap(Map<String, String> toolsMap) {
		this.toolsMap = toolsMap;
	}	
}
