<%@ page language="java" 
import="java.util.*" 
import="com.it61.minecraft.bean.User" 
import="com.it61.minecraft.service.UserService"
import="com.it61.minecraft.service.impl.UserServiceImpl"
pageEncoding="UTF-8"%>
<%
String webName = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webName+"/";
%>
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
			<div class="welcome left">欢迎登陆</div>
	</header>
	<section>
		<div class="mid">
			<div class="saoma"></div>
			<div class="loginbiao">账户登录</div>

			<table class="tb">
				<tr>
					<td class="t1 user"><input class="name_pwd"  type="text" placeholder="用户名"><span></span></td>
				</tr>
				<tr>
					<td class="t1 passw" ><input class="name_pwd" type="password" placeholder="密码"></td>
				</tr>
				
				<tr hidden id="prompt">
					<td></td>
				</tr>

				<tr>
					<td  class="t2"><a href="">忘记登陆密码</a><a href="">免费注册</a></td>
				</tr>
				
				<tr>
					<td  class="t3"><button class="login" onclick="login()"></button></td>
				</tr>

				<tr>
					<td  class="t4">
						<a href="" ></a>
						<a href=""></a>
					</td>
				</tr>

			</table>
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
						tr.setAttribute("hidden", "hidden");
					}
				}
		};
		
		function login(){
			var inputs = document.getElementsByClassName("name_pwd");
			var uname = inputs[0].value;
			var pw = inputs[1].value;
			
			var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function(){
               if(xmlhttp.readyState==4 && xmlhttp.status == 200){
                   if(xmlhttp.responseText){
                   		alert(xmlhttp.responseText)
                   		
                   		if(xmlhttp.responseText == "login_fail"){
							var tr = document.getElementById("prompt");
	                   		tr.removeAttribute("hidden");
	                   		for(var i=0;i<tr.childNodes.length;i++){
	                   			if(tr.childNodes[i].nodeName == "TD"){
			                   		tr.childNodes[i].innerText="用户名或者密码错误";
			                   		return;
	                   			}
	                   		}                   		
                   		}else{
                   			window.location.href = xmlhttp.responseText;
                   		}
                   }
               }
            }
            xmlhttp.open("post","/minecraft/servlet/LoginServlet",true);
            xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlhttp.send("uname="+uname+"&pw="+pw);
			
		}
	</script>
 </body>
</html>
