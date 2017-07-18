<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'MyJsp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <form action="/minecraft/servlet/SimpleServlet" method="post">
    	Name:<input type="text" name="name" ><br/>
    	Age:<input type="text" name="age"><br/>
    	<input type="submit" value="提交">
    </form>
    <div id="mydiv"></div>
    <script type="text/javascript">
    	var div = document.getElementById("mydiv");
    	div.innerHTML = "HEE";
    </script>
  </body>
</html>
