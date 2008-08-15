package com;

import java.util.Iterator;
import java.util.Set;
import java.util.TreeSet;

public class Environment {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		java.util.Properties   p   =   System.getProperties();  
		   
        System.out.println("--------   listing   properties   ---------");  
        Set   keys   =   p.keySet();  
         
        for   (Iterator   iter   =   new   TreeSet   (keys).iterator();   iter.hasNext();   )   {  
                String   key   =   (String)   iter.next();  
                String   val   =   (String)   p.get(key);  
                System.out.println   (key   +   "="   +   val);  
        }  
	}

}
