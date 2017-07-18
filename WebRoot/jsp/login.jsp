<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">
 <head>
  <meta charset="UTF-8">
  <meta name="Generator" content="EditPlus®">
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <title>Document</title>
  <link rel="stylesheet" href="/minecraft/css/login.css">
 </head>
 <body>
	<header>
			<div class="logo left">
				<a href="about:blank"><img src="../imgs/logo.gif" alt="logo"></a>
			</div>
			<div class="welcome left">欢迎登录</div>
	</header>
	<section>
		<div class="mid">
			<div class="saoma"></div>
			<div class="loginbiao">账户登录</div>

			<form action="/minecraft/servlet/LoginServlet" method="post">
				<table class="tb">
					<tr>
						<td class="t1 user"><input class="name_pwd" name="uname"  type="text" placeholder="用户名"><span></span></td>
					</tr>
					<tr>
						<td class="t1 passw" ><input class="name_pwd" name="pw" type="password" placeholder="密码"></td>
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
						<td  class="t2"><a href="">忘记登陆密码</a><a href="/minecraft/register.html">免费注册</a></td>
					</tr>
					<tr>
						<td  class="t3"><input type="submit" class="login" value=""></td>
					</tr>
	
					<tr>
						<td  class="t4">
							<a href="" ></a>
							<a href=""></a>
						</td>
					</tr>
	
				</table>
			</form>
		</div>
	</section>
 	<footer>
		<div class="line1">
			<a href="">关于达内</a>
			<a href="">Investor Relations</a>
			<a href="">联系我们</a>
			<a href="">隐私声明</a>
			<a href="">法律公告</a>
			<a href="">退费须知</a>
			<a href="">网站地图</a>
			<a href="">达内移动站</a>
		</div>
		<div class="line2">
			2011-2016 达内时代科技集团有限公司(Tarena international,inc.)版权所有
		</div>
	</footer>
	
	<script type="text/javascript">
	window.onload = function() {
			var inputs = document.getElementsByClassName("name_pwd");
			
			var tr = document.getElementById("prompt");
			for (var i = 0; i < inputs.length; i++) {
				inputs[i].onfocus = function() {
					/* tr.setAttribute("hidden", "hidden"); */
					tr.childNodes[1].innerText="";
				}
			}
	};
	</script>
 </body>
</html>
