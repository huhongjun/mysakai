<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" language="java" %>

<html>
	<head>
	</head>
	<body onload="link()">
		<!--
<%
  String name = request.getParameter("eid");
  String state = request.getParameter("status");
  String couroseId  = request.getParameter("couroseId");
  if(null != name && null != state && null != couroseId){
%>-->
	</body>
</html>
<!--
<%
  String url = request.getParameter("url");
%>
-->
<script language="javascript" type="text/javascript">
    function link()
    {
     //	var linkurl = <%=url%>;
     	//window.open ('http://192.168.0.79:8080/login/login.jsp?logintype=zhj&eid=29725', 'newwindow','');
     	//window.open ('http://127.0.0.1:9000/login/link.jsp?logintype=zhj&eid=29725', 'newwindow','');
     	window.open ('http://127.0.0.1:9000/login/out.jsp, 'newwindow','');
  		//window.open ('out.jsp', 'newwindow','');
  		//window.open ('linkurl','newwindow','');
    }
</script>
<!--
<%
}else{
	out.println("\u60a8\u6ca1\u6709\u6743\u9650\uff0c\u8bf7\u68c0\u67e5\u76f8\u5173\u4fe1\u606f\uff01");
	}
%>-->