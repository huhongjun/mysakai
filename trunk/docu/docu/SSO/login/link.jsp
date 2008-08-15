<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" language="java" %>
<%
  String url = request.getPramater("urllink");
    if(null!=url)
     String urllink = url.replace("-","?");
 {
 %>
<html>
	<head>	</head>
	<body onload="link()">	</body>
</html>
<script language="javascript" type="text/javascript">
  var urllink = <%=urllink%>;
   function link()
    {
     	window.open (urllink, 'newwindow','');
    }
     </script>
<%}else{
	out.println("\u60a8\u6ca1\u6709\u6743\u9650\uff0c\u8bf7\u68c0\u67e5\u76f8\u5173\u4fe1\u606f\uff01");
	}%>