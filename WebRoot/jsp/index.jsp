<%@ page language="java" import="java.util.*"  pageEncoding="UTF-8"%>
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
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webName+"/";

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

//获取自己及好友的所有动态
//获取自己及好友的id
List<Integer> senderIds = new ArrayList<Integer>();
senderIds.add(user.getId());
for(Friend fri : allFriends){
	senderIds.add(fri.getFriId());
}
//获取首次显示的动态
MomentService momentService = new MomentServiceImpl();
Timestamp time = new Timestamp(System.currentTimeMillis());
List<Moment> moments = momentService.getMomentsPaging(senderIds,time.toString(),3);
//获取动态的点赞
FavorService favorService = new FavorServiceImpl();
for(Moment m : moments){
	m.setFavors(favorService.getAllFavorsByMomentId(m.getId()));
}
//获取动态的留言
CommentService commentService = new CommentServiceImpl();
for(Moment m : moments){
	m.setComments(commentService.getAllCommentsByMomentId(m.getId()));
}
//动态按时间倒序排序
/* Collections.sort(moments, new Comparator<Moment>() {

	@Override
	public int compare(Moment o1, Moment o2) {
		return o2.getStamp().compareTo(o1.getStamp());
	}
}); */
%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>我的主页完整布局</title>
		<link rel="stylesheet" href="css/index.css"/>
		<link rel="stylesheet" type="text/css" href="plugin/kalendae/css/kalendae.css">
		<link rel="stylesheet" href="css/classroom.css">
		<link rel="stylesheet" href="css/schoolfellow.css">
		<link rel="stylesheet" href="css/friend.css">
		<link rel="stylesheet" href="css/chat.css">
	</head>
	<body>
		<!-- 用户登录部分 -->
		<%
		String username = user.getUserName();
		if(username != null){
		%>
		<div>欢迎&nbsp;<b><%=username %></b>&nbsp;<a href="/minecraft/servlet/LogoutServlet">注销</a></div>
		<%}%>
		<!--外部框架-->
		<div id="base">
		<!--头部部分-->
			<header>
				<!--logo部分-->
				<div id="banner">
					<img src="imgs/logo.gif" alt="logo">
				</div>
				<!--顶部导航栏部分-->
				<nav>
					<div id="friendzone0" class="navct">
						<a href="#"> </a>
					</div>
					<div id="photo1" class="navct">
						<a href="#"> </a>
					</div>
					<div id="dairy2" class="navct">
						<a href="#"> </a>
					</div>
					<div id="plan3" class="navct">
						<a href="#"> </a>
					</div>
					<div id="mgame4" class="navct">
						<a href="#"> </a>
					</div>
				</nav>
			</header>
			<!--左边快速导航栏-->
			<aside id="left-side">
				<div id="signIn"> </div>
				<ul id="lnav">
					<li id="friends5" class="lnavc">
						<a href="#" > </a>
					</li>
					<li id="classname6" class="lnavc">
						<a href="#" > </a>
					</li>
					<li id="schoolfellow7" class="lnavc">
						<a href="#" > </a>
					</li>
					<li id="music8" class="lnavc">
						<a href="#" > </a>
					</li>
					<li id="setting9" class="lnavc">
						<a href="#" > </a>
					</li>
				</ul>
			</aside>
			<!--主体内容部分-->
			<section id="contentView">
				<div id="content">
					<div id="friendzone" class="showcontent">
						<div id="send" style="margin-bottom: 10px">
							<form onsubmit="return sendMoment()" id="momentform">
							     <textarea name="moment-text" id="moment" cols="80" rows="3" placeholder="说点什么吧"></textarea>
							     <input type="file" name="moment-pic" id="moment-pic" accept="image/png,image/jpeg"/><br/>
                    			 <input type="submit" value="发表"/>
                    		</form>
						</div>
						<div id="loadmore">
							<button onclick="loadMoreMoments()">点击加载更多</button>
						</div>
					</div>
					<div id="photo" class="showcontent">
						相册
					</div>
					<div id="dairy" class="showcontent">
						<div id="dairyleft">
							<div id="operation">
								<div id="opr-left">
									<span> </span><span> </span>
								</div>
								<div id="opr-right">
									<span> </span><span>草稿箱</span>
									<span> </span><span>回收站</span>
								</div>
							</div>
							<div id="dairycontent">
								<table>
									<tr>
										<td><span>[顶]</span><a href="#">我的新年大计划</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">女生为什么那么喜欢星座</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">科技馆奇妙夜</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">门外的班主任</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">阿里巴巴的秘密</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">12星座谁最具有内在美</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">12月10日</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><span>[转]</span><a href="#">我们怎么才能远离雾霾</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">编程十法&nbsp;</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">00后八大派 你是哪一派？&nbsp;</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><span>[转]</span><a href="#">龙的九个儿子！大家知道几个！</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
								</table>
							</div>
						</div>
						<div id="dairyright">
							<!-- 顶部功能区 搜索+日历 -->
							<div id="newshead">
								<input type="text" value="搜索">
								<div id="calendar">
									
								</div>
							</div>
							<!-- 底部热门消息区 -->
							<div id="newslist">
								<div>
									<img src="imgs/d16.png"/>
									<span>惊吓！在喜马拉雅山上驾车时是一种什么体验</span>
									<br/>
									<p>
										<span> </span>
										<a href="#">感兴趣</a>
										<a href="#">121</a>
									</p>
								</div>
								<div>
									<img src="imgs/d17.png"/>
									<span>气象局停发霾预警？回应：正协商联合发布机制</span>
									<br/>
									<p>
										<span> </span>
										<a href="#">感兴趣</a>
										<a href="#">169</a>
									</p>
								</div>
								<div>
									<img src="imgs/d18.png"/>
									<span>亲情是最浓的年味,联合15所高校奏响家庭欢乐颂</span>
									<br/>
									<p>
										<span> </span>
										<a href="#">感兴趣</a>
										<a href="#">234</a>
									</p>
								</div>
							</div>
						</div>
					</div>
					<div id="studyplan" class="showcontent">
						学习计划
					</div>
					<div id="mgame" class="showcontent">
						<div class="userinfo">
                    		<div class="userphoto"> </div>
                    		<div class="username">Chindy</div>
		                    <div class="userlevel"> </div>
		                    <div id="recentgame" class="unitgame">最近游戏</div>
		                    <div id="gamecenter" class="unitgame">游戏大厅</div>
		                </div>
						<div id="gamelist">
		                    <div class="gamelistitem" id="gameitem1">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                    </div>
		                    <div class="gamelistitem" id="gameitem2">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                    </div>
		                    <div class="gamelistitem" id="gameitem3">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                    </div>
		                    <div class="gamelistitem" id="gameitem4">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                     </div>
		                    <div class="gamelistitem" id="gameitem5">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                    </div>
		                    <div class="gamelistitem" id="gameitem6">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                    </div>
		                </div>
					</div>
					<div id="friendd6" class="showcontent">
						<div class="classmask"></div>
		                <div class="friendbgdecoration"></div>
		                <div class="friendcontent" id="friendcontent">
		                	<div class="multichat" onclick="multichat()"></div>
		                </div>
					</div>
					<div id="classname" class="showcontent">
		                <div class="classmask"></div>
		                <div class="classbgdecoration"></div>
		                <div class="classmate" id="classmate">
		                
		                </div>				
					</div>
					<div id="schoolfellows8" class="showcontent">
		                <div class="classmask"></div>
		                <div class="schoolbgdecoration"></div>
		                <div class="schoolfellowcontent" id="schoolfees">
		                </div>						
					</div>
					<div id="music" class="showcontent">
						音乐
					</div>
					<form id="settingform" onsubmit="return ajax_submit_setting()">
					<div id="setting" class="showcontent">
						<div class="userinfo">
							
							<div class="userphoto" id="userphoto">
								<a href="javascript:;">
									<input type="file" name="photo" accept="image/png,image/jpeg" onchange="preView(this,$('#userphoto')[0])"/>
								</a>
							</div>
							
							<div class="username">
								<%=user.getUserName() %>
							</div>
							<div class="userlevel"> </div>
						</div>
						<div id="edit">
							<div id="nick">
								<span> </span>
								<input type="text" name="nickname" value="<%=user.getNickName()%>"/>
							</div>
							<div id="age">
								<span> </span>
								<input type="number" min="1" name="age" value="<%=user.getAge()%>"/>
							</div>
							<div id="birthday">
								<span>  </span>
								<input type="date" name="birthday" value="<%=user.getBirth()%>"/>
							</div>
							<div id="star">
								<span> </span>
								<input type="text" name="star" value="<%=user.getStar()%>"/>
							</div>
							<div id="mail">
								<span> </span>
								<input type="text" name="email" value="<%=user.getEmail()%>"/>
							</div>
							<div id="myclass">
								<span> </span>
								<select name="grade" id="grade">
									<option value="1">1年级</option>
									<option value="2">2年级</option>
									<option value="3">3年级</option>
									<option value="4">4年级</option>
									<option value="5">5年级</option>
									<option value="6">6年级</option>
									<option value="7">7年级</option>
									<option value="8">8年级</option>
									<option value="9">9年级</option>
								</select>
								<select name="banji" id="banji">
									<option value="1">1班</option>
									<option value="2">2班</option>
									<option value="3">3班</option>
									<option value="4">4班</option>
									<option value="5">5班</option>
									<option value="6">6班</option>
									<option value="7">7班</option>
								</select>
							</div>
							<div id="phone">
								<span> </span>
								<input type="text" value="<%=user.getPhonenumber()%>" name="phonenumber"/>
							</div>
							<div id="sex">
								<span>  </span>
								<input type="radio" name="gender" <%="male".equals(user.getGender())?"checked":""%> value="male"/>
								<b>男</b>
								<input type="radio" name="gender" <%="female".equals(user.getGender())?"checked":"" %> value="female"/>
								<b>女</b>
							</div>
							<div id="oldpass">
								<span> </span>
								<input  type="password" value="<%=user.getPassWord()%>"/>
							</div>
							<div id="newpass" >
								<span> </span>
								<input  type="password" name="newpwd"/>
							</div>
							<div id="sub">
								<input type="submit" value="" />
							</div>
						</div>
						<div id="flower"> </div>
					</div>
					</form>
				</div>
			</section>
			<!--右边在线好友栏-->
			<aside id="right-side">
				<!--泡泡部分-->
				<div id="friendsOnline">
