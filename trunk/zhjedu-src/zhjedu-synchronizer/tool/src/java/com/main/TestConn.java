package com.main;
import java.sql.SQLException;
import java.util.List;

import com.model.CourseModel;
import com.model.StudentModel;
import com.model.TeacherModel;

public class TestConn extends BaseMain {

	public void getAll(){
		List course = this.getCourseManager1().getAllCourses(); 
		for(int i=0;i<course.size();i++){
			CourseModel cm = (CourseModel)course.get(i);
			int courseId = cm.getCourseId();
			String courseName = cm.getCourseName();
			System.out.println(courseId);
			System.out.println(courseName);
			if (courseId == 0) {
				// 新增课程
				List teacher = this.getCourseManager2().getTeacherOfCourse();
				List student = this.getCourseManager3().getStudentOfCourse();
				for(int j=0;j<teacher.size();j++){
					TeacherModel tm = (TeacherModel) teacher.get(j);
					String TeacherName = tm.getRealName();
					int TeacherId = tm.getTeacherId();
					// 此处应该去sakai库查用户表看是否存在这个用户，如果没有就是新增用户如果有就修改用户
	 				if (TeacherId == 0) {
	 					System.out.println("新增教师");
					} else {
						System.out.println("修改教师");
					}
					System.out.println(TeacherId);
					System.out.println(TeacherName);
				}
				for(int k=0;k<student.size();k++){
					StudentModel sm = (StudentModel) student.get(k);
					String StudentName = sm.getRealName();
					int StudentId = sm.getStudentId();
					// 此处应该去sakai库查用户表看是否存在这个用户，如果没有就是新增用户如果有就修改用户
	 				if (StudentId == 0) {
	 					System.out.println("新增学生");
					} else {
						System.out.println("修改学生");
					}
					System.out.println(StudentId);
					System.out.println(StudentName);
				}
			} else {
				// 修改课程
				List teacher = this.getCourseManager2().getTeacherOfCourse();
				List student = this.getCourseManager3().getStudentOfCourse();
				for(int j=0;j<teacher.size();j++){
					TeacherModel tm = (TeacherModel) teacher.get(j);
					String TeacherName = tm.getRealName();
					int TeacherId = tm.getTeacherId();
					// 此处应该去sakai库查用户表看是否存在这个用户，如果没有就是新增用户如果有就修改用户
	 				if (TeacherId == 0) {
	 					System.out.println("新增教师");
					} else {
						System.out.println("修改教师");
					}
					System.out.println(TeacherId);
					System.out.println(TeacherName);
				}
				for(int k=0;k<student.size();k++){
					StudentModel sm = (StudentModel) student.get(k);
					String StudentName = sm.getRealName();
					int StudentId = sm.getStudentId();
					// 此处应该去sakai库查用户表看是否存在这个用户，如果没有就是新增用户如果有就修改用户
	 				if (StudentId == 0) {
	 					System.out.println("新增学生");
					} else {
						System.out.println("修改学生");
					}
					System.out.println(StudentId);
					System.out.println(StudentName);
				}
			}
			System.out.println("==========$$$$$$$$$$$$$$$============");
		}
	}

	/**
	 * @param args
	 * @throws SQLException 
	 */
	public static void main(String[] args) throws SQLException {
		new TestConn().getAll();
	}
}
