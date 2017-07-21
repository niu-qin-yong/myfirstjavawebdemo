package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.Moment;

public interface MomentService {
	void sendMoment(Moment moment) throws Exception;
	/**
	 * 获取所有动态，包含自己和好友的
	 * @param senderId
	 * @return
	 */
	List<Moment> getMoments(List<Integer> senderIds);
	Moment getMomentLatest(Integer senderId);
}
