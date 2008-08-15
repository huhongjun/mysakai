package com.model;

import java.util.HashSet;
import java.util.Set;

public class TeacherModel {

	/** Teacher表的主键ID **/
	private int id;

	/** 版本 **/
	private int version;

	/** 知金库教师ID **/
	private int teacherId;
	/** 知金库教师类型 **/
	private int teacherType;

	/** 用户名 **/
	private String userName;

	/** 姓名 **/
	private String realName;

	/** 课程集合 **/
	private Set CourseModel = new HashSet(0);

	/** default constructor */
	public TeacherModel() {
	}

	/** full constructor */
	public TeacherModel(int id, int version, int teacherId, int teacherType, String userName,
			String realName, Set CourseModel) {
		this.id = id;
		this.version = version;
		this.teacherId = teacherId;
		this.teacherType = teacherType;
		this.userName = userName;
		this.realName = realName;
		this.CourseModel = CourseModel;
	}

	public Set getCourseModel() {
		return CourseModel;
	}

	public void setCourseModel(Set CourseModel) {
		this.CourseModel = CourseModel;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public int getTeacherId() {
		return teacherId;
	}

	public void setTeacherId(int teacherId) {
		this.teacherId = teacherId;
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

	public int getTeacherType() {
		return teacherType;
	}

	public void setTeacherType(int teacherType) {
		this.teacherType = teacherType;
	}
}
