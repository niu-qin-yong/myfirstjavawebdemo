<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String webName = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webName;


%>
<!doctype html>
<html>
 <head>
  <meta charset="UTF-8">
  <title>完整注册页</title>
  <link rel="stylesheet" href="../css/register.css">
 </head>
 <body>
	<header>
			<a href="#" class="logo"></a>			
			<span class="welcome">欢迎注册</span>
	</header>
	<hr>
	<section>
	    <div id="section_left">
	        <form action="/minecraft/servlet/RegisteServlet" method="post" onsubmit="return check()">
			<ul id="inputarea">
			  <li>
				<input  type="text" placeholder="您的用户名和登陆名" name="uname" id="username" data-point="用户名">
				<div class="inputprompt">用户名</div>
				<div class="warning"></div>
			  </li>
			  <li>
				<input  type="password" placeholder="请输入数字,6位大小写字母的组合" id="password" name="pw" data-point="密码">
				<div class="inputprompt">设置密码</div>
				<div class="warning"><div>
			  </li>
			  <li>
				<input  type="password" placeholder="请再次输入密码" id="retest" data-point="重复密码">
				<div class="inputprompt">确认密码</div>
				<div class="warning"></div>
			  </li>
			  <li>
				<input  type="" placeholder="建议使用常用手机" id="pnumber"data-point="联系电话" name="pnumber">
				<div class="inputprompt">中国+86</div>
				<div class="warning"></div>
			  </li>
			  <li>
				<input  type="" placeholder="请输入验证码" id="vertifycode"data-point="验证码">
				<div class="inputprompt" >验证码</div>
				<div id="vertify" title="看不清?点击刷新" onclick="showValidateCode()"></div>
				<div class="warning"></div>
			  </li>
			  <li>
				<input  type="text" placeholder="请输入邀请码,如果有的话" id="invitecode"data-point="邀请码" name="invitecode">
				<div class="inputprompt" >邀请码</div>
				<div class="warning"></div>
			  </li>
			  <li>
				<input  type="checkbox" id="agreement" name="agree"data-point="认同协议">
				<span>我已阅读并同意<a href="#">《童程用户注册协议》</a></span>
				<div class="warning"></div>
			  </li>
			  <li>
				<input  type="submit" value="" id="register">
			  </li>
			</ul>
			</form>
        </div>      
        <div id="section_right"></div>
	</section>
	<hr class="fohr">
	 	<footer>
		<div class="line_first">
			<a href="#">关于达内</a>
			<a href="#">Investor Relations</a>
			<a href="#">联系我们</a>
			<a href="#">隐私声明</a>
			<a href="#">法律公告</a>
			<a href="#">退费须知</a>
			<a href="#">网站地图</a>
			<a href="#">达内移动站</a>
		</div>
		<div class="line_second">
			2011-2016 达内时代科技集团有限公司(Tarena international,inc.)版权所有
		</div>
	</footer>
 </body>
 <script src="../plugin/jquery/jquery.min.js"></script>
 <script src="../js/register.js"></script>
</html>
    