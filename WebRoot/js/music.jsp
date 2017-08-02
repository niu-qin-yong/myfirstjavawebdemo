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

//获取所有音乐
MusicService ms = new MusicServiceImpl();
List<Music> musics = ms.getAllMusic();
String muscisJson = JSON.toJSONString(musics);
%>

var player = {
	  curMusic : null,
	  paused : false,
	  list : [],
	  audio : document.getElementById('player'),
	  init : function(){
	    var self = this;
	    console.log('<%=muscisJson%>')
	    self.list = JSON.parse('<%=muscisJson%>');
	    self.createMusicNodeEle(self.list,"music-content","music-list");
	    self.updateView(self.list,"music-list");          //更新歌曲信息
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
	  },
	  updateView : function(source,subDivClassName){
	    var self = this;
	    var elements = document.querySelectorAll('.'+subDivClassName);
	    for(var i = 0;i < elements.length;i++){
	    	console.log("updateView "+elements[i].dataset.id);
	    
	      var msg = self.find(source,elements[i].dataset.id);
	      elements[i].children[0].innerHTML=msg.title;
	      elements[i].children[1].style.backgroundImage = "url("+msg.poster+")";
	      //绑定播放按钮的事件
	      elements[i].children[4].onclick = function(){
	        self.bind(this);
	        if(self.curMusic == null || self.curMusic != this){
	          self.audio.src = "<%=basePath%>"+"/servlet/MusicServlet?name="+self.find(source,this.parentNode.dataset.id).music;
	        }else{
	          self.musicControl();
	        }
	        self.curMusic = this;
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
				  
				var content = $("#"+containerId);
				console.log(content);
				
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
				item.append(like);
				
				var control = $("<div></div>");
				control.attr("class","music-control");
				item.append(control);
			}
			
		},
		showAllMusic : function(){
			$("#music-search").css("display","none");
			$("#music-content").css("display","block");
		},
		showSearchMusic : function(){
			$("#music-content").css("display","none");
			$("#music-search").css("display","block");
		},
		searchMusic : function(){
			//AJAX获取搜索的音乐
			var self = this;
			var key = $("#music_search_input").val();
			console.log("searchMusic key:"+key);
			var url = "<%=basePath%>/servlet/MusicSearchServlet?key="+key;
			$.get(url,function(data,state){
				console.log("searchMusic data:"+data);
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
				 	console.log("searchMusic "+elements[i].dataset.id);
				 }
				 
				//更新界面
				self.updateView(musics,"search-list");
				//显示搜索界面
				self.showSearchMusic();	
			});
		},
		showRelay : function(ele){
			//获取元素的相对位置，距离浏览器窗体左上角的位置
			var left = ele.getBoundingClientRect().left;
			var top =ele.getBoundingClientRect().top;
			
			//页面的垂直滚动距离
			var scrollTop = document.body.scrollTop;  
			
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
		hideRelay : function(){
			var jia = $("#jiathis");
			jia.css("display","none");
		}
}