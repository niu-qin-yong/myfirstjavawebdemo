package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.bean.Favor;
import com.it61.minecraft.service.FavorService;
import com.it61.minecraft.service.impl.FavorServiceImpl;

public class FavorServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int momentId = Integer.valueOf(request.getParameter("momentId"));
		int favorId = Integer.valueOf(request.getParameter("favorId"));
		String favorName = request.getParameter("favorName");
		
		try {
			FavorService service = new FavorServiceImpl();
			service.addFavor(new Favor(momentId, favorId, favorName));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
