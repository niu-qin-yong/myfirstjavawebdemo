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

//获取音乐馆歌曲
MusicService ms = new MusicServiceImpl();
List<Music> musics = ms.getSystemMusic();
String muscisJson = JSON.toJSONString(musics);

//获取我的音乐
List<Music> mineMusics = ms.getMineMusic(user.getId());
String mineMusicsJsonString = JSON.toJSONString(mineMusics);

//获取好友音乐
FriendService friService = new FriendServiceImpl();
List<Friend> allFriends = friService.getAllFriends(user);
List<Integer> friendIds = new ArrayList<Integer>();
for(Friend friend : allFriends){
	friendIds.add(friend.getFriId());
}
List<Music> friendMusics = ms.getFriendMusic(friendIds);
String friendMusicsJsonString = JSON.toJSONString(friendMusics);
%>

var musicAlreadyUsedSize = 0;

var player = {
	  curMusic : null,
	  paused : false,
	  list : [],
	  audio : document.getElementById('player'),
	  init : function(){
	    var self = this;
	    console.log('<%=muscisJson%>')
	    self.list = JSON.parse('<%=muscisJson%>');
	    
	    //初始化音乐馆
	    self.createMusicNodeEle(self.list,"music-content","music-list");
	    //更新歌曲信息
	    self.updateView(self.list,"music-list");       
	    
	    //初始化我的音乐   
	    var mineOjbs = JSON.parse('<%=mineMusicsJsonString%>');
	    self.createMusicNodeEle(mineOjbs,"music-mine","music-mine-list");
	    self.updateView(mineOjbs,"music-mine-list");       
	    
	    //初始化好友音乐   
	    var friendOjbs = JSON.parse('<%=friendMusicsJsonString%>');
	    self.createMusicNodeEle(friendOjbs,"music-friend","music-friend-list");
	    self.updateView(friendOjbs,"music-friend-list");       
	    
	    //监听搜索框
		$("#music_search_input")[0].onkeydown = function(event) {
			if (event.keyCode == 13) {
				self.searchMusic();
			}
		}	
		//给转发按钮设置鼠标滑入划出事件
		var jia = $("#jiathis");
		jia.attr("onmouseover",'javascript:$("#jiathis").css("display","block");');
		jia.attr("onmouseout",'javascript:$("#jiathis").css("display","none");');
		//默认转发按钮不显示
		self.hideRelay();   
		
		//异步获取音乐存储空间大小
		self.obtainMusicSize();
	
	  },
 		//获取相册已用存储空间
		obtainMusicSize : function(){
			$.ajax({
			        url:"<%=basePath%>/servlet/ObtainSaveSizeServlet?userId="+<%=user.getId()%>+"&type=music",
			        type:"get",
			        async:true,//异步
			        success:function(data,status){
			        	var obj = JSON.parse(data);
			        	musicAlreadyUsedSize = obj.size;
			        	console.log("musicAlreadyUsedSize:"+musicAlreadyUsedSize);
			        },
			        error:function(data,status){
			        	musicAlreadyUsedSize = -1;
			        }
		    });
		},
	  updateView : function(source,subDivClassName){
	    var self = this;
	    var elements = document.querySelectorAll('.'+subDivClassName);
	    for(var i = 0;i < elements.length;i++){
	    
	      var msg = self.find(source,elements[i].dataset.id);
	      if(msg != null && msg != undefined){
		      elements[i].children[0].innerHTML=msg.title;
		      elements[i].children[1].style.backgroundImage = "url("+msg.poster+")"; 
		      //绑定播放按钮的事件
		      elements[i].children[4].onclick = function(){
		        self.bind(this);
		        if(self.curMusic == null || self.curMusic != this){
		          <%-- self.audio.src = "<%=basePath%>"+"/servlet/MusicServlet?name="+self.find(source,this.parentNode.dataset.id).music; --%>
		          self.audio.src = "<%=basePath%>/"+self.find(source,this.parentNode.dataset.id).music;
		        }else{
		          self.musicControl();
		        }
		        self.curMusic = this;
		      }
	      }
	    }
	  },
	  //音乐的播放和暂停控制
	  musicControl : function(){
	    var self = this;
	    if(self.paused){
	      self.paused = false;
	      self.audio.play();
	    }else{
	      self.paused = true;
	      self.audio.pause();
	    }
	  },
	  //根据key值查找对应的音乐信息
	  find : function(source,id){
	    for(var i = 0;i < source.length;i++){
	      if(source[i].id == id){
	        return source[i];
	      }
	    }
	  },
	  bind : function(ele){
	    var self = this;
	    //重新绑定事件之前将所有的按钮重置
	    var elements = document.querySelectorAll('.music-control');
	    for(var i = 0;i < elements.length;i++){
	      elements[i].className = "music-control";
	      elements[i].parentNode.children[1].className = "music-poster";
	    }
	    //audio的play和pause事件
	    self.audio.onplay = function(){
	      ele.className = "music-control music-play";
	      ele.parentNode.children[1].className = "music-poster poster-rotate";
	    }
	    self.audio.onpause = function(){
	      ele.className = "music-control";
	      ele.parentNode.children[1].className = "music-poster";
	    }
	  },
	  //参数jsons：要显示的音乐数据，json格式
	  //参数containerId：DOM将要添加到的父元素ID，music-content或者music-search
	  //参数subClassName：子div的class名称，music-list或者search-list
	  createMusicNodeEle : function(jsons,containerId,subClassName){ //创建一首音乐对应的DOM
	  	var self = this;
			for(var i = 0;i < jsons.length;i++){
				var musicJson = jsons[i];
				
				console.log("musicJson",musicJson);
				  
				var content = $("#"+containerId);
				
				var item = $("<div></div>");
				item.attr("class",subClassName);
				item.attr("data-id",musicJson.id);
				item.attr("data-music-name",musicJson.title);
				content.append(item);
		
				var span = $("<span></span>");
				item.append(span);
				
				var poster = $("<div></div>");
				poster.attr("class","music-poster");
				item.append(poster);
				
				var share = $("<div></div>");
				share.attr("class","music-share");
				share.attr("id","share"+musicJson.id);
				share.attr("onmouseover","player.showRelay(this)");
				share.attr("onmouseout","player.hideRelay()");
				item.append(share);
				
				var like = $("<div></div>");
				like.attr("class","music-like");
				like.attr("data-like-value",musicJson.likeCount+"喜欢");
				//给点赞按钮设置鼠标滑入划出事件
				like.attr("onmouseover",'player.showLike(this)');
				like.attr("onmouseout",'player.hideLike()');
				like.attr("onclick",'player.addLike(this)');
				item.append(like);
				
				var control = $("<div></div>");
				control.attr("class","music-control");
				item.append(control);
			}
			
		},
		//显示ID是conatinerId的div，并隐藏其他div
		showMusics : function(conatinerId){
			var divs = $(".music-container");
			for(var i=0;i < divs.length;i++){
				var container = $(divs[i]);
				if(container.attr("id") == conatinerId){
					container.css("display","block");
				}else{
					container.css("display","none");
				}
			}
		},
		searchMusic : function(){
			//AJAX获取搜索的音乐
			var self = this;
			var key = $("#music_search_input").val();
			//console.log("searchMusic key:"+key);
			var url = "<%=basePath%>/servlet/MusicSearchServlet?key="+key;
			$.get(url,function(data,state){
				//console.log("searchMusic data:"+data);
				var musics = JSON.parse(data);
				if(musics.length == 0){
					alert("对不起，没有找到您要的歌曲，试试其他关键字搜索吧！");
					return;
				}
			
				var json = '[{"id":1,"music":"audio/Faded.mp3","poster":"poster/faded.jpg","title":"Faded"},{"id":3,"music":"audio/成都.mp3","poster":"poster/cd.jpg","title":"成都"}]';
				
				
				//把之前搜索界面的DOM移除
				$('#music-search').empty();
				//创建新的DOM
				self.createMusicNodeEle(musics,"music-search","search-list");
				
				var elements = document.querySelectorAll('.search-list');
				 for(var i = 0;i < elements.length;i++){
				 	//console.log("searchMusic "+elements[i].dataset.id);
				 }
				 
				//更新界面
				self.updateView(musics,"search-list");
				//显示搜索界面
				self.showMusics("music-search");	
			});
		},
		showRelay : function(ele){
			//获取元素的相对位置，距离浏览器窗体左上角的位置
			var left = ele.getBoundingClientRect().left;
			var top =ele.getBoundingClientRect().top;
			
			//页面的垂直滚动距离
			//var scrollTop2 = document.body.scrollTop;  //为什么下面的可以，而这行的不行
			var scrollTop = document.documentElement.scrollTop;  

			//设置转发DOM的位置
			var topOffset = 15;
			var jia = $("#jiathis");
			jia.css("position","absolute");
			jia.css("left",left);
			jia.css("top",top+scrollTop+topOffset);
			
			//显示
			jia.css("display","block");
			
			//修改转发配置变量的title值
			var musicName = ele.parentNode.dataset.musicName;
			jiathis_config.title = "我正在听《"+musicName+"》，不得不说真的很好听~";
		},
		hideRelay : function(ele){
			var jia = $("#jiathis");
			jia.css("display","none");
		},
		showLike : function(ele){
			//获取元素的相对位置，距离浏览器窗体左上角的位置
			var left = ele.getBoundingClientRect().left;
			var top =ele.getBoundingClientRect().top;
			
			//页面的垂直滚动距离
			var scrollTop = document.documentElement.scrollTop;	
			
			//设置DOM的位置
			var topOffset = -20;
			var count = $("#like-count");
			count.css("position","absolute");
			count.css("left",left);
			count.css("top",top+scrollTop+topOffset);
			
			//设置点赞数
			var value = ele.dataset.likeValue;
			count.html(value);
			
			//显示
			count.css("display","block");
		},
		hideLike : function(){
			var count = $("#like-count");
			count.css("display","none");
		},
		addLike : function(ele){
			//1.先修改前端界面
			var oldValue = ele.dataset.likeValue;
			
			var end = oldValue.indexOf("喜欢");
			var oldCount = oldValue.substring(0,end);
			var newCount = Number(oldCount)+Number(1);
			
			var count = $("#like-count");
			count.html(newCount+"喜欢");
			
			$(ele).attr("data-like-value",newCount+"喜欢");
			
			//2.提交服务器修改数据库中的值
			var musicId = ele.parentNode.dataset.id;
			var url = "<%=basePath%>/servlet/AddMusicLikeServlet?id="+musicId+"&count="+newCount;
			$.get(url,function(data,state){
				
			});
		}
}

