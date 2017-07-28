package com.it61.minecraft.websocket;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.alibaba.fastjson.JSON;
import com.it61.minecraft.bean.WSMessage;
import com.it61.minecraft.common.Utils;

@ServerEndpoint(value = "/websocket/{userId}")
public class WebSocketServer {
	
	private static ConcurrentHashMap<Integer,Session> connections = new ConcurrentHashMap<Integer,Session>();
	private Session session;
	private Integer userId;
	
	/**
	 * 建立连接时调用
	 * @param session
	 */
	@OnOpen
	public void start(@PathParam("userId")Integer userId,Session session){
		System.out.println("WebSocketServer服务端 用户"+userId+"连接成功");

		this.userId = userId;
		this.session = session;
		connections.put(userId, session);
		
		
	}
	
	/**
	 * 连接断开时调用
	 */
	 @OnClose
	 public void end() {
		 System.out.println("WebSocketServer服务端 用户"+userId+"断开连接");
		 connections.remove(this.userId);
	 }
	 
	/**
	 * 收到客户端发送的消息时调用
	 * @param message
	 */
	@OnMessage
    public void incoming(String message) {
        // Never trust the client
		WSMessage msg = (WSMessage) JSON.parseObject(message,WSMessage.class);
        broadcast(msg);
    }
	
	/**
	 * 发生错误时调用
	 * @param t
	 * @throws Throwable
	 */
    @OnError
    public void onError(Throwable t) throws Throwable {
    	t.printStackTrace();
        System.out.println("Chat Error: " + t.toString());
    }
    
    /**
     * 向客户端发送消息
     * @param msg  要发送的消息，格式是JSON串
     * @param targetUserId 给哪些用户发送消息
     */
    private void broadcast(WSMessage msg) {
    	System.out.println("WebSocketServer 接收到的信息："+msg.toString());
    	switch (msg.getMsgCode()) {
		case 0:
			chatP2P(msg);
			break;
		case 1:
			chatGroup(msg);
			break;
		case 2:
			
			break;
		case 3:
			
			break;
		}
    }

    private void chatGroup(WSMessage msg) {
    	//遍历当前在线用户，群发消息
    		try {
    			String msgJson = Utils.FastJsontoJsonString(msg);
    			Set<Integer> keySet = connections.keySet();
    			for(Integer key : keySet){
    				if(key == this.userId){
    					//如果是自己，则不发送，因为在客户端已经显示过了
    					continue;
    				}
    				Session ss = connections.get(key);
    				ss.getBasicRemote().sendText(msgJson);
    			}
			} catch (IOException e) {
				e.printStackTrace();
			}
	}

	/**
     * 1v1聊天
     */
	private void chatP2P(WSMessage msg) {
		
		Session targetSession = connections.get(msg.getToUserId());
		
		try {
			if(targetSession != null){
				//给好友发
				String msgJson = Utils.FastJsontoJsonString(msg);
				targetSession.getBasicRemote().sendText(msgJson);
			}else{
				System.out.println("好友 "+msg.getToUserName()+" 不在线");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
