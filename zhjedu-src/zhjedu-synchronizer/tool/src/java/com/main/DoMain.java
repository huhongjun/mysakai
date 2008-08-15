package com.main;

import java.util.List;

import com.model.CourseModel;
import com.model.StudentModel;
import com.model.TeacherModel;

public class DoMain extends BaseMain {

/** 同步所有课程及其成员 */
public void synchronizeAllCourses(){
	List<CourseModel> courseList = this.getCourseManager1().getAllCourses();

	// 课程循环
	for(CourseModel cm:courseList){
		int courseId = cm.getCourseId();
		String courseName = cm.getCourseName();
		System.out.println("======>课程："+courseId+courseName);

		// 查询Sakai中是否有该门课程[course_id]
		if (courseId != 0) {		//A. 如果Sakai中课程不存在
			// A-1、TODO：新增课程
			System.out.println("A-新增课程："+courseId+courseName);		
			
			// A-2、为本门课程增加成员
			// A-2.1 增加课程成员中的教师
			List<TeacherModel> teacherList = this.getCourseManager2().getTeacherOfCourse(courseId);
			for(TeacherModel tm:teacherList){
				String TeacherName = tm.getRealName();
				int TeacherId = tm.getTeacherId();
				// TODO: 新增教师				
				System.out.println("A-新增教师："+TeacherId+TeacherName);
			}
			// A-2.2 增加课程成员中的学生
			List<StudentModel> studentList = this.getCourseManager3().getStudentOfCourse(courseId);
			for(StudentModel stu:studentList){
				String StudentName = stu.getRealName();
				int StudentId = stu.getStudentId();
				// TODO: 新增学生
				System.out.println("A-新增学生："+StudentId + StudentName);
			}
		} else {					//B. Sakai中课程已存在
			// TODO:修改课程：课程标题/课程编码，以及多个课程属性
			System.out.println("B-修改课程："+courseId+courseName);	

			// B-2、为本门课程同步成员
			// B-2.1 同步课程成员中的教师			
			List teacher = this.getCourseManager2().getTeacherOfCourse();
			for(int j=0;j<teacher.size();j++){
				TeacherModel tm = (TeacherModel) teacher.get(j);
				String TeacherName = tm.getRealName();
				int TeacherId = tm.getTeacherId();
				System.out.println("B-教师："+TeacherId+TeacherName);
				// TODO: 此处应该去sakai库查用户表看是否存在这个用户，如果没有就是新增用户如果有就修改用户
 				if (TeacherId == 0) {
 					System.out.println("B-新增教师");
				} 
			}
			// 2.1 同步课程成员中的学生			
			List student = this.getCourseManager3().getStudentOfCourse();
			for(int k=0;k<student.size();k++){
				StudentModel sm = (StudentModel) student.get(k);
				String StudentName = sm.getRealName();
				int StudentId = sm.getStudentId();
				System.out.println("学生："+StudentId + StudentName);
				// TODO: 此处应该去sakai库查用户表看是否存在这个用户，如果没有就是新增用户如果有就修改用户
 				if (StudentId == 0) {
 					System.out.println("新增学生");
				}
			}
		}
		System.out.println("end of 课程："+courseId+courseName);
	}
}

public static void main(String[] args) {

	DoMain doMain = new DoMain();
	doMain.synchronizeAllCourses();
}
}
