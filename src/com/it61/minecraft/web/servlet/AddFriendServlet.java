package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.service.FriendService;
import com.it61.minecraft.service.UserService;
import com.it61.minecraft.service.impl.FriendServiceImpl;
import com.it61.minecraft.service.impl.UserServiceImpl;

public class AddFriendServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User currentUser = (User) request.getSession().getAttribute("user");
		String friendId = request.getParameter("friendId");
		String friendName = request.getParameter("friendName");
		System.out.println(currentUser.getUserName()+" 将要添加 "+friendName+" 为好友");
		
		FriendService service = new FriendServiceImpl();
		service.addFriend(currentUser.getId(),Integer.valueOf(friendId),friendName);
		
		response.getWriter().write("success");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
