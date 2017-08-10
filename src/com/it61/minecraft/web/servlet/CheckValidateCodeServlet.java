package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CheckValidateCodeServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//用户输入的验证码
		String code = request.getParameter("code");
		
		//服务端生成的验证码
		HttpSession session = request.getSession(false);
		String validateCode = (String) session.getAttribute("validate_code");
		
		//一致返回true，否则返回false
		response.getWriter().write(validateCode.equals(code)?"true":"false");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
