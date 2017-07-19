package com.it61.minecraft.web.listener;

import java.util.ArrayList;

import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.it61.minecraft.bean.User;

public class ContextListenerImpl implements ServletContextListener,ServletContextAttributeListener{

	@Override
	public void attributeAdded(ServletContextAttributeEvent event) {
		
	}

	@Override
	public void attributeRemoved(ServletContextAttributeEvent event) {
		
	}

	@Override
	public void attributeReplaced(ServletContextAttributeEvent event) {
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("ContextListenerImpl contextDestroyed");
		ArrayList<User> onlineUsers = (ArrayList<User>) sce.getServletContext().getAttribute("online_users");
		onlineUsers.clear();
		onlineUsers = null;
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("ContextListenerImpl contextInitialized");
		sce.getServletContext().setAttribute("online_users", new ArrayList<User>());
	}

}
