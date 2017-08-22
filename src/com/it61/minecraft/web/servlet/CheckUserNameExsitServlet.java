package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.service.UserService;
import com.it61.minecraft.service.impl.UserServiceImpl;

public class CheckUserNameExsitServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取用户名
		String userName = request.getParameter("user_name");
		
		//查看该用户名是否已存在
		UserService service = new UserServiceImpl();
		boolean exist = service.userNameExist(userName);
		
		//返回响应
		response.getWriter().write(String.valueOf(exist));
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
