<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.it61.minecraft.common.*" %>
<%
String webName = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webName+"/";
%>

<%-- 读取cookie --%>
<%
	String name = "";
	String password = "";
	try {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("cookie-user")) {
					String values = cookies[i].getValue();
					// 如果value字段不为空 
					if (StringUtils.isNotEmpty(values)) {
						String[] elements = values.split("-");
						// 获取账户名或者密码 
						if (StringUtils.isNotEmpty(elements[0])) {
							name = elements[0];
						}
						if (StringUtils.isNotEmpty(elements[1])) {
							password = elements[1];
						}
					}
				}
			}
		}
	} catch (Exception e) {
	}
%>

<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="Generator" content="EditPlus®">
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<title>登录</title>
<link rel="stylesheet" href="<%=basePath %>/css/login.css">
</head>
<body>
	<div id="logtag">iamloginpage,but you can't see me!</div>
	<header>
		<div class="logo left">
			<a href="about:blank"><img src="<%=basePath %>/imgs/logo.gif" alt="logo"></a>
		</div>
		<div class="welcome left">欢迎登录</div>
	</header>
	<section>
		<div class="mid">
			<div class="saoma"></div>
			<div class="loginbiao">账户登录</div>

			
			<form action="http://127.0.0.1:8080//mc/servlet/LoginServlet" method="post">
				<table class="tb">
					<tr>
						<td class="t1 user">
						<input class="name_pwd" name="uname" type="text" placeholder="用户名" value="<%=name%>"><span></span></td>
					</tr>
					<tr>
						<td class="t1 passw"><input class="name_pwd" name="pw"
							type="password" placeholder="密码" value="<%=password%>"></td>
					</tr>

					<tr id="prompt">
						<td>
							<%
								String login = (String) request.getAttribute("login_state");
								if (login != null && login.equals("false")) {
									out.print("用户名或者密码错误");
								}
							%>
						</td>
					</tr>
					<tr>
						<td class="t2"><a href="javascript:void(0)">忘记登陆密码</a><a
							href="<%=basePath%>jsp/registe.jsp">免费注册</a></td>
					</tr>
					<tr>
						<td class="t3"><input type="submit" class="login" value=""></td>
					</tr>

					<tr>
						<td class="t4"><a href=""></a> <a href=""></a></td>
					</tr>

				</table>
			</form>
		</div>
	</section>
	<footer>
		<div class="line1">
			<a href="">关于达内</a> <a href="">Investor Relations</a> <a href="">联系我们</a>
			<a href="">隐私声明</a> <a href="">法律公告</a> <a href="">退费须知</a> <a
				href="">网站地图</a> <a href="">达内移动站</a>
		</div>
		<div class="line2">2011-2016 达内时代科技集团有限公司(Tarena
			international,inc.)版权所有</div>
	</footer>

	<script type="text/javascript">
		/* 重新输入用户名或者密码时，提示信息置空 */
		window.onload = function() {
			var inputs = document.getElementsByClassName("name_pwd");

			var tr = document.getElementById("prompt");
			for (var i = 0; i < inputs.length; i++) {
				inputs[i].onfocus = function() {
					/* tr.setAttribute("hidden", "hidden"); */
					tr.childNodes[1].innerText = "";
				}
			}
		};
	</script>
</body>
</html>
