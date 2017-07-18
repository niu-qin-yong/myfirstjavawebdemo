package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.it61.minecraft.bean.User;

public class IndexServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		if(user == null){
			//未登录
//			response.setHeader("content-Type", "text/html; charset=utf-8");
//			response.setHeader("refresh", "2;url="+Constants.domain+"minecraft/jsp/login.jsp");
//			response.getWriter().write("您还未登录,2秒后将跳转到登录页面");
			
			String host = getServletContext().getContextPath();
			response.sendRedirect(host+"/jsp/login.jsp");
		}else{
			//已登录跳转到首页
			request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
