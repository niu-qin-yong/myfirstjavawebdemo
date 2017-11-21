package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.service.UserService;
import com.it61.minecraft.service.impl.UserServiceImpl;

public class ObtainSaveSizeServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String userId = request.getParameter("userId");
		String type = request.getParameter("type");
		
		//获取对应类型的已用存储空间大小
		int sizeUsed = 0;
		try {
			UserService service = new UserServiceImpl();
			User user = service.getUser(Integer.valueOf(userId));
			if("pic".equals(type)){
				//获取图片的已用空间大小
				sizeUsed = user.getPicSize();
			}else if("music".equals(type)){
				//获取音乐的已用空间大小
				sizeUsed = user.getMusicSize();
			}
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//把已用存储空间大小返回给请求者
		String data = "{\"size\":"+sizeUsed+"}";
		response.getWriter().write(data);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
