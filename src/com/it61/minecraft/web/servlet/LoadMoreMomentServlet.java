package com.it61.minecraft.web.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.it61.minecraft.bean.Friend;
import com.it61.minecraft.bean.Moment;
import com.it61.minecraft.bean.User;
import com.it61.minecraft.common.Utils;
import com.it61.minecraft.service.FriendService;
import com.it61.minecraft.service.MomentService;
import com.it61.minecraft.service.impl.FriendServiceImpl;
import com.it61.minecraft.service.impl.MomentServiceImpl;

public class LoadMoreMomentServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -16838395243263796L;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//时间戳，取这个时间之前的动态
		String stamp = request.getParameter("stamp");
		
		//当前用户
		HttpSession session = request.getSession(false);
		User user = (User) session.getAttribute("user");
		
		
		//获取所有好友
		FriendService friService = new FriendServiceImpl();
		List<Friend> allFriends = friService.getAllFriends(user);
		//将自己及好友的id添加到senderIds
		List<Integer> senderIds = new ArrayList<Integer>();
		senderIds.add(user.getId());
		for(Friend fri : allFriends){
			senderIds.add(fri.getFriId());
		}
		
		//获取下一组动态
		MomentService service = new MomentServiceImpl();
		List<Moment> moments = service.getMomentsPaging(senderIds, stamp, 3);
		
		//将动态转成json返回给页面显示
		String json = Utils.FastJsontoJsonString(moments);
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
