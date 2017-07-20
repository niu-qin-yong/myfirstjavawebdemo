package com.it61.minecraft.service.impl;

import java.util.List;

import com.it61.minecraft.bean.Moment;
import com.it61.minecraft.dao.MomentDAO;
import com.it61.minecraft.web.servlet.MomentService;

public class MomentServiceImpl implements MomentService{

	@Override
	public void sendMoment(Moment moment) throws Exception {
		MomentDAO dao = new MomentDAO();
		dao.insert(moment);
	}

	@Override
	public List<Moment> getMoments(int senderId) {
		MomentDAO dao = new MomentDAO();
		return dao.getAllMoments(senderId);
	}

}
