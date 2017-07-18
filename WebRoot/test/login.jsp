<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录</title>
<style>
#prompt {
	color: red;
}
</style>
<script type="text/javascript">
	window.onload = function() {
		var inps = document.getElementsByClassName("inp");
		var pt = document.getElementById("prompt");
		for (var i = 0; i < inps.length-1; i++) {
			inps[i].onfocus = function() {
				pt.innerHTML = "";
			}
		}
	}
</script>
</head>
<body>
	<form action="/minecraft/servlet/LoginServlet" method="post">
		用户名：<input class="inp" type="text" name="uname"><br />
		密&nbsp;&nbsp;&nbsp;码：<input class="inp" type="password" name="pw"><br />
		<span id="prompt"> 
		<%
		 	String login = (String) request.getAttribute("login_state");
		 	if (login != null && login.equals("false")) {
		 		out.print("用户名或者密码错误");
		 	}
		 %>
		</span><br /> 
		<input type="submit" value="登录"><br /> 
		<a href="/minecraft/register.html">还没有账号？点我注册！</a>
	</form>
</body>
</html>