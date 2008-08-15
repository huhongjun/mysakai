package com.util;


/**
 * @author：jingbac
 *
 */
public class UuidComponent {

	/**
	 * 
	 */
	public UuidComponent() {
	}
	
	public String createUuid()
	{
		String id = java.util.UUID.randomUUID().toString();

		return id==null?null:id;
	}
}
