package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.it61.minecraft.bean.User;

public class LogoutServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//移除Session中的属性
		HttpSession session = request.getSession(false);
		if(session != null){
			User user = (User) session.getAttribute("user");
			System.out.println(user.getUserName()+"下线");
			
			session.removeAttribute("user");
			session.invalidate();
		}
		//重定向到index.html
		response.sendRedirect(request.getContextPath()+"/index.html");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
