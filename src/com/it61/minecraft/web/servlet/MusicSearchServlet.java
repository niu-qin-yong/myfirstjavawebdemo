package com.it61.minecraft.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.bean.Music;
import com.it61.minecraft.common.Utils;
import com.it61.minecraft.service.MusicService;
import com.it61.minecraft.service.impl.MusicServiceImpl;

public class MusicSearchServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String key = request.getParameter("key");
		
		MusicService service = new MusicServiceImpl();
		List<Music> list = service.searchMusic(key);
		
		String json = Utils.FastJsontoJsonString(list);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
