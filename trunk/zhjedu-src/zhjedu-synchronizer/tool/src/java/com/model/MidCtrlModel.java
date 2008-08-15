package com.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class MidCtrlModel {

	/** 控制表主健ID **/
	private int id;

	/** 版本号 **/
	private int version;

	/** 受控数据表名 **/
	private String tbName;

	/** 受控数据表主键 **/
	private int tbId;

	/** 知金数据主键ID **/
	private int zhjId;

	/** 创远数据主键ID **/
	private int cyId;
	
	/** 状态信息  0－插入 1－修改 2－删除 3－已处理 **/
	private int state;
	
	/** 操作者 0－知金  1－创远 **/
	private String operator;
	
	/** 更新日期 **/
	private Date createDate;
	
	/** 创建日期 **/
	private Date updateDate;
	
	/** 课程集合 **/
	private Set CourseModel = new HashSet(0);
	
	/** 教师集合 **/
	private Set TeacherModel = new HashSet(0);

	/** 学生集合 **/
	private Set StudentModel = new HashSet(0);
	
	// TODO 控制表中有课程，教师学生的集合，反之是否也应该有对应？

	/** default constructor */
	public MidCtrlModel() {
	}

	/** full constructor */
	public MidCtrlModel(int id, int version, String tbName, int tbId, int zhjId, 
			int cyId, int state, String operator, Date createDate, Date updateDate,
			Set CourseModel, Set TeacherModel, Set StudentModel) {
		this.id = id;
		this.version = version;
		this.tbName = tbName;
		this.tbId = tbId;
		this.zhjId = zhjId;
		this.cyId = cyId;
		this.state = state;
		this.operator = operator;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.CourseModel = CourseModel;
		this.TeacherModel = TeacherModel;
		this.StudentModel = StudentModel;
	}

	public Set getCourseModel() {
		return CourseModel;
	}

	public void setCourseModel(Set courseModel) {
		CourseModel = courseModel;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int getCyId() {
		return cyId;
	}

	public void setCyId(int cyId) {
		this.cyId = cyId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Set getStudentModel() {
		return StudentModel;
	}

	public void setStudentModel(Set studentModel) {
		StudentModel = studentModel;
	}

	public int getTbId() {
		return tbId;
	}

	public void setTbId(int tbId) {
		this.tbId = tbId;
	}

	public String getTbName() {
		return tbName;
	}

	public void setTbName(String tbName) {
		this.tbName = tbName;
	}

	public Set getTeacherModel() {
		return TeacherModel;
	}

	public void setTeacherModel(Set teacherModel) {
		TeacherModel = teacherModel;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public int getZhjId() {
		return zhjId;
	}

	public void setZhjId(int zhjId) {
		this.zhjId = zhjId;
	}
	
}
