package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.User;

public interface UserService {
	void register(User user) throws Exception;
	User login(String userName,String passWord);
	void updateInfo(User user) throws Exception; 
	List<User> getClassmates(User user);
	List<User> getAllUsers();
	/**
	 * 用户打卡后，增加经验值
	 * @param user
	 */
	void addExperience(User user)throws Exception;
	/**
	 * 由用户id获取用户对象
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	User getUser(int userId)throws Exception;
	/**
	 * 保存图片大小
	 * @param userId
	 * @param picSize
	 */
	void savePicSize(int userId,int picSize)throws Exception;
	/**
	 * 保存音乐大小
	 * @param userId
	 * @param picSize
	 */
	void saveMusicSize(int userId,int musicSize)throws Exception;
}