//上传音乐
function onMusicUpload(){
	//检查数据正确性
	var singer = $("#music-upload-singer").val();
	if(singer == "" || singer == null || singer == undefined){
		alert("亲，歌手必须得填呢");
		return;
	}
	var audioFiles = $("#music-upload-audio")[0].files;
	if(audioFiles.length == 0){
		alert("亲，要上传的音乐呢");
		return;
	} 
	var posterFiles = $("#music-upload-poster")[0].files;
	if(posterFiles.length == 0){
		alert("亲，音乐封面给传一张呗");
		return;
	} 
	
	// 实例化一个表单数据对象
	var formData = new FormData();
	
	//哪个用户上传
	formData.append("userId","<%=user.getId()%>");
	//歌手
	formData.append("singer",singer);
	
	//音乐文件
	var audioFile = audioFiles[0];
	formData.append("music-cover",audioFile);
	//封面
	var posterFile = posterFiles[0];
	formData.append("music-audio",posterFile);
	
	//上传文件总大小限制
	console.log("上传音乐文件大小:"+audioFile.size);
	console.log("上传音乐封面大小:"+posterFile.size);
	
	if(musicAlreadyUsedSize == -1){
		alert("抱歉,从服务器获取音乐存储空间大小失败");
		return;
	}
	//图片最大存储空间大小15M
	var totalSize = audioFile.size + posterFile.size;
	var available = 15*1024*1024-musicAlreadyUsedSize;			
	if(totalSize > available){
		alert("抱歉，您的音乐存储空间只剩"+Math.round(available/1024/1024*100)/100+"M,不足以存储现在上传的内容");
		return;
	}	
				
	//AJAX异步上传图片
	$.ajax({
	        url:"<%=basePath%>/servlet/MusicUploadServet",
	        type:"post",
	        async: false,//同步 ，true 异步，默认异步
	        data : formData,
	        // 告诉jQuery不要去处理发送的数据
	        processData : false,
	        // 告诉jQuery不要去设置Content-Type请求头
	        contentType : false,
	        success:function(data,status){
	        	console.log("上传图片成功后，服务端返回的数据："+data);
	        	var musicObj = JSON.parse(data);
	        	var musicObjs = [musicObj];
	        	
	        	player.createMusicNodeEle(musicObjs,"music-mine","music-mine-list");
	        	
	        	//更新界面
				player.updateView(musicObjs,"music-mine-list");
				
				//隐藏音乐上传弹出框
				hideMusicUpload();
				
				//告知用户上传成功
				if(status == "success"){
					alert("恭喜，上传成功!");
				} 
				
				//上传成功后获取最新的存储空间大小
				player.obtainMusicSize();
	        	
	        	 
<%-- 				//更新封面
				//取第一张图片做封面
				var cover = "<%=basePath%>/pictures/"+obj.userId+"/"+obj.id+"/thumb/"+obj.pics[0].name;
				$("#"+obj.id).css("backgroundImage","url("+cover+")");
				
				//神奇的地方
				albumObj = obj;
		
				if(status == "success"){
					alert("恭喜，上传成功!");
				} --%>
	        },
	        error:function(data,status){
	            alert(data+"========"+status)
	        }
	   }) 
}

//显示音乐上传弹出框
function showMusicUpload(){
	$("#music-upload").animate({top:'100px'},300,function(){
		
	});
}
//隐藏音乐上传弹出框
function hideMusicUpload(){
	$("#music-upload").animate({top:'-500px'},300,function(){
		//隐藏后将原有输入数据清空
		$("#music-upload-singer").val("");
		$("#mu-item-hint-audio").html("选择音乐");
		$("#mu-item-hint-poster").html("选择封面");
		
		//将input值置空
		$("#music-upload-audio")[0].value = '';
		$("#music-upload-poster")[0].value = '';
	});	
}
//监听歌曲、封面输入框，内容有变化时显示文件名称
$("#music-upload-poster").on("change",function(event){
	var files = $(this)[0].files;
	if(files.length > 0){
		$("#mu-item-hint-poster").html(files[0].name);
	}else{
		$("#mu-item-hint-poster").html("选择封面");
	}
})
$("#music-upload-audio").on("change",function(event){
	var files = $(this)[0].files;
	if(files.length > 0){
		$("#mu-item-hint-audio").html(files[0].name);
	}else{
		$("#mu-item-hint-audio").html("选择音乐");
	}
})