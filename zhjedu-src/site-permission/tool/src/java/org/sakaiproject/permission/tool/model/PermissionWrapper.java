package org.sakaiproject.permission.tool.model;

import org.sakaiproject.authz.api.Role;
import org.sakaiproject.site.api.SiteService;

public class PermissionWrapper {
	private Role role;

	//zml add Announcement
	private boolean announcementRead;
	private boolean announcementNew;
	private boolean announcementDeleteAny;
	private boolean announcementReviseAny;
	private boolean announcementAllGroups;
	private boolean announcementReadDrafts;

	//zml add Calendar
	private boolean calendarNew;
	private boolean calendarDeleteOwn;
	private boolean calendarDeleteAny;
	private boolean calendarReviseOwn;
	private boolean calendarReviseAny;
	private boolean calendarImport;
	private boolean calendarRead;
	private boolean calendarAllGroups;

	//zml add Content
	private boolean contentNew;
	private boolean contentRead;
	private boolean contentReviseAny;
	private boolean contentReviseOwn;
	private boolean contentDeleteAny;
	private boolean contentDeleteOwn;
	private boolean contentAllGroups;
	private boolean contentHidden;


	public PermissionWrapper(Role role, 
            boolean canAnnRead, boolean canAnnNew,
            boolean canAnnDeleteAny, boolean canAnnReviseAny,
            boolean canAnnAllGroups, boolean canAnnReadDrafts,
            boolean canCalNew, boolean canCalDeleteOwn,
            boolean canCalDeleteAny, boolean canCalReviseOwn,
            boolean canCalReviseAny, boolean canCalImport,
            boolean canCalRead, boolean canCalAllGroups,
            boolean canConNew, boolean canConRead,
            boolean canConReviseAny, boolean canConReviseOwn,
            boolean canConDeleteAny, boolean canConDeleteOwn,
            boolean canConAllGroups, boolean canConHidden) 
	{
		this.role = role;

		//zml add Announcement
		this.announcementRead = canAnnRead;
		this.announcementNew = canAnnNew;
		this.announcementDeleteAny = canAnnDeleteAny;
		this.announcementReviseAny = canAnnReviseAny;
		this.announcementAllGroups = canAnnAllGroups;
		this.announcementReadDrafts = canAnnReadDrafts;
		//zml add Calendar
		this.calendarNew = canCalNew;
		this.calendarDeleteOwn = canCalDeleteOwn;
        this.calendarDeleteAny = canCalDeleteAny;
        this.calendarReviseOwn = canCalReviseOwn;
        this.calendarReviseAny = canCalReviseAny;
        this.calendarImport = canCalImport;
        this.calendarRead = canCalRead;
        this.calendarAllGroups = canCalAllGroups;
        //zml add Content
        this.contentNew = canConNew;
        this.contentRead = canConRead;
        this.contentReviseAny = canConReviseAny;
        this.contentReviseOwn = canConReviseOwn;
        this.contentDeleteAny = canConDeleteAny;
        this.contentDeleteOwn = canConDeleteOwn;
        this.contentAllGroups = canConAllGroups;
        this.contentHidden = canConHidden;		
	}

	public boolean getSiteUpd() {
		return role.isAllowed(SiteService.SECURE_UPDATE_SITE);
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public boolean getAnnouncementRead() {
		return announcementRead;
	}

	public void setAnnouncementRead(boolean announcementRead) {
		this.announcementRead = announcementRead;
	}

	public boolean getAnnouncementNew() {
		return announcementNew;
	}

	public void setAnnouncementNew(boolean announcementNew) {
		this.announcementNew = announcementNew;
	}

	public boolean getAnnouncementDeleteAny() {
		return announcementDeleteAny;
	}

	public void setAnnouncementDeleteAny(boolean announcementDeleteAny) {
		this.announcementDeleteAny = announcementDeleteAny;
	}

	public boolean getAnnouncementReviseAny() {
		return announcementReviseAny;
	}

	public void setAnnouncementReviseAny(boolean announcementReviseAny) {
		this.announcementReviseAny = announcementReviseAny;
	}

	public boolean getAnnouncementAllGroups() {
		return announcementAllGroups;
	}

	public void setAnnouncementAllGroups(boolean announcementAllGroups) {
		this.announcementAllGroups = announcementAllGroups;
	}

	public boolean getAnnouncementReadDrafts() {
		return announcementReadDrafts;
	}

	public void setAnnouncementReadDrafts(boolean announcementReadDrafts) {
		this.announcementReadDrafts = announcementReadDrafts;
	}

	public boolean getCalendarNew() {
		return calendarNew;
	}

	public void setCalendarNew(boolean calendarNew) {
		this.calendarNew = calendarNew;
	}

	public boolean getCalendarDeleteOwn() {
		return calendarDeleteOwn;
	}

	public void setCalendarDeleteOwn(boolean calendarDeleteOwn) {
		this.calendarDeleteOwn = calendarDeleteOwn;
	}

	public boolean getCalendarDeleteAny() {
		return calendarDeleteAny;
	}

	public void setCalendarDeleteAny(boolean calendarDeleteAny) {
		this.calendarDeleteAny = calendarDeleteAny;
	}

	public boolean getCalendarReviseOwn() {
		return calendarReviseOwn;
	}

	public void setCalendarReviseOwn(boolean calendarReviseOwn) {
		this.calendarReviseOwn = calendarReviseOwn;
	}

	public boolean getCalendarReviseAny() {
		return calendarReviseAny;
	}

	public void setCalendarReviseAny(boolean calendarReviseAny) {
		this.calendarReviseAny = calendarReviseAny;
	}

	public boolean getCalendarImport() {
		return calendarImport;
	}

	public void setCalendarImport(boolean calendarImport) {
		this.calendarImport = calendarImport;
	}

	public boolean getCalendarRead() {
		return calendarRead;
	}

	public void setCalendarRead(boolean calendarRead) {
		this.calendarRead = calendarRead;
	}

	public boolean getCalendarAllGroups() {
		return calendarAllGroups;
	}

	public void setCalendarAllGroups(boolean calendarAllGroups) {
		this.calendarAllGroups = calendarAllGroups;
	}

	public boolean getContentNew() {
		return contentNew;
	}

	public void setContentNew(boolean contentNew) {
		this.contentNew = contentNew;
	}

	public boolean getContentRead() {
		return contentRead;
	}

	public void setContentRead(boolean contentRead) {
		this.contentRead = contentRead;
	}

	public boolean getContentReviseAny() {
		return contentReviseAny;
	}

	public void setContentReviseAny(boolean contentReviseAny) {
		this.contentReviseAny = contentReviseAny;
	}

	public boolean getContentReviseOwn() {
		return contentReviseOwn;
	}

	public void setContentReviseOwn(boolean contentReviseOwn) {
		this.contentReviseOwn = contentReviseOwn;
	}

	public boolean getContentDeleteAny() {
		return contentDeleteAny;
	}

	public void setContentDeleteAny(boolean contentDeleteAny) {
		this.contentDeleteAny = contentDeleteAny;
	}

	public boolean getContentDeleteOwn() {
		return contentDeleteOwn;
	}

	public void setContentDeleteOwn(boolean contentDeleteOwn) {
		this.contentDeleteOwn = contentDeleteOwn;
	}

	public boolean getContentAllGroups() {
		return contentAllGroups;
	}

	public void setContentAllGroups(boolean contentAllGroups) {
		this.contentAllGroups = contentAllGroups;
	}

	public boolean getContentHidden() {
		return contentHidden;
	}

	public void setContentHidden(boolean contentHidden) {
		this.contentHidden = contentHidden;
	}


}
