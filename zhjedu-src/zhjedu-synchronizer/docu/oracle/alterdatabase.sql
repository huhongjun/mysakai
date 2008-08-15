-- create SITE_SUBJECT
create table SITE_SUBJECT (site_id varchar2(99) not null,course_id number not null,institution_id number not null,recruitbatch_id number not null,studykind_id number not null,subject_id number not null);
-- SITE_SUBJECT add FOREIGN KEY
alter table SITE_SUBJECT add (FOREIGN KEY(site_id) REFERENCES SAKAI_SITE(site_id));
-- create USER_STATUS
create table USER_STATUS (eid varchar2(255) not null,real_name VARCHAR2(255),institution_id number,recruitbatch_id number,mid_studykind_id number,subject_id number,status varchar(1)not null);
-- USER_STATUS add primary key
alter table USER_STATUS add (primary key(eid));
-- delete CM_ACADEMIC_SESSION_T data
delete from CM_ACADEMIC_SESSION_T;
insert into CM_ACADEMIC_SESSION_T values(1,0,null,null,'admin',to_date('2007-08-08','yyyy-mm-dd'),'学期','学期','学期',to_date('2007-08-08','yyyy-mm-dd'),to_date('2020-08-08','yyyy-mm-dd'));






