package com.it61.minecraft.web.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.service.UserService;
import com.it61.minecraft.service.impl.UserServiceImpl;

public final class LoginServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 获取表单数据
		String uname = request.getParameter("uname");
		String psw = request.getParameter("pw");
		
		System.out.println("Login  name:"+uname+" ps:"+psw);
		
		//调用UserService的登录的方法
		UserService userService = new UserServiceImpl();
		User user = userService.login(uname,psw);
		if(user != null){
			//登录成功
			//Session中添加登录状态
			request.getSession().setAttribute("user", user);
			
			//使用Cookie保存账号密码
			//需要完善前端页面，现在先假设需要保存用户名和密码
			Cookie cookie = new Cookie("cookie-user", uname+"-"+psw);
			cookie.setMaxAge(3*24*60*60);
			cookie.setPath("/minecraft/jsp/login.jsp");
			response.addCookie(cookie);
			
			//如果表单提交，重定向跳转到首页
			String host = getServletContext().getContextPath();
			//防止浏览器禁用Cookie,重写所有请求的URL
//			response.sendRedirect(host+"/index.html");
			response.sendRedirect(response.encodeRedirectURL(host+"/index.html"));
			
			//如果ajax提交，把要跳转的地址传回去，由js进行跳转
//			String webName = request.getContextPath();
//			String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webName+"/";
//			response.getWriter().write(basePath+"index.html");
		}else{
			//登录失败
			
			//如果表单提交，转发处理
			request.setAttribute("login_state", "false");
			request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
			
			//如果ajax提交
//			response.getWriter().write("login_fail");
		}
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}


}
