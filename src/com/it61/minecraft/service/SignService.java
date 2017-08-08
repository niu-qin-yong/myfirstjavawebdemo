package com.it61.minecraft.service;

import com.it61.minecraft.bean.User;

public interface SignService {
	/**
	 * 今天是否已打卡
	 * @param user
	 * @return
	 */
	boolean hasSign(User user);

	/**
	 * 打卡
	 * @param user
	 */
	void sign(User user)throws Exception;
}
