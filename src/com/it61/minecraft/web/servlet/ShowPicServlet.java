package com.it61.minecraft.web.servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.dao.UserDAO;

public class ShowPicServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		UserDAO dao = new UserDAO();
		User user = dao.findById(Integer.valueOf(id));
		
		System.out.println("ShowPicServlet: id "+id+",username:"+user.getUserName());
		
		//设置响应类型
		response.setContentType("image/jpeg,image/png");
		
		//获取图片的二进制流
		BufferedInputStream bis = new BufferedInputStream(user.getPhoto());
		//将图片二进制流输出到response的输出流
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
		byte[] buff = new byte[4*1024];
		int len = -1;
		while((len=bis.read(buff)) != -1){
			bos.write(buff,0,len);
		}
		bos.flush();
		bos.close();
		bis.close();
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

