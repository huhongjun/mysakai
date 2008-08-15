package com.main;

import com.dao.CourseDAO;
import com.dao.MidCtrlDAO;
import com.dao.StudentDAO;
import com.dao.TeacherDAO;
import com.util.ApplictionContext;

public class BaseMain {
	
	public CourseDAO getCourseManager1() {
		return (CourseDAO) ApplictionContext.getInstance().getApplictionContext().getBean("courseDao");
	}

	public TeacherDAO getCourseManager2() {
		return (TeacherDAO) ApplictionContext.getInstance().getApplictionContext().getBean("teacherDao");
	}
	
	public StudentDAO getCourseManager3() {
		return (StudentDAO) ApplictionContext.getInstance().getApplictionContext().getBean("studentDao");
	}
	
	public MidCtrlDAO getCourseManager4() {
		return (MidCtrlDAO) ApplictionContext.getInstance().getApplictionContext().getBean("midCtrlDao");
	}
	
}
