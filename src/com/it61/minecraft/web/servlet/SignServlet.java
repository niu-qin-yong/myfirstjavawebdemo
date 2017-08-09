package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.service.SignService;
import com.it61.minecraft.service.UserService;
import com.it61.minecraft.service.impl.SignServiceImpl;
import com.it61.minecraft.service.impl.UserServiceImpl;

public class SignServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("user");
			
			SignService signService = new SignServiceImpl();
			boolean hasSign = signService.hasSign(user);
			
			if(hasSign){
				response.getWriter().write("亲，今天已经打过卡了！");
			}else{
				try {
					//打卡
					signService.sign(user);
					//TODO 使用触发器，打卡成功，在users表中增加用户的经验值
					
					//在users表中增加用户的经验值
					UserService userService = new UserServiceImpl();
					userService.addExperience(user);
					
					response.getWriter().write("恭喜，打卡成功！经验值加10！");
				} catch (Exception e) {
					response.getWriter().write("抱歉，打卡失败，稍后重试！");
					e.printStackTrace();
				}
			}
			
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
