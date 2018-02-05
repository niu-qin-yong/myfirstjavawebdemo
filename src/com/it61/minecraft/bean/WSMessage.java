package com.it61.minecraft.bean;

import java.io.Serializable;

public class WSMessage implements Serializable{
	/**
	 * 消息码<br/>
	 * 0：一对一聊天<br/>
	 * 1：群聊<br/>
	 * 2：服务器向客户端发送通知信息<br/>
	 * 3：好友上线通知
	 */
	private int msgCode;
	private String content;
	private int fromUserId;
	private int toUserId;
	private String fromUserName;
	public WSMessage(int msgCode, String content, int fromUserId, int toUserId,
			String fromUserName, String toUserName) {
		super();
		this.msgCode = msgCode;
		this.content = content;
		this.fromUserId = fromUserId;
		this.toUserId = toUserId;
		this.fromUserName = fromUserName;
		this.toUserName = toUserName;
	}
	private String toUserName;
	

	public int getFromUserId() {
		return fromUserId;
	}

	public void setFromUserId(int fromUserId) {
		this.fromUserId = fromUserId;
	}

	public int getToUserId() {
		return toUserId;
	}

	public void setToUserId(int toUserId) {
		this.toUserId = toUserId;
	}

	public String getFromUserName() {
		return fromUserName;
	}

	public void setFromUserName(String fromUserName) {
		this.fromUserName = fromUserName;
	}

	public String getToUserName() {
		return toUserName;
	}

	public void setToUserName(String toUserName) {
		this.toUserName = toUserName;
	}

	public WSMessage(){}
	
	public int getMsgCode() {
		return msgCode;
	}
	public void setMsgCode(int msgCode) {
		this.msgCode = msgCode;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "WSMessage [msgCode="
				+ msgCode
				+ ", "
				+ (content != null ? "content=" + content + ", " : "")
				+ "fromUserId="
				+ fromUserId
				+ ", toUserId="
				+ toUserId
				+ ", "
				+ (fromUserName != null ? "fromUserName=" + fromUserName + ", "
						: "")
				+ (toUserName != null ? "toUserName=" + toUserName : "") + "]";
	}
}
