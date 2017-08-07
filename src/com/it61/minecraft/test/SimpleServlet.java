package com.it61.minecraft.test;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.common.ImageResize;

public class SimpleServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 设置响应类型
		response.setContentType("image/jpeg,image/png");


		String realPath = getServletContext().getRealPath("/pictures");
		File file = new File(realPath + "/1-1-cd.jpg");
		
		System.out.println(file.getName().substring(file.getName().indexOf(".")));
		
		ImageResize.setWidthHeight(160, 160);
		BufferedImage img = ImageResize.resize(file.getAbsolutePath());
		ImageIO.write(img, "jpg", new File(realPath+"/xixi.jpg"));

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
