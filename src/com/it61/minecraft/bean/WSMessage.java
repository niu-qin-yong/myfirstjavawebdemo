package com.it61.minecraft.bean;

public class WSMessage {
	/**
	 * 消息码<br/>
	 * 0：一对一聊天<br/>
	 * 1：群聊<br/>
	 * 2：服务器向客户端发送通知信息<br/>
	 * 3：好友上线通知
	 */
	private int msgCode;
	private int targetUserId;
	private String content;
	
	public WSMessage(){}
	
	public WSMessage(int msgCode, int targetUserId, String content) {
		super();
		this.msgCode = msgCode;
		this.targetUserId = targetUserId;
		this.content = content;
	}
	public int getMsgCode() {
		return msgCode;
	}
	public void setMsgCode(int msgCode) {
		this.msgCode = msgCode;
	}
	public int getTargetUserId() {
		return targetUserId;
	}
	public void setTargetUserId(int targetUserId) {
		this.targetUserId = targetUserId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