<!-- 					<div class="friendOn" id="friend1"> </div>
					<div class="friendOn" id="friend2"> </div>
					<div class="friendOn" id="friend3"> </div>
					<div class="friendOn" id="friend4"> </div>
					<div class="friendOn" id="friend5"> </div>
					<div class="friendOn" id="friend6"> </div>
					<div class="friendOn" id="friend7"> </div> -->
				</div>
				<div id="right-down">
					<img id="onlinefriend"src="imgs/onlinefriend.gif">
				</div>
			</aside>
		</div>
		<!-- 聊天对话框 -->
		<div id="chatbox">
			<div id="chatmain">
				<div id="bar">
					与xxx聊天中
				</div>
				<div id="chatborard">
				</div>
				<div>
					<input type="text" id="inputcontent" placeholder="点击按钮或者按回车键发送  /  按ESC键关闭聊天"/>
					<button id="chatsend" onclick="onSend()">
						发送
					</button>
				</div>
			</div>
		</div>		
	</body>
	<!-- 引入kalendae日历插件 -->
	<script type="text/javascript" src="plugin/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="plugin/kalendae/js/kalendae.js"></script>
	<!-- JS引入 -->
	<script src="<%=request.getContextPath()%>/js/elements.js"></script>
	<script src="<%=request.getContextPath()%>/js/common.js"></script>
	<script src="<%=request.getContextPath()%>/js/bubble.js"></script>
	<script src="<%=request.getContextPath()%>/js/main.js"></script>
	<script src="<%=request.getContextPath()%>/js/box-drag.js"></script>
	<script src="<%=request.getContextPath()%>/js/moment.jsp"></script>
	<script src="<%=request.getContextPath()%>/js/classmate_schoolmate.jsp"></script>
	<script src="<%=request.getContextPath()%>/js/friend.jsp"></script>
	<script src="<%=request.getContextPath()%>/setting.js"></script>
	
	<script type="text/javascript">
	
	/**
	*1v1聊天
	**/
	function chat(toUserId,toUserName){
		/* 设置好友id，发送消息时要用到 */
		$("#inputcontent").attr("data-toUserId",toUserId);
		
		var text = "和 <b>"+toUserName+"</b> 聊天中";
		showChatWindow(text);
	}

	/**
	*多人聊天
	**/
	function multichat(){
		var text = "多人聊天中";
		showChatWindow(text);
	}	
	
	var Chat = {};
	Chat.socket = null;
	Chat.connect = function(host) {
		if ('WebSocket' in window) {
			Chat.socket = new WebSocket(host);
		} else {
			alert("抱歉，您的浏览器不支持WebSocket！");
			return;
		}

		Chat.socket.onopen = function() {
			console.log("<%=user.getId()%>" + " 连接WebSocket服务端成功");
			$("#inputcontent")[0].onkeydown = function(event) {
				if (event.keyCode == 13) {
					onSend();
				}
			}
		};

		Chat.socket.onclose = function() {
			console.log("<%=user.getId()%>" + " 断开ws连接");
		};

		/* 接到服务器发来的消息 */
		Chat.socket.onmessage = function(message) {
			console.log("<%=user.getId()%>" + " 收到服务端消息 " + message.data);
			
			
			if(message != "" | message != undefined){
				var msgObj = JSON.parse(message.data);
				if(msgObj.msgCode == 0){
					showChatWindow("和 <b>"+msgObj.fromUserName+"</b> 聊天中");
					//1v1聊天,记录对方的userID,发送消息时有用到
					$("#inputcontent").attr("data-toUserId",msgObj.fromUserId);
				}else if(msgObj.msgCode == 1){
					showChatWindow("多人聊天中");
				}
				
				//在自己的聊天窗口上显示好友发来的信息
				Chat.createMsgNode(msgObj,true);
			}
			
		};

		/**
		 * 刷新、页面跳转、关闭页面等事件发生前关闭连接
		 */
		window.onbeforeunload = function() {
			Chat.socket.close();
		}
	}
	
	//如果聊天窗口没有显示则显示
	function showChatWindow(barText){
		if($("#chatbox").css("display") == "none"){
			$("#chatbox").css("display","block");
		}
		if($("#bar").html() != barText){
			$("#bar").html(barText);
			$("#chatborard").empty();
		}
	}
	
	function onSend(groupChat){
		var content = $("#inputcontent").val();
		$("#inputcontent").val("");
		if(content == ""){
			alert("亲，发送内容不能为空哦");
			return;
		}
		
		var msgObj = null;
		var toUserId = $("#inputcontent").attr("data-toUserId");
		if(toUserId == "" | toUserId == undefined){
			//多人聊天
			msgObj = {
				"msgCode" : 1,
				"fromUserId":"<%=user.getId()%>",
				"fromUserName":"<%=user.getUserName()%>",
				"content" : content
			};
		}else{
			//1v1聊天
			msgObj = {
				"msgCode" : 0,
				"toUserId" : toUserId,
				"fromUserId":"<%=user.getId()%>",
				"fromUserName":"<%=user.getUserName()%>",
				"content" : content
			};
		}
		
		//在自己的聊天窗口上显示
		Chat.createMsgNode(msgObj,false);
		//发送给对方
		Chat.sendChatMsg(msgObj);
	}
	
	/* 创建在聊天窗口上的信息并显示 */
	Chat.createMsgNode=function(msgObj,fromServer){
		var board = $("#chatborard");
		var p = $("<p></p>");
		p.css("wordWrap", "break-word");
		if(fromServer){
			p.html("<b>"+msgObj.fromUserName+"</b>:" + msgObj.content);
		}else{
			p.html("<b><%=user.getUserName()%></b>:" + msgObj.content);
		}
		board.append(p);
		while (board[0].childNodes.length > 20) {
			board[0].removeChild(board[0].firstChild);
		}
		board[0].scrollTop = board[0].scrollHeight;
	}
	
	Chat.sendChatMsg = function(msgObj) {
		var message = JSON.stringify(msgObj);
		if (message != '') {
			console.log("send message:" + message);
			Chat.socket.send(message);
		}
	}	

	Chat.initialize = function() {
		if (window.location.protocol == 'http:') {
			Chat.connect('ws://' + window.location.host + '/minecraft/websocket/'
					+ "<%=user.getId()%>");
		} else {
			Chat.connect('wss://' + window.location.host + '/minecraft/websocket/'
					+ "<%=user.getId()%>");
		}
	};

	
		checkRadio();
		alert("grade:<%=user.getGrade()-1%>")
		alert("banji:<%=user.getBanji()-1%>")
		setSelectedOption("grade", <%=user.getGrade()-1%>);
		setSelectedOption("banji", <%=user.getBanji()-1%>);
		setUserPhoto();
		showClassmates();
		showSchoolmates();
		showFriends();
		showOnlineFriends();
		showMoments();
		Chat.initialize();
		makeChatBoxCanMove();
		
	</script>
</html>
