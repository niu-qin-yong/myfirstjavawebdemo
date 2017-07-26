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
	/**
	 * 分页获取动态
	 * @param senderIds 取这些发送者的动态
	 * @param time 这个时间之前的动态
	 * @param limit 每次取的动态条数
	 * @return
	 */
	List<Moment> getMomentsPaging(List<Integer> senderIds,String time,int limit);
}
