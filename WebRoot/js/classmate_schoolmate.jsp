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


//获取所有好友
FriendService friService = new FriendServiceImpl();
List<Friend> allFriends = friService.getAllFriends(user);

UserServiceImpl service = new UserServiceImpl();
List<User> classmates = service.getClassmates(user);

%>

/**
*从好友界面移除好友
**/
function removeEleFromFriends(friId){
	var parent = document.getElementById("friendcontent");
	var child = document.getElementById("fri"+friId);
	parent.removeChild(child);
}

/**
*添加好友到好友界面
**/
function addEleFromFriends(friId,friName){
	var friendee=document.createElement("div");
	friendee.setAttribute("class","friendee");
	friendee.setAttribute("id","fri"+friId);
	
	var gfriendphoto=document.createElement("div");
	gfriendphoto.setAttribute("class","gfriendphoto");
	gfriendphoto.style.backgroundImage="url(<%=basePath%>/servlet/ShowPicServlet?id="+friId+")";	
	friendee.appendChild(gfriendphoto);
	
	var gfriendname=document.createElement("div");
	gfriendname.setAttribute("class","gfriendname");
	gfriendname.innerHTML = friName;
	friendee.appendChild(gfriendname);
	
	var gfriendchat=document.createElement("div");
	gfriendchat.setAttribute("class","gfriendchat");
	gfriendchat.setAttribute("onclick","javascript:chat(\"<%=user.getId()%>\","+friId+")");
	<%-- gfriendchat.setAttribute("onclick","javascript:chat('<%=user.getId()%>',"+friId+")"); --%>
	gfriendchat.innerHTML = "聊天";
	friendee.appendChild(gfriendchat);
	
	var parent = document.getElementById("friendcontent");
	parent.appendChild(friendee);
}

/**
*显示校友录
**/		
function showSchoolmates(){
	<%
	List<User> schoolmates = service.getAllUsers();
	
	System.out.println("showSchoolmates size:"+schoolmates.size());
	
	for(int i=0;i<schoolmates.size();i++){
		User smate = schoolmates.get(i);
	%>		
	var schoolfee=document.createElement("div");
	schoolfee.setAttribute("class","schoolfee");
	
	var schoolephoto=document.createElement("div");
	schoolephoto.setAttribute("class","schoolephoto");
	schoolephoto.style.backgroundImage="url(<%=basePath%>/servlet/ShowPicServlet?id="+<%=smate.getId()%>+")";	
	schoolfee.appendChild(schoolephoto);
	
	var schoolename=document.createElement("div");
	schoolename.setAttribute("class","schoolename");
	schoolename.innerHTML = "<%=smate.getUserName()%>";
	schoolfee.appendChild(schoolename);
	
	var schoolenclass=document.createElement("div");
	schoolenclass.setAttribute("class","schoolenclass");
	schoolenclass.innerHTML = "<%=smate.getGrade()%>"+"年"+"<%=smate.getBanji()%>"+"班";
	schoolfee.appendChild(schoolenclass);
	
	var parent = document.getElementById("schoolfees");
	parent.appendChild(schoolfee);
	
	<%
	}
	%>
}

