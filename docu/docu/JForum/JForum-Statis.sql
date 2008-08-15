select 
	sakai_site.title as "course-title",
	jforum_topics.forum_id,	jforum_forums.forum_name,
	jforum_topics.topic_id,jforum_topics.topic_title,
	jforum_users.username,
	post_time
from 
	jforum_posts,
	jforum_users,
	jforum_topics,
	jforum_sakai_course_categories,
	jforum_forums,
	sakai_site,
	jforum_categories	
where jforum_posts.user_id = jforum_users.user_id 
	and jforum_topics.topic_id = jforum_posts.topic_id 
	and	jforum_forums.categories_id = jforum_sakai_course_categories.categories_id 
	and	jforum_sakai_course_categories.course_id = sakai_site.site_id 
	and	jforum_categories.categories_id = jforum_forums.categories_id	
	and jforum_posts.forum_id = jforum_forums.forum_id