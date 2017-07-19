package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.bean.Friend;
import com.it61.minecraft.service.FriendService;
import com.it61.minecraft.service.impl.FriendServiceImpl;

public class RemoveFriendServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int owerId = Integer.valueOf(request.getParameter("owerId"));
		int friId = Integer.valueOf(request.getParameter("friId"));
		
		System.out.println("RemoveFriendServlet:"+owerId+" 将要移除好友 "+friId);

		
		try {
			FriendService service = new FriendServiceImpl();
			service.removeFriend(new Friend(owerId, friId));
			
			response.getWriter().write("remove_friend_ok");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("remove_friend_fail");
		}
		
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
