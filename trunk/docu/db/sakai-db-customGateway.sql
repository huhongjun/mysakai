-- customized gateway site
update "SAKAI"."SAKAI_SITE_TOOL_PROPERTY"
	 set value='/library/content/gateway/about_zh_CN.html'
	 where site_id='!gateway' and tool_id='!gateway-210' and name='source';
	 
update "SAKAI"."SAKAI_SITE_TOOL_PROPERTY"
	 set value='/library/content/gateway/features_zh_CN.html'
	 where site_id='!gateway' and tool_id='!gateway-310' and name='source';

update "SAKAI"."SAKAI_SITE_TOOL_PROPERTY"
	 set value='/library/content/gateway/training_zh_CN.html'
	 where site_id='!gateway' and tool_id='!gateway-510' and name='source';

update "SAKAI"."SAKAI_SITE_TOOL_PROPERTY"
	 set value='/library/content/gateway/acknowledgments_zh_CN.html'
	 where site_id='!gateway' and tool_id='!gateway-610' and name='source';