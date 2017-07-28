<%@ page contentType="text/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.it61.minecraft.bean.*"%>

<%
User user = (User)session.getAttribute("user");
%>

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
				onSendChatMsg();
			}
		}
	};

	Chat.socket.onclose = function() {
		console.log("<%=user.getId()%>" + " 断开ws连接");
	};

	Chat.socket.onmessage = function(message) {
		console.log("<%=user.getId()%>" + " 收到服务端消息 " + message.data);
		var board = $("#chatborard");
		var p = $("<p></p>");
		p.css("wordWrap", "break-word");
		p.html("<b><%=user.getUserName()%></b>:" + message.data);
		board.append(p);
		while (board[0].childNodes.length > 20) {
			board[0].removeChild(board[0].firstChild);
		}
		board[0].scrollTop = board[0].scrollHeight;
	};

	/**
	 * 刷新、页面跳转、关闭页面等事件发生前关闭连接
	 */
	window.onbeforeunload = function() {
		Chat.socket.close();
	}

}

Chat.sendMessage = (function(message) {
	if (message != '') {
		console.log("send message:" + message);
		Chat.socket.send(message);
	}
});

Chat.initialize = function() {
	if (window.location.protocol == 'http:') {
		Chat.connect('ws://' + window.location.host + '/minecraft/websocket/'
				+ "<%=user.getId()%>");
	} else {
		Chat.connect('wss://' + window.location.host + '/minecraft/websocket/'
				+ "<%=user.getId()%>");
	}
};

/* 发送按钮对应点击事件 */
function onSendChatMsg() {
	var targetId = $("#inputcontent").attr("data-targetId");
	var content = $("#inputcontent").val();
	$("#inputcontent").val("");
	var msg = {
		"msgCode" : 0,
		"targetUserId" : targetId,
		"content" : content
	};
	Chat.sendMessage(JSON.stringify(msg));
}
