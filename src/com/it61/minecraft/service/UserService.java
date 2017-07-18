package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.User;

public interface UserService {
	void register(User user);
	User login(String userName,String passWord);
	void updateInfo(User user); 
	List<User> getClassmates(User user);
}
