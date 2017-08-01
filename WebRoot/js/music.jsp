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
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webName+"/";

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
	    self.showMusics();
	    self.updateView();          //更新歌曲信息
	  },
	  updateView : function(){
	    var self = this;
	    var elements = document.querySelectorAll('.music-list');
	    for(var i = 0;i < elements.length;i++){
	      var msg = self.list[i];
	      elements[i].children[0].innerHTML=msg.title;
	      elements[i].children[1].style.backgroundImage = "url("+msg.poster+")";
	      //绑定播放按钮的事件
	      elements[i].children[4].onclick = function(){
	        self.bind(this);
	        if(self.curMusic == null || self.curMusic != this){
	          self.audio.src = "<%=basePath%>"+"servlet/MusicServlet?name="+self.find(this.parentNode.dataset.id).music;
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
	  find : function(id){
	    var self = this;
	    for(var i = 0;i < self.list.length;i++){
	      if(self.list[i].id == id){
	        return self.list[i];
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
	  createMusicNodeEle : function(musicJson){ //创建一首音乐对应的DOM
			var content = $("#music-content");
			
			var item = $("<div></div>");
			item.attr("class","music-list");
			item.attr("data-id",musicJson.id);
			content.append(item);
	
			var span = $("<span></span>");
			item.append(span);
			
			var poster = $("<div></div>");
			poster.attr("class","music-poster");
			item.append(poster);
			
			var share = $("<div></div>");
			share.attr("class","music-share");
			item.append(share);
			
			var like = $("<div></div>");
			like.attr("class","music-like");
			item.append(like);
			
			var control = $("<div></div>");
			control.attr("class","music-control");
			item.append(control);
			
		},
		showMusics : function(){ //创建所有音乐的DOM
			var self = this;
			for(var i = 0;i < self.list.length;i++){
				self.createMusicNodeEle(self.list[i]);
			}
		}
}