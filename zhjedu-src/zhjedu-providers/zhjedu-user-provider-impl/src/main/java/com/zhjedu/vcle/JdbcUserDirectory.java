/**********************************************************************************
*
* $Id: JdbcUserDirectory.java 43979 2007-12-03 12:34:45Z ray@media.berkeley.edu $
*
***********************************************************************************
*
* Copyright (c) 2007 The Regents of the University of California
*
* Licensed under the Educational Community License, Version 1.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.opensource.org/licenses/ecl1.php
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
**********************************************************************************/

package com.zhjedu.vcle;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.user.api.UserEdit;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 *
 */
public class JdbcUserDirectory extends JdbcDaoSupport {
	private static final Log log = LogFactory.getLog(JdbcUserDirectory.class);

	/**
     * The SQL query to use when looking up users by their Enterprise ID (LDAP ID).
     */
    private String userIdDbQuery;
 
    /**
     * The SQL query to use when looking up users by their email address.
     */
    private String userEmailDbQuery;
    
    /**
     * Translation from User property names to database column names.
     */
    private Map<String, String> userToDbMap;

    /**
     * User types stored in the DB are mapped to Sakai user types in dbPersonTypeMap.
     */
    private Map<String, String> dbPersonTypeMap;

	public boolean findUserByEid(UserEdit userEdit) {
		return buildUser(userEdit, getUserAttributesFromDb(userIdDbQuery, userEdit.getEid()));
	}

	public boolean findUserByEid(String userEid) {
		Map<String, Object> userAttributeMap = getUserAttributesFromDb(userIdDbQuery, userEid);
		
		return (userAttributeMap != null && !userAttributeMap.isEmpty());
	}
	
	public boolean findUserByEmail(UserEdit userEdit, String email) {
		return buildUser(userEdit, getUserAttributesFromDb(userEmailDbQuery, email));
	}

	private Map<String, Object> getUserAttributesFromDb(String query, String param) {
		Map<String, Object> map = null;
		try {
			map = getJdbcTemplate().queryForMap(query, new Object[] {param});
		} catch (IncorrectResultSizeDataAccessException e) {
			if(log.isDebugEnabled()) log.debug("Couldn't find " + param + " in DB.");
		}
		return map;
	}

	/**
	 * Sets the properties on the UserEdit, based on the attribute map.
	 * 
	 * @param userEdit
	 * @param userAttributeMap
	 */
	private boolean buildUser(UserEdit userEdit, Map<String, Object> userAttributeMap) {
		boolean success = (userAttributeMap != null && !userAttributeMap.isEmpty());
		if (success) {
			userEdit.setEid(userAttributeMap.get(userToDbMap.get("eid")).toString());
			userEdit.setFirstName((String)userAttributeMap.get(userToDbMap.get("firstName")));
			userEdit.setLastName((String)userAttributeMap.get(userToDbMap.get("lastName")));
			userEdit.setEmail((String)userAttributeMap.get(userToDbMap.get("email")));
			Number displayId = (Number)userAttributeMap.get(userToDbMap.get("displayId"));
			if(displayId != null) {
				userEdit.getProperties().addProperty(UserDirectoryProviderVcleImpl.DISPLAY_ID_KEY, displayId.toString());
			}
			// Convert the personType to something that Sakai can understand
			String personType = (String)userAttributeMap.get(userToDbMap.get("personType"));
			if(personType != null) {
				userEdit.setType(dbPersonTypeMap.get(personType));
			}
		}
		return success;
	}

	public void setDbPersonTypeMap(Map<String, String> dbPersonTypeMap) {
		this.dbPersonTypeMap = dbPersonTypeMap;
	}

	public void setUserEmailDbQuery(String userEmailDbQuery) {
		this.userEmailDbQuery = userEmailDbQuery;
	}

	public void setUserIdDbQuery(String userIdDbQuery) {
		this.userIdDbQuery = userIdDbQuery;
	}

	public void setUserToDbMap(Map<String, String> userToDbMap) {
		this.userToDbMap = userToDbMap;
	}

}
