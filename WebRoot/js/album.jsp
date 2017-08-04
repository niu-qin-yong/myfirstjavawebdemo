<%@ page contentType="text/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.it61.minecraft.bean.*"%>
<%@page import="com.it61.minecraft.service.*"%>
<%@page import="com.it61.minecraft.service.impl.*"%>
<%@page import="com.alibaba.fastjson.*" %>
<%@page import="com.alibaba.fastjson.serializer.*" %>
<%@page import="java.sql.*" %>

<%
User user = (User)session.getAttribute("user");
String webName = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webName;

//获取所有相册
AlbumService service = new AlbumServiceImpl();
List<Album> allAlbums = service.getAllAlbums(user.getId());

JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd hh:mm:ss"; 
String allAlbumsJsonString = JSON.toJSONString(allAlbums,SerializerFeature.WriteDateUseDateFormat);
%>
var albumArray = JSON.parse('<%=allAlbumsJsonString%>');

var album = {
	//创建相册
	createAlbum : function(){
		var self = this;
		//数据
		var name = $("#album-create-name").val();
		var des = $("#album-create-des").val();
		
		$.post(
			"<%=basePath%>"+"/servlet/CreateAlbumServlet",
			{"name":name,"des":des},
			function(data,status){
				if(status != "success"){
					alert("对不起，创建相册失败！");
					return;
				}
				
				var albumObj = JSON.parse(data);
				self.createEleNode(albumObj);	
			}
		);

	},
	
	//创建一个相册对应的DOM
	createEleNode : function(albumObj){
		var container = $("#album-content");
		
		var list = $("<div></div>");
		list.attr("class","album-list");
		list.attr("title","浏览相册"); 
		//list.css("backgroundImage","url(<%=basePath%>/imgs/cover-default.png)");
		list.on("mouseover",function(event){
			//显示选项
			var opts = $(".opt"+albumObj.id);
			for(var i=0;i < opts.length;i++){
				$(opts[i]).css("display","block");
			}
			
			//隐藏相册名
			$("#name"+albumObj.id).css("display","none");		
		});
		list.on("mouseout",function(event){
			var opts = $(".opt"+albumObj.id);
			for(var i=0;i < opts.length;i++){
				$(opts[i]).css("display","none");
			}
			
			//显示相册名
			$("#name"+albumObj.id).css("display","block");		
		});
		container.append(list);
		
		var uploadOpt = $("<div></div>");
		uploadOpt.attr("href","javascript:;");
		uploadOpt.attr("class","album-upload"+" opt"+albumObj.id);
		uploadOpt.css("display","none");
		uploadOpt.html("上传图片");
		list.append(uploadOpt);
		
		var input = $("<input />");
		input.attr("name","album-pictures");
		input.attr("type","file");
		input.attr("accept","image/png,image/jpg");
		input.attr("multiple","multiple");
		input.on("change",function(event){
			// 实例化一个表单数据对象
			var formData = new FormData();
			
			//获取选择的图片
			var files = $(this)[0].files;
			for(var i = 0;i < files.length;i++){
				var file = files[i];
				formData.append($(this).attr("name"),file);
			}
			
			$.ajax({
			         url:"<%=basePath%>/AlbumUploadServet",
			         type:"post",
			         async: false,//同步 ，true 异步，默认异步
			         data : formData,
			         // 告诉jQuery不要去处理发送的数据
			         processData : false,
			         // 告诉jQuery不要去设置Content-Type请求头
			         contentType : false,
			         success:function(data,status){
			             alert(data+"\n"+status)
			         },
			         error:function(data,status){
			             alert(data+"========"+status)
			         }
			    })
			
		});
		uploadOpt.append(input);
		
		var browerOpt = $("<span></span>");
		browerOpt.attr("class","album-brower");
		browerOpt.addClass("opt"+albumObj.id);
		browerOpt.css("display","none");
		browerOpt.html("浏览相册");
		browerOpt.on("click",function(event){
			$("#album-brower").modal('show');
		});
		list.append(browerOpt);
		
		var nameSpan = $("<span></span>");
		nameSpan.attr("id","name"+albumObj.id);
		nameSpan.attr("class","album-name");
		nameSpan.html(albumObj.name);
		list.append(nameSpan);				
	},
	//初始化相册
	initAlbum : function(){
		for(var i=0;i < albumArray.length;i++){
			var albumObj = albumArray[i];
			this.createEleNode(albumObj);	
		}
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