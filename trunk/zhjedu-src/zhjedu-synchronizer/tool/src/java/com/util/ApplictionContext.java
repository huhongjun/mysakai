package com.util;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class ApplictionContext {

	  private static ApplictionContext instance;

	  private AbstractApplicationContext appContext;

	  public synchronized static ApplictionContext getInstance() {
	    if (instance == null) {
	      instance = new ApplictionContext();
	    }
	    return instance;
	  }

	  private ApplictionContext() {
		  this.appContext = new ClassPathXmlApplicationContext("/applicationContext*.xml");
		 // this.appContext = new FileSystemXmlApplicationContext("D:\\workspace\\LmsGetZhj\\src\\applicationContext.xml");
	  }

	  public AbstractApplicationContext getApplictionContext() {
	    return appContext;
	  }
}
