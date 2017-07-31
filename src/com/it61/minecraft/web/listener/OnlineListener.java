package com.it61.minecraft.web.listener;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.it61.minecraft.bean.User;

public class OnlineListener implements HttpSessionListener ,HttpSessionAttributeListener{

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		HttpSession session = se.getSession();
		System.out.println(session.getId()+" sessionCreated  new? "+session.isNew());
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		HttpSession session = se.getSession();
		System.out.println(session.getId()+" sessionDestroyed");
	}

	@Override
	public void attributeAdded(HttpSessionBindingEvent event) {
		String name = event.getName();
		if(event.getValue() instanceof User){
			User user = (User) event.getValue();
			System.out.println("session "+event.getSession().getId()+"增加属性name "+name+",值为"+user+",用户"+user.getUserName()+" 登录系统");
			
			//将登录用户添加到在线用户集合
			ArrayList<User> onlineUsers = (ArrayList<User>) event.getSession().getServletContext().getAttribute("online_users");
			onlineUsers.add(user);
		}
	}

	@Override
	public void attributeRemoved(HttpSessionBindingEvent event) {
		String name = event.getName();
		if(event.getValue() instanceof User){
			User user = (User) event.getValue();
			System.out.println("session "+event.getSession().getId()+"移除属性name "+name+",值为"+user+",用户"+user.getUserName()+" 退出系统");
			
			//将登录用户移除在线用户集合
			ArrayList<User> onlineUsers = (ArrayList<User>) event.getSession().getServletContext().getAttribute("online_users");
			onlineUsers.remove(user);
		}
	}

	@Override
	public void attributeReplaced(HttpSessionBindingEvent event) {
		if(event.getValue() instanceof User){
			User oldUser = (User) event.getValue();//旧属性值  
			User newUser = (User) event.getSession().getAttribute(event.getName());//新的属性值  
			System.out.println("session"+event.getSession().getId()+"更改属性"+oldUser.getUserName()+" 已更改为 "+newUser.getUserName()); 
			
			//同一Session，不同账户登录时
			ArrayList<User> onlineUsers = (ArrayList<User>) event.getSession().getServletContext().getAttribute("online_users");
			onlineUsers.remove(oldUser);
			onlineUsers.add(newUser);
		}
	}

}
