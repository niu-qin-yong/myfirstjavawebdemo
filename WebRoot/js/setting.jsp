<%@ page contentType="text/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.it61.minecraft.bean.*"%>
<%@page import="com.it61.minecraft.service.*"%>
<%@page import="com.it61.minecraft.service.impl.*"%>
<%@page import="com.alibaba.fastjson.*" %>
<%@page import="com.alibaba.fastjson.serializer.*" %>
<%@page import="java.sql.*" %>

<%
String webName = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webName;
User user = (User)session.getAttribute("user");
%>

/**
*上传图片后在本地预览
**/
	function preView(file,ele){
	if (file.files && file.files[0]) {
		//如果上传文件不是图片类型，则不预览，实际上这里可以提示用户上传文件类型错误
        var imageType = /^image\//;
		if (!imageType.test(file.files[0].type)) {
			  file.files[0] = null;
		      return;
		}
	
		var div = document.getElementById("userphoto");
		
		var reader = new FileReader();
       	reader.onload = function (evt) {
       		ele.style.backgroundImage = "url("+evt.target.result+")";
     		}
     	reader.readAsDataURL(file.files[0]);
	}
}

/**
*设置用户头像
**/
function setUserPhoto(){
	var div = document.getElementById("userphoto");
	div.style.backgroundImage="url(<%=basePath%>/servlet/ShowPicServlet?id="+<%=user.getId()%>+")";
}

/**
*设置select的选中项(年级、班级、星座)
**/ 
function setSelectedOption(select,value){
	var options = document.getElementById(select).options;
	for(var i=0;i < options.length;i++){
		if(options[i].value == value){
			options[i].selected = true;
			break;
		}
	}	
}

/**
*检测性别单选框是否有被选中的，如果没有则默认选中第一个
**/
function checkRadio(){
    var genderradio = document.getElementsByName('gender');
    var len = genderradio.length;
    for(var i = 0;i < len;i++){
          //如果有选中的,程序退出不再判断
         if(genderradio[i].checked){
              return;
         }
    }
    //如果没有选中的将第一个默认选中
    genderradio[0].checked = "checked";
}

/**
 * 上传设置数据
 * @returns {Boolean}
 */
function ajax_submit_setting(){
	var myForm = document.getElementById('settingform');
	var formData = new FormData(myForm);
	
	var xmlhttp = new XMLHttpRequest();
	  xmlhttp.onreadystatechange = function(){
	  	if(xmlhttp.readyState==4 && xmlhttp.status == 200){
	  		alert(xmlhttp.responseText);
	  	}
	  };
	xmlhttp.open("post","<%=basePath%>/servlet/SettingServlet",true);
	xmlhttp.send(formData);
	
	//返回false阻止表单提交
	return false;
}

//设置用户等级
function setUserLevel(){
	var level = "<%=user.getLevel()%>";
	var userLevel = document.querySelector("#userlevel")
	
	var levelUrl = "<%=basePath%>/imgs/star-level-1.png";
	if(Math.floor(level/30) == 2){
		levelUrl = "<%=basePath%>/imgs/star-level-2.png";
	}else if(Math.floor(level/30) == 3){
		levelUrl = "<%=basePath%>/imgs/star-level-3.png";
	}
	
	userLevel.setAttribute("src",levelUrl);
}

//签到功能
function sign(){
	var url = "<%=basePath%>/servlet/SignServlet";
	$.get(url,function(data,status){
		alert(data);
	});
}

var setting = {
	init : function(){
		checkRadio();
		setSelectedOption("grade", <%=user.getGrade()%>);
		setSelectedOption("banji", <%=user.getBanji()%>);
		setSelectedOption("star-select","<%=user.getStar()%>");
		setUserPhoto();
		setUserLevel();	
	}
}