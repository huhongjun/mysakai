package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.RowMapperResultReader;

import com.model.CourseModel;

public class CourseDAO {

	private static final Log log = LogFactory.getLog(CourseDAO.class);

	/** jdbcTemplate模板 */
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<CourseModel> getAllCourses() {
		
		String sql = "select distinct mc.course_id, mc.course_name, mc.mid_institution_id, mcw.url " +
				"from MID_COURSE mc, MID_COURSE_TEACHER mct, MID_COURSEWARE mcw, MID_COURSE_COURSEWARE mccw " +
				"where mc.course_id = mct.mid_course_course_id " +
				"and mc.course_id = mccw.mid_course_course_id " +
				"and mcw.cw_id = mccw.mid_courseware_cw_id " ;

		return jdbcTemplate.query(sql, new RowMapperResultReader(new CourseRowMapper()));
		
	}

	class CourseRowMapper implements RowMapper {

		public Object mapRow(ResultSet rs, int index) throws SQLException {
			CourseModel courseModel = new CourseModel();
			//TODO 这个地方是所有字段值？还是可以自由选择？==>弄懂了，这个地方是结果列
			courseModel.setCourseId(rs.getInt("course_id"));
			courseModel.setCourseName(rs.getString("course_name"));
			courseModel.setMidInstitutionId(rs.getInt("mid_institution_id"));
			courseModel.setUrl(rs.getString("url"));
			
			return courseModel;
		}
		
	}

}
