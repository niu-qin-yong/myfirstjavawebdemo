package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.it61.minecraft.bean.User;

public class IndexServlet extends HttpServlet {
	private static Logger logger = LogManager.getLogger(IndexServlet.class);

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		
		//log
		String sessionId = session.getId();
		int maxInactiveInterval = session.getMaxInactiveInterval();
		logger.info("sessionId:"+sessionId+",maxInactiveInterval:"+maxInactiveInterval);
		
		if(user == null){
			//未登录
//			response.setHeader("content-Type", "text/html; charset=utf-8");
//			response.setHeader("refresh", "2;url="+Constants.domain+"minecraft/jsp/login.jsp");
//			response.getWriter().write("您还未登录,2秒后将跳转到登录页面");
			
			String host = getServletContext().getContextPath();
			//防止浏览器禁用Cookie,重写URL
//			response.sendRedirect(host+"/jsp/login.jsp");
			
			//log
			logger.info("IndexServlet 未登录，重定向到登录页  host:"+host);
			
			response.sendRedirect(response.encodeRedirectURL(host+"/jsp/login.jsp"));
		}else{
			//log
			logger.info("IndexServlet 登录成功，转发首页");
			
			//已登录跳转到首页
			request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
		}
		
		//添加权限过滤器后，如果将Session登录判断(上面的的代码)放到过滤器中,这里直接转发首页即可，上面代码全部注释掉
	//	request.getRequestDispatcher("/jsp/index.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
