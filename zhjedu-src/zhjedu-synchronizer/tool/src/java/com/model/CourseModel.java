package com.model;

import java.util.HashSet;
import java.util.Set;

public class CourseModel {

	/** Course表的主键ID **/
	private int id;

	/** 版本 **/
	private int version;

	/** 知金库课程ID **/
	private int courseId;

	/** 课程编码 **/
	private String courseCode;

	/** 课程名称 **/
	private String courseName;

	/** 网院ID **/
	private int midInstitutionId;

	/** 入学批次ID **/
	private int midRecruitBatchId;

	/** 培养层次ID **/
	private int midStudyKindId;

	/** 专业ID **/
	private int midSubjectId;
	
	/** 课件的url */
	private String url;

	/** 教师集合 **/
	private Set TeacherModel = new HashSet(0);

	/** 学生集合 **/
	private Set StudentModel = new HashSet(0);

	/** default constructor */
	public CourseModel() {
	}

	/** full constructor */
	public CourseModel(int id, int version, int courseId, String courseCode,
			String courseName, int midInstitutionId, int midRecruitBatchId,
			int midStudyKindId, int midSubjectId, String url, Set TeacherModel,
			Set StudentModel) {
		this.id = id;
		this.version = version;
		this.courseId = courseId;
		this.courseCode = courseCode;
		this.courseName = courseName;
		this.midInstitutionId = midInstitutionId;
		this.midRecruitBatchId = midRecruitBatchId;
		this.midStudyKindId = midStudyKindId;
		this.midSubjectId = midSubjectId;
		this.url = url;
		this.TeacherModel = TeacherModel;
		this.StudentModel = StudentModel;
	}

	public String getCourseCode() {
		return courseCode;
	}

	public void setCourseCode(String courseCode) {
		this.courseCode = courseCode;
	}

	public int getCourseId() {
		return courseId;
	}

	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMidInstitutionId() {
		return midInstitutionId;
	}

	public void setMidInstitutionId(int midInstitutionId) {
		this.midInstitutionId = midInstitutionId;
	}

	public int getMidRecruitBatchId() {
		return midRecruitBatchId;
	}

	public void setMidRecruitBatchId(int midRecruitBatchId) {
		this.midRecruitBatchId = midRecruitBatchId;
	}

	public int getMidStudyKindId() {
		return midStudyKindId;
	}

	public void setMidStudyKindId(int midStudyKindId) {
		this.midStudyKindId = midStudyKindId;
	}

	public int getMidSubjectId() {
		return midSubjectId;
	}

	public void setMidSubjectId(int midSubjectId) {
		this.midSubjectId = midSubjectId;
	}

	public Set getStudentModel() {
		return StudentModel;
	}

	public void setStudentModel(Set studentModel) {
		StudentModel = studentModel;
	}

	public Set getTeacherModel() {
		return TeacherModel;
	}

	public void setTeacherModel(Set teacherModel) {
		TeacherModel = teacherModel;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
}
