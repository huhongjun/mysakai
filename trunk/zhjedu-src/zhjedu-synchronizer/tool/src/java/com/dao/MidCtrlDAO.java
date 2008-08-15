package com.dao;

import org.springframework.jdbc.core.JdbcTemplate;

public class MidCtrlDAO {
	
	/** jdbcTemplate模板 */
	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
}
