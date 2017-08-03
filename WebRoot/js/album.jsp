<%@ page contentType="text/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.it61.minecraft.bean.*"%>
<%@page import="com.it61.minecraft.service.*"%>
<%@page import="com.it61.minecraft.service.impl.*"%>
<%@page import="com.alibaba.fastjson.*" %>
<%@page import="com.alibaba.fastjson.serializer.*" %>
<%@page import="java.sql.*" %>

<%
//jsp脚本
%>

var album = {
	//创建相册DOM
	createListEle : function(containerId){
		//DOM
		var container = $("#"+containerId);
		
		var list = $("<div></div>");
		list.attr("class","album-list");
		list.attr("title","浏览相册"); 
		list.on("click",this.browseAlbum);
		container.append(list);
		
		var nameSpan = $("<span></span>");
		nameSpan.attr("class","album-name");
		nameSpan.html("你好");
		list.append(nameSpan);
		
		//数据
		var name = $("#ablum-name").val();
		var des = $("#ablum-des").val();
	},
	//上传图片
	uploadPics : function(){
		alert("uploadPics");
	},
	//缩略图浏览
	browseAlbum : function(){
		$("#album-brower").modal('show');
	}
}

window.addEventListener('DOMContentLoaded', function () {
	 var galley = document.getElementById('galley');
	 var viewer;
	
	 $('#album-brower').on('shown.bs.modal', function () {
	   viewer = new Viewer(galley, {
	     url: 'data-original',
	   });
	 });
});