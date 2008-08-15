<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">  
<head>    
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />    
	<link href="/library/skin/tool_base.css" type="text/css" rel="stylesheet" media="all" />    
	<link href="/library/skin/default/tool.css" type="text/css" rel="stylesheet" media="all" />    
	<meta http-equiv="Content-Style-Type" content="text/css" />    
	<title>创远平台 - 登录</title>    
	<script type="text/javascript" language="JavaScript" src="/library/js/headscripts.js"></script>  
	</head>  
<body>
<%
  String name = request.getParameter("eid");
  String logintype = request.getParameter("logintype");
  if(logintype != null && logintype.equals("zhj")){
%>
<form name="myform" action="/portal/xlogin?submit=Login" method="post" enctype="application/x-www-form-urlencoded">
	<input type="hidden" name="eid" value="<%=name%>"/>
	<input type="hidden" name="pw" value="sakai"/>
	<input type="hidden" name="logintype" value="zhj"/>
</form>
<script language="javascript">
	document.myform.submit();
</script>
<%
}else{
	out.println("\u60a8\u6ca1\u6709\u6743\u9650\uff0c\u8bf7\u68c0\u67e5\u76f8\u5173\u4fe1\u606f\uff01");
	}
%>
	<script type="text/javascript" language="JavaScript">  focus_path = ["eid"];	
	</script>
	<table class="login" cellpadding="0" cellspacing="0" border="0" summary="layout">		
		<tr><th colspan="2">创远学习平台登录</th></tr>		
		<tr>	<td class="logo"></td>
				<td class="form">				
						<form method="post" action="http://192.168.0.80:9080/portal/xlogin" enctype="application/x-www-form-urlencoded">                           
						<table border="0" class="loginform" summary="layout">								
							<tr>	<td><label for="eid">用户ID</label></td><td><input name="eid" id="eid"  type="text"/></td></tr>								
							<tr>	<td><label for="pw">密码</label></td><td><input name="pw" id="pw"  type="password"/></td></tr>								
							<tr>	<td colspan="2"><input name="submit" type="submit" id="submit" value="登录"/></td></tr>							
						</table>						
						</form>
				</td>				
		</tr>
	</table>		



</body>

</html>
