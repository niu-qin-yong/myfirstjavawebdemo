package com.it61.minecraft.web.servlet;

import java.util.List;

import com.it61.minecraft.bean.Moment;

public interface MomentService {
	void sendMoment(Moment moment) throws Exception;
	List<Moment> getMoments(int senderId);
}
