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
	 * 该用户名是否已经存在
	 * @param userName
	 * @return
	 */
	boolean userNameExist(String userName);
}
