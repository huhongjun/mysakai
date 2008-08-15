/**********************************************************************************
 * $URL: https://source.sakaiproject.org/contrib/ucb/ucb-integration-samples/bspace-user-provider-impl/src/main/java/edu/berkeley/bspace/UserDirectoryProviderBspaceImpl.java $
 * $Id: UserDirectoryProviderBspaceImpl.java 43979 2007-12-03 12:34:45Z ray@media.berkeley.edu $
 ***********************************************************************************
 *
 * Copyright (c) 2007 The Sakai Foundation.
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

import java.util.Collection;
import java.util.Iterator;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.entity.api.ResourceProperties;
import org.sakaiproject.user.api.DisplayAdvisorUDP;
import org.sakaiproject.user.api.User;
import org.sakaiproject.user.api.UserDirectoryProvider;
import org.sakaiproject.user.api.UserEdit;

/**
 * UC Berkeley implementation of Sakai's UserDirectoryProvider.  Handles authentication
 * and user lookups, which are preferentially handled via the DB.  LDAP is consulted
 * only when the user can't be found in the DB.
 */
public class UserDirectoryProviderVcleImpl implements UserDirectoryProvider, DisplayAdvisorUDP {
	private static final Log log = LogFactory.getLog(UserDirectoryProviderVcleImpl.class);

	public static final String DISPLAY_ID_KEY = "display.id.key";
	
	private JdbcUserDirectory jdbcUserDirectory;

	// User lookup methods

	public boolean findUserByEmail(UserEdit userEdit, String email) {
		email = StringUtils.trim(email);
		boolean success = jdbcUserDirectory.findUserByEmail(userEdit, email);

		return success;
	}
	
	public boolean getUser(UserEdit userEdit) {
		if (log.isDebugEnabled()) log.debug("getUser id=" + userEdit.getId() + 
				", eid=" + userEdit.getEid() +
				", type=" + userEdit.getType());
		userEdit.setEid(StringUtils.trim(userEdit.getEid()));

		boolean success = jdbcUserDirectory.findUserByEid(userEdit);

		return success;
	}

	/**
	 * TODO: This is inefficient.  Implement a more efficient method for looking up
	 * a collection of users (copied from bspace 2.1).
	 */
	@SuppressWarnings("unchecked")
	public void getUsers(Collection users) {
		for (Iterator<UserEdit> iter = users.iterator(); iter.hasNext();) {
			UserEdit user = iter.next();
			if (!getUser(user)) {
				iter.remove();
			}
		}
	}

	public boolean userExists(String eid) {
		//throw new UnsupportedOperationException("userExists is legacy CHEF cruft, and should not be called at runtime");
		return jdbcUserDirectory.findUserByEid(eid);
	}
	
	//// DisplayAdvisorUDP Methods
	
	/**
	 * Return the student ID if there is one; otherwise return the LDAP UID.
	 */
	public String getDisplayId(User user) {
		ResourceProperties props = user.getProperties();
		if(props == null) {
			return user.getEid();
		}
		String displayId = props.getProperty(DISPLAY_ID_KEY);
		if (displayId == null) {
			return user.getEid();
		} else {
			return displayId;
		}
	}

	public String getDisplayName(User user) {
		if (user.getLastName().equals("zhj"))
		{
			return user.getFirstName();
		}
		else
			return user.getLastName() + user.getFirstName();
	}
	
	//// Authentication Methods

	/**
	 * With the new design of BaseUserDirectoryService, this method should 
	 * never be called, even in the bizarre case of a CalNet login ID accidentally
	 * matching a LDAP UID or locally entered Sakai user.
	 */
	public boolean authenticateUser(String authenticationId, UserEdit userEdit, String password) {

		if ((authenticationId == null) || (password == null)) return false;
		
		System.out.println("authenticateUser(" + authenticationId + ")");
		
		if (userExists(authenticationId) && password.equals("sakai")) return true;

		return false;
		
	}

    //// Configuration Methods
	
	public void setJdbcUserDirectory(JdbcUserDirectory jdbcUserDirectory) {
		this.jdbcUserDirectory = jdbcUserDirectory;
	}

	
	//// Unimplemented cruft.

	public void destroyAuthentication() {
		if (log.isDebugEnabled()) log.debug("destroyAuthentication");
	}

	public boolean authenticateWithProviderFirst(String eid) {
		return false;
	}

	public boolean updateUserAfterAuthentication() {
		return false;
	}
	
	public boolean createUserRecord(String id)
	{
		return false;
	}
}