/**
*显示班级同学
**/
function showClassmates(){
	<%

	
	for(int i=0;i<classmates.size();i++){
		User mate = classmates.get(i);
		
	%>
		/* 创建代表一个好友的div */
		var classmatee=document.createElement("div");
		classmatee.setAttribute("class","classmatee");
		
		var rank = <%=i%>;
		var jiangpai=document.createElement("div");
		jiangpai.setAttribute("class","jiangpai");
		if(rank==0){
			//gold
			jiangpai.style.backgroundImage="url("+basePath+"imgs/golden.png)";
		}else if(rank==1){
			//silver
			jiangpai.style.backgroundImage="url("+basePath+"imgs/sliver.png)";
		}else if(rank==2){
			//copper
			jiangpai.style.backgroundImage="url("+basePath+"imgs/tong.png)";
		}
		
		var classmatephoto=document.createElement("div");
		classmatephoto.setAttribute("class","classmatephoto");
		classmatephoto.style.backgroundImage="url(<%=basePath%>/servlet/ShowPicServlet?id="+<%=mate.getId()%>+")";	
		
		var classmatename=document.createElement("div");
		classmatename.setAttribute("class","classmatename");
		classmatename.innerHTML = "<%=mate.getUserName()%>";
		
		var classmatecaozuo=document.createElement("div");
		classmatecaozuo.setAttribute("class","classmatecaozuo");
		
		//在自己的条目后面不显示添加好友的按钮
		if(<%=user.getId()%> != <%=mate.getId()%>){
			var addfriend=document.createElement("a");
			addfriend.setAttribute("href","javascript:;");

			if(isFriend(<%=mate.getId()%>)){
				//如果是好友，取消好友
				addfriend.setAttribute("title","取消好友");
				addfriend.setAttribute("data-friId",<%=mate.getId()%>);
				addfriend.style.backgroundImage="url("+basePath+"imgs/removefriend.png)";
				addfriend.setAttribute("onclick","removeFriend(this)");
			}else{
				//如果不是好友，添加好友
				addfriend.setAttribute("title","添加好友");
				addfriend.setAttribute("data-friId",<%=mate.getId()%>);
				addfriend.setAttribute("data-friName","<%=mate.getUserName()%>");
				addfriend.setAttribute("onclick","addFriend(this)");
			}
			classmatecaozuo.appendChild(addfriend);
		}
		
		classmatee.appendChild(jiangpai);
		classmatee.appendChild(classmatephoto);
		classmatee.appendChild(classmatename);
		classmatee.appendChild(classmatecaozuo);
		
		/* 将好友div添加到父元素中 */
		var parent = document.getElementById("classmate");
		parent.appendChild(classmatee);
	<%	
		}
	%>
}

/**
*添加好友，friendId是好友id
**/
function addFriend(a){
	var friId = a.getAttribute("data-friId");
	var friName = a.getAttribute("data-friName");
	
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function(){
       if(xmlhttp.readyState==4 && xmlhttp.status == 200){
    	   if(xmlhttp.responseText == "add_friend_ok"){
     	    a.style.backgroundImage="url("+basePath+"imgs/removefriend.png)";
			a.setAttribute("title","移除好友");
			a.setAttribute("data-friId",a.getAttribute("data-friId"));
			a.setAttribute("onclick",'removeFriend(this)');  
		
			//更新好友界面
			addEleFromFriends(a.getAttribute("data-friId"),a.getAttribute("data-friName"));
    	   }
       }
    }
    xmlhttp.open("post",basePath+"servlet/AddFriendServlet",true);
    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlhttp.send("friendId="+friId+"&friendName="+friName);
}

/**
*判断是否相互是好友
**/
function isFriend(friendId){
	<%	for(Friend fri:allFriends){ %>
	
		if(friendId == <%=fri.getFriId()%>){
			return true;
		}
			
	<%}%>
	return false;
}

/**
*移除好友关系
**/
function removeFriend(a){
	var owerId = "<%=user.getId()%>";
	var friId = a.getAttribute("data-friId");
	
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function(){
       if(xmlhttp.readyState==4 && xmlhttp.status == 200){
    	   if(xmlhttp.responseText == "remove_friend_ok"){
     	    a.style.backgroundImage="url("+basePath+"imgs/jiafriend.png)";
	a.setAttribute("title","添加好友");
	a.setAttribute("onclick",'addFriend(this)'); 
	
	//更新好友界面
	removeEleFromFriends(a.getAttribute("data-friId"));
    	   }
       }
    }
    xmlhttp.open("post",basePath+"servlet/RemoveFriendServlet",true);
    xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlhttp.send("owerId="+owerId+"&friId="+friId);			
}