## 添加一条学期信息，否则不能建course站点

	insert into cm_academic_session_t 
		values(1,0,null,null,'admin','2007-07-05','t7','t7','t7','2007-02-02','2008-01-01')
		where not exists(select * from cm_academic_session_t where ACADEMIC_SESSION_ID=1)

use sakai;
##课程相关的表

insert into cm_member_container_t values(1,'org.sakaiproject.coursemanagement.impl.CourseSetCmImpl','1','admin','2007-08-15','admin','2007-08-25','smp','sd','wst',null,null,null,null,null,null,null,null,null,null,null,null);

#cm_academic_session_t
insert into cm_academic_session_t values(1,0,null,null,'admin','2007-07-05','t7','t7','t7','2007-02-02','2008-01-01');

insert into cm_academic_session_t values(2,0,null,null,'admin','2007-07-05','w7','w7','w7','2007-05-02','2008-01-02');



#cm_cross_listing_t
insert into cm_cross_listing_t values(1,0,null,null,'admin','2007-08-08');

insert into cm_cross_listing_t values(2,0,null,null,'admin','2007-09-08');


#cm_enrollment_set_t
##外键引用主键（cm_member_container_t:MEMBER_CONTAINER_ID）
insert into cm_enrollment_set_t values(1,0,null,null,'admin','2007-07-05','smp101','smp101','sc','le',1,1);

insert into cm_enrollment_set_t values(2,0,null,null,'admin','2007-08-05','smp102','smp102','ty','ty',1,1);


#cm_member_container_t
##外键引用主键（cm_academic_session_t:ACADEMIC_SESSION_ID，cm_cross_listing_t:CROSS_LISTING_ID，cm_enrollment_set_t:ENROLLMENT_SET_ID）

insert into cm_member_container_t values(2,'org.sakaiproject.coursemanagement.impl.CourseSetCmImpl','1','admin','2007-08-15','admin','2007-08-25','sp','sd','wst',1,'open','2007-05-10','2008-08-05',1,1,null,null,null,null,null,null);

insert into cm_member_container_t values(3,'org.sakaiproject.coursemanagement.impl.CourseSetCmImpl','1','admin','2007-08-10','admin','2007-08-12','s101','s101','s101',null,null,null,null,null,null,'01.lct',null,1,1,null,null);



#cm_course_set_canon_assoc_t     外键
insert into cm_course_set_canon_assoc_t values(1,1);

insert into cm_course_set_offering_assoc_t values(1,3);


#cm_course_set_offering_assoc_t  外键
insert into cm_course_set_offering_assoc_t values(1,1);

insert into cm_course_set_offering_assoc_t values(1,3);



#cm_enrollment_t
insert into cm_enrollment_t values (1,0,null,null,'admin','2007-07-10','student','w',3,'pps',false,'1');

insert into cm_enrollment_t values (2,0,null,null,'admin','2007-08-10','student1','we',3,'sta',false,'1');



#cm_meeting_t
insert into cm_meeting_t values(1,'building','10:30:00','11:00:00',null,true,false,true,false,true,false,false,'1');

insert into cm_meeting_t values(2,'build','10:00:00','11:00:00',null,true,false,true,false,true,false,false,'3');



#cm_membership_t
insert into cm_membership_t values(1,0,'da','dep','1','active');

insert into cm_membership_t values(2,0,'ia','p','1','active');



#cm_official_instructors_t
insert into cm_official_instructors_t values('1','instructor');

insert into cm_official_instructors_t values('2','admin');


#cm_sec_category_t
insert into cm_sec_category_t values('01.lct','lab');

insert into cm_sec_category_t values('01.stu','studio');




#cm_academic_session_t:ACADEMIC_SESSION_ID

#cm_cross_listing_t:CROSS_LISTING_ID

#cm_enrollment_set_t:ENROLLMENT_SET_ID

#canonical_course
#MEMBER_CONTAINER_ID

#parent_course_set
#MEMBER_CONTAINER_ID

#parent_setion
#MEMBER_CONTAINER_ID

#course_offering
#MEMBER_CONTAINER_ID


