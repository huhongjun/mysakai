package com.model;

import java.util.HashSet;
import java.util.Set;

public class StudentModel {

	/** Student表的主键ID **/
	private int id;

	/** 版本 **/
	private int version;

	/** 知金库学生ID **/
	private int studentId;

	/** 用户名 **/
	private String userName;

	/** 姓名 **/
	private String realName;

	/** 性别 **/
	private String sex;

	/** 证件号 **/
	private String certNo;

	/** 准考证号 **/
	private String examNo;

	/** 报名号 **/
	private String entryNo;

	/** 状态 2是可以参加入学考试 3、4是可以参加课程学习**/
	private int state;

	/** 知金库入学考试批次ID **/
	private int examBatchId;

	/** 学习中心ID **/
	private int midLearnCenterId;

	/** 网院ID **/
	private int midInstitutionId;
	
	/** 入学批次ID **/
	private int midRecruitBatchId;
	
	/** 培养层次ID **/
	private int midStudyKindId;
	
	/** 专业ID **/
	private int midSubjectId;

	/** 课程集合 **/
	private Set CourseModel = new HashSet(0);

	/** default constructor */
	public StudentModel() {
	}

	/** full constructor */
	public StudentModel(int id, int version, int studentId, String userName,
			String realName, String sex, String certNo, String examNo,
			String entryNo, int state, int examBatchId, int midLearnCenterId,
			int midInstitutionId, int midRecruitBatchId, int midStudyKindId, int midSubjectId,
			Set CourseModel) {
		this.id = id;
		this.version = version;
		this.studentId = studentId;
		this.userName = userName;
		this.realName = realName;
		this.sex = sex;
		this.certNo = certNo;
		this.examNo = examNo;
		this.entryNo = entryNo;
		this.state = state;
		this.examBatchId = examBatchId;
		this.midLearnCenterId = midLearnCenterId;
		this.midInstitutionId = midInstitutionId;
		this.midRecruitBatchId = midRecruitBatchId;
		this.midStudyKindId = midStudyKindId;
		this.midSubjectId = midSubjectId;
		this.CourseModel = CourseModel;
	}

	public String getCertNo() {
		return certNo;
	}

	public void setCertNo(String certNo) {
		this.certNo = certNo;
	}

	public Set getCourseModel() {
		return CourseModel;
	}

	public void setCourseModel(Set courseModel) {
		CourseModel = courseModel;
	}

	public String getEntryNo() {
		return entryNo;
	}

	public void setEntryNo(String entryNo) {
		this.entryNo = entryNo;
	}

	public int getExamBatchId() {
		return examBatchId;
	}

	public void setExamBatchId(int examBatchId) {
		this.examBatchId = examBatchId;
	}

	public String getExamNo() {
		return examNo;
	}

	public void setExamNo(String examNo) {
		this.examNo = examNo;
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

	public int getMidLearnCenterId() {
		return midLearnCenterId;
	}

	public void setMidLearnCenterId(int midLearnCenterId) {
		this.midLearnCenterId = midLearnCenterId;
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

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getStudentId() {
		return studentId;
	}

	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

}
