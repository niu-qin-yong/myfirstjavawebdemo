package com.it61.minecraft.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.it61.minecraft.bean.Favor;
import com.it61.minecraft.service.FavorService;
import com.it61.minecraft.service.impl.FavorServiceImpl;

public class FavorCancelServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int momentId = Integer.valueOf(request.getParameter("momentId"));
		int favorId = Integer.valueOf(request.getParameter("favorId"));
		
		try {
			FavorService service = new FavorServiceImpl();
			service.removeFavor(new Favor(momentId, favorId));
			
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("favor-cancel-success");
		} catch (Exception e) {
			e.printStackTrace();
			
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write("favor-cancel-fail");
		}

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
