package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.RowMapperResultReader;

import com.model.TeacherModel;


public class TeacherDAO {

	private static final Log logger = LogFactory.getLog(TeacherDAO.class);

	/** jdbcTemplate模板 */
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	
	class TeacherRowMapper implements RowMapper {

		public Object mapRow(ResultSet rs, int index) throws SQLException {
			TeacherModel teacherModel = new TeacherModel();
			teacherModel.setTeacherId(rs.getInt("teacher_id"));
			teacherModel.setTeacherType(rs.getInt("teacher_type"));
			teacherModel.setUserName(rs.getString("user_name"));
			teacherModel.setRealName(rs.getString("real_name"));
			return teacherModel;
		}
		
	}
	public List<TeacherModel> getTeacherOfCourse(){
		
		String sql = "select distinct mt.teacher_id, mt.teacher_type, mt.user_name, mt.real_name " +
				"from MID_COURSE mc, MID_COURSE_TEACHER mct, MID_TEACHER mt " +
				"where mc.course_id = mct.mid_course_course_id and mct.mid_teacher_teacher_id = mt.teacher_id " +
				"and mc.course_id in (select max(mc.course_id) from MID_COURSE mc, MID_COURSE_TEACHER mct " +
				"where mc.course_id = mct.mid_course_course_id group by mc.course_name)";

		return jdbcTemplate.query(sql, new RowMapperResultReader(new TeacherRowMapper()));
		
	}
	
	public List<TeacherModel> getTeacherOfCourse(final Integer courseId){
		
		String sql = "select distinct mt.teacher_id, mt.teacher_type, mt.user_name, mt.real_name " +
		"from MID_COURSE mc, MID_COURSE_TEACHER mct, MID_TEACHER mt " +
		"where mc.course_id = mct.mid_course_course_id and mct.mid_teacher_teacher_id = mt.teacher_id " +
		"and mc.course_id in (select max(mc.course_id) from MID_COURSE mc, MID_COURSE_TEACHER mct " +
		"where mc.course_id = mct.mid_course_course_id group by mc.course_name) and mc.course_id = ? ";

		final Object[] params = new Object[] {courseId};
		return jdbcTemplate.query(sql, params, new RowMapperResultReader(new TeacherRowMapper()));	
	}
	
	
}
