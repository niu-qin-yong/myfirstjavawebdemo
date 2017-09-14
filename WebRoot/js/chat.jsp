<%@ page contentType="text/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.it61.minecraft.bean.*"%>

<%
User user = (User)session.getAttribute("user");
String webName = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webName;
%>

/**
	*关闭聊天窗口
	**/
	function hideChatWindow(){
		/*把文本输入框中的toUserId属性值置为空，这是个标志，如果有值是1v1聊天，如果为空则是多人聊天*/
		$("#inputcontent").attr("data-toUserId","");
		$("#chatbox").css("display", "none");	
	}

/**
	*1v1聊天
	**/
	function chat(toUserId,toUserName){
		/* 设置好友id，发送消息时要用到 */
		$("#inputcontent").attr("data-toUserId",toUserId);
		
		var text = "<b>"+toUserName+"</b>";
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
					showChatWindow("<b>"+msgObj.fromUserName+"</b>");
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
		if($("#chat-person").html() != barText){
			$("#chat-person").html(barText);
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
			Chat.connect('ws://' + window.location.host + '/mc/websocket/'
					+ "<%=user.getId()%>");
		} else {
			Chat.connect('wss://' + window.location.host + '/mc/websocket/'
					+ "<%=user.getId()%>");
		}
	};
