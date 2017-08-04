package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.User;
import com.it61.minecraft.service.AlbumService;
import com.it61.minecraft.service.impl.AlbumServiceImpl;

public class CreateAlbumServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String name = request.getParameter("name");
		String des = request.getParameter("des");
		
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");
		
		Album album = new Album(user.getId(),name,des);
		
		try {
			//存
			AlbumService service = new AlbumServiceImpl();
			service.addAlbum(album);
			
			//取出刚才存的
			Album albumLatest = service.getAlbumLatest(user.getId());
			
			JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd hh:mm:ss"; 
			String jsonString = JSON.toJSONString(albumLatest,SerializerFeature.WriteDateUseDateFormat);
			
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(jsonString);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
