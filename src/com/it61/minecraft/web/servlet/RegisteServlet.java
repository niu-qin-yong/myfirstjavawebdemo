package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.service.UserService;
import com.it61.minecraft.service.impl.UserServiceImpl;

public class RegisteServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		//获取表单数据
		String uname = request.getParameter("uname");
		String psw = request.getParameter("pw");
		String rpsw = request.getParameter("rpw");
		String pnumber = request.getParameter("pnumber");
		String vcode = request.getParameter("vcode");
		//将数据封装到User
		User user = new User(uname,psw,pnumber);
		
		//TODO 数据合法性检测
		
		
		//调用UserService的注册的方法
		UserService userService = new UserServiceImpl();
		userService.register(user);
		
		//注册完成，重定向到登录页面
		String host = getServletContext().getContextPath();
		response.sendRedirect(host+"/login.html");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}