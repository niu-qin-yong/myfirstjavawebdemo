package com.it61.minecraft.test;

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

public class ShowImgServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//或者 response.setContentType("image/*");
		response.setContentType("image/jpeg,image/png");
		//获取图片的二进制流，可能是从图片服务器，或者数据库中获取
		File file = new File("d://mary.jpg");
		FileInputStream fis = new FileInputStream(file);
		BufferedInputStream bis = new BufferedInputStream(fis);
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
//String id = request.getParameter("id");
//UserDAO dao = new UserDAO();
//User user = dao.findById(Integer.valueOf(id));

//response.setContentType("image/*");
//response.setContentType("text/plain;charset=UTF-8");
