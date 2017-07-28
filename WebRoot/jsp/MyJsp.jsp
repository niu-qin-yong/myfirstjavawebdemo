<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="java.util.*"  %>
<%@page import="com.it61.minecraft.bean.*"  %>
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
    
    <%
    ArrayList<User> onlineUsers = (ArrayList<User>)getServletContext().getAttribute("online_users");
    out.write("当前在线用户个数"+onlineUsers.size()+"\r\n");
    for(User u:onlineUsers){
	    out.write("用户"+u.getUserName()+"\r\n");
    }
    %>
    
    <script type="text/javascript" src="/minecraft/js/nb.jsp"></script>
    <script type="text/javascript">
    	var div = document.getElementById("mydiv");
    	div.innerHTML = "hehe";
    	
		show();
		iterate();
    </script>
  </body>
</html>
