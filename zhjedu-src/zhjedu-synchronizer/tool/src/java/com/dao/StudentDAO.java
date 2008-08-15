package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.RowMapperResultReader;

import com.model.StudentModel;

public class StudentDAO {

	private static final Log log = LogFactory.getLog(StudentDAO.class);

	/** jdbcTemplate模板 */
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	
	class StudentRowMapper implements RowMapper {

		public Object mapRow(ResultSet rs, int index) throws SQLException {
			StudentModel studentModel = new StudentModel();
			studentModel.setStudentId(rs.getInt("student_id"));
			studentModel.setMidInstitutionId(rs.getInt("mid_institution_id"));
			studentModel.setMidRecruitBatchId(rs.getInt("mid_recruitbatch_id"));
			studentModel.setMidStudyKindId(rs.getInt("mid_studykind_id"));
			studentModel.setMidSubjectId(rs.getInt("mid_subject_id"));
			studentModel.setUserName(rs.getString("user_name"));
			studentModel.setRealName(rs.getString("real_name"));
			return studentModel;
		}
		
	}
	public List<StudentModel> getStudentOfCourse(){
		
		String sql = "select distinct s.student_id, s.mid_institution_id, " +
				"s.mid_recruitbatch_id, s.mid_studykind_id, s.mid_subject_id, s.user_name, s.real_name " +
				"from MID_CHOICE_COURSE cc,MID_STUDENT s " +
				"where cc.mid_student_student_id = s.student_id and cc.isopen=0 and cc.mid_course_course_id in " +
				"(select mct.mid_course_course_id from MID_COURSE mc, MID_COURSE_TEACHER mct " +
				"where mc.course_id = mct.mid_course_course_id)";

//		Object []params = new Object[]{courseId};
		return jdbcTemplate.query(sql, new RowMapperResultReader(new StudentRowMapper()));
		
	}
	
	
	public List<StudentModel> getStudentOfCourse(final Integer courseId){
		
		String sql = "select distinct s.student_id, s.mid_institution_id, " +
		"s.mid_recruitbatch_id, s.mid_studykind_id, s.mid_subject_id, s.user_name, s.real_name " +
		"from MID_CHOICE_COURSE cc,MID_STUDENT s " +
		"where cc.mid_student_student_id = s.student_id and cc.isopen=0 and cc.mid_course_course_id in " +
		"(select mct.mid_course_course_id from MID_COURSE mc, MID_COURSE_TEACHER mct " +
		"where mc.course_id = mct.mid_course_course_id) and cc.mid_course_course_id = ? ";
		
		Object []params = new Object[]{courseId};
		
		return jdbcTemplate.query(sql, params, new RowMapperResultReader(new StudentRowMapper()));	
	}
}
