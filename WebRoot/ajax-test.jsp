<%@page import="java.io.InputStream"%>
<%@ page language="java" 
import="java.util.*" 
import="java.io.*"
import="com.it61.minecraft.bean.User"
pageEncoding="UTF-8"%>

<% 
User user = (User)request.getAttribute("user");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%--
File file = new File("d://mary.jpg");
FileInputStream is = new FileInputStream(file);
response.setContentType("image/jpeg");
OutputStream sout = response.getOutputStream();
byte[] buff = new byte[1024];
int len = -1;
while((len=is.read(buff)) != -1){
	sout.write(buff,0,len);
}
sout.flush();
sout.close();
is.close();

--%>


<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
	<style>
		img{
			width: 200px;
			height: 200px;
		}
		#div1{
		width: 200px;
			height: 200px;
			background-image: url(/minecraft/servlet/ShowImgServlet);
			background-position: center;
		}
		#div3{
			width: 200px;
			height: 200px;
			background-position: center;
		}
		
	</style>
	<script src="/minecraft/plugin/jquery/jquery.min.js"></script>
	</head>

	<body>
		<img id="omg" style="width:100px;height:100px" title="omg"/>
		haha
<%-- 		 <img src="${sout }" title="tt"><br/>
		 <hr/>
		 <img src="<%=sout %>" title="hehe"> --%>
		 <img alt="hehe" src="/minecraft/servlet/ShowPicServlet?id=1">
		 <hr/>
		 <div id="div1">
		 	div
		 </div>
		 <div id="userphoto">
		 	div2
		 </div>
		 
		 <img id="img1" />
		 <input type="file" onchange="pre(this)">
		 
		 <div id="div3">
		 	div3
		 </div>
		 
		 
		 <script type="text/javascript">
/* 		 	
		 	var div = document.getElementById("userphoto");
		 	div.style.backgroundImage="url(/minecraft/servlet/ShowPicServlet?id=1)"; */
		 	
		 	function pre(file){
			 	 if (file.files && file.files[0]) {
		 		 	var div = document.getElementById("div3");
		 		 	
			 	 	var reader = new FileReader();
	            	reader.onload = function (evt) {
	               		div.style.backgroundImage = "url("+evt.target.result+")";
            		}
            		reader.readAsDataURL(file.files[0]);
			 	 }
		 		
		 	}
<%-- 		 	
		 	$("#omg")[0].src="<%=basePath%>"+"minecraft/servlet/ShowPicServlet?id=1";  --%>
		 	$("#omg")[0].src="/minecraft/servlet/ShowPicServlet?id=1";
		 	alert($("#omg")[0].src)
		 </script>
	</body>
</html>
