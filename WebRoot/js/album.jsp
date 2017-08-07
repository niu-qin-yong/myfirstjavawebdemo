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

//获取相册包含的图片
PictureService picService = new PictureServiceImpl();
for(int i=0;i<allAlbums.size();i++){
	Album album = allAlbums.get(i);
	List<Picture> pics = picService.getPictures(album);
	album.setPics(pics);
}

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
		list.attr("id",albumObj.id);
		list.attr("class","album-list");
		list.attr("title","浏览相册"); 
		//图片路径  pictures/1-2-xx.png  userid-albumid-picname.png
		if(albumObj.pics != null && albumObj.pics != undefined && albumObj.pics.length != 0){
			//取第一张图片做封面
			var picPath = albumObj.userId+"-"+albumObj.id+"-"+albumObj.pics[0].name;
			//显示封面
			list.css("backgroundImage","url(<%=basePath%>/pictures/"+picPath+")");
		}else{
			//显示默认封面
			list.css("backgroundImage","url(<%=basePath%>/imgs/default-photo.png)");
		}
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
			
			//哪个用户的哪个相册
			formData.append("userId","<%=user.getId()%>");
			formData.append("albumId",albumObj.id);
			formData.append("albumName",albumObj.name);
			
			//获取选择的图片
			var files = $(this)[0].files;
			for(var i = 0;i < files.length;i++){
				var file = files[i];
				formData.append($(this).attr("name"),file);
			}
			
			//AJAX异步上传图片
			$.ajax({
			         url:"<%=basePath%>/servlet/AlbumUploadServet",
			         type:"post",
			         async: false,//同步 ，true 异步，默认异步
			         data : formData,
			         // 告诉jQuery不要去处理发送的数据
			         processData : false,
			         // 告诉jQuery不要去设置Content-Type请求头
			         contentType : false,
			         success:function(data,status){
			         	var obj = JSON.parse(data);
			         	console.log("上传图片成功后，服务端返回的数据："+data);
			         	 
						//更新封面
						//取第一张图片做封面
						var picPath = obj.userId+"-"+obj.id+"-"+obj.pics[0].name;
						//显示封面
						$("#"+obj.id).css("backgroundImage","url(<%=basePath%>/pictures/"+picPath+")");
						
						//神奇的地方
						albumObj = obj;

						if(status == "success"){
							alert("恭喜，上传成功!");
						}
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
			if(albumObj.pics == undefined || albumObj.pics == null || albumObj.pics.length == 0){
				alert("没有照片可以浏览！\n亲，请上传你的玉照吧！");
				return;
			}
			
			album.createBrowserNodeEleAndShow(albumObj);
			//$("#album-brower").modal('show');
		});
		list.append(browerOpt);
		
		var nameSpan = $("<span></span>");
		nameSpan.attr("id","name"+albumObj.id);
		nameSpan.attr("class","album-name");
		nameSpan.html(albumObj.name);
		list.append(nameSpan);				
	},
	//创建浏览相册需要的DOM，并显示模态框
	createBrowserNodeEleAndShow : function(obj){
		console.log("createBrowserNodeEleAndShow "+JSON.stringify(obj));
		
		var ul = $("#pictures-container");
		//先清除之前的DOM
		ul.empty();
				
		//创建新的
		var picsArray = obj.pics;
		for(var i=0;i < obj.pics.length;i++){
			var picObj = obj.pics[i];
			var li = $("<li></li>");
			ul.append(li);
			var img = $("<img />");
			li.append(img);
			//原图
			img.attr("data-original","<%=basePath%>/pictures/"+picObj.userId+"-"+picObj.albumId+"-"+picObj.name);
			//缩略图
			img.attr("src","<%=basePath%>/pictures/"+picObj.userId+"-"+picObj.albumId+"-"+picObj.name);
			img.attr("alt",picObj.name);
		}
		
		//显示模态框
		$("#album-brower").modal('show');
		
		//填充了图片后再创建Viewer对象才有效
		this.initViewer();
	},
	//初始化相册
	initAlbum : function(){
		for(var i=0;i < albumArray.length;i++){
			var albumObj = albumArray[i];
			this.createEleNode(albumObj);	
		}
		
	},
	//初始化Viewer
	initViewer : function(){
		var options = {
			url: 'data-original',
	        build: function (e) {
	          console.log(e.type);
	        },
	        built: function (e) {
	          console.log(e.type);
	        },
	        show: function (e) {
	          console.log(e.type);
	        },
	        shown: function (e) {
	          console.log(e.type);
	        },
	        hide: function (e) {
	          console.log(e.type);
	        },
	        hidden: function (e) {
	          console.log(e.type);
	        },
	        view: function (e) {
	          console.log(e.type);
	        },
	        viewed: function (e) {
	          console.log(e.type);
	        }			
		};
		
		var galley = document.getElementById('galley');
		var viewer = new Viewer(galley,options);	
	}
}

window.addEventListener('DOMContentLoaded', function () {
	
	$('#album-brower').on('shown.bs.modal', function () {
	 	console.log("shown.bs.modal");
	 }).on('hidden.bs.modal', function () {
	 	console.log("hidden.bs.modal");
     });

});

