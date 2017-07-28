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

//获取所有好友
FriendService friService = new FriendServiceImpl();
List<Friend> allFriends = friService.getAllFriends(user);

//获取所有在线用户
ArrayList<User> onlineUsers = (ArrayList<User>)getServletContext().getAttribute("online_users");

//获取在线好友
List<Friend> onlineFriends = new ArrayList<Friend>();
for(Friend fri : allFriends){
	for(User u : onlineUsers){
		if(fri.getFriId() == u.getId()){
			onlineFriends.add(fri);
		}
	}
}
%>

/**
*好友
**/		
function showFriends(){
	<%
	List<Friend> friends = allFriends;
	
	for(int i=0;i<friends.size();i++){
		Friend fri = friends.get(i);
	%>
	
	var friendee=document.createElement("div");
	friendee.setAttribute("class","friendee");
	friendee.setAttribute("id","fri"+"<%=fri.getFriId()%>");
	
	var gfriendphoto=document.createElement("div");
	gfriendphoto.setAttribute("class","gfriendphoto");
	gfriendphoto.style.backgroundImage="url(/minecraft/servlet/ShowPicServlet?id="+<%=fri.getFriId()%>+")";	
	friendee.appendChild(gfriendphoto);
	
	var gfriendname=document.createElement("div");
	gfriendname.setAttribute("class","gfriendname");
	gfriendname.innerHTML = "<%=fri.getFriName()%>";
	friendee.appendChild(gfriendname);
	
	var gfriendchat=document.createElement("div");
	gfriendchat.setAttribute("class","gfriendchat");
	gfriendchat.innerHTML = "聊天";
	gfriendchat.setAttribute("onclick","javascript:chat('<%=user.getId()%>','<%=fri.getFriId()%>')");
	friendee.appendChild(gfriendchat);
	
	var parent = document.getElementById("friendcontent");
	parent.appendChild(friendee);

	<%
	}
	%>			
}

/**
*在线好友泡泡的随机left值
**/
function getRandomLeft(index){
	var rand = Math.random();
	var left;
	if(index%2 != 0){
		//1,3,5
		left = (Math.pow(rand,3)*20)+"px";
	}else{
		//2,4,6
		left = (Math.pow(rand,3)*80)+"px";
	}
	return left;
}

/* 显示在线好友 */
function showOnlineFriends(){
	<%
		for(int i=0;i<onlineFriends.size();i++){
	%>
	var friendOn=document.createElement("div");
	friendOn.setAttribute("class","friendOn");
	friendOn.setAttribute("title","<%=onlineFriends.get(i).getFriName()%>");
	friendOn.style.backgroundImage="url(/minecraft/servlet/ShowPicServlet?id=<%=onlineFriends.get(i).getFriId()%>),url(/minecraft/imgs/pop.jpg)";	
	friendOn.style.left=getRandomLeft(<%=i%>);
	friendOn.style.top=(<%=i%>*80)+"px";
	
	var parent = document.getElementById("friendsOnline");
	parent.appendChild(friendOn);
	<%
		}
	%>
}