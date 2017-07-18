package com.it61.minecraft.service.impl;

import java.util.List;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.dao.UserDAO;
import com.it61.minecraft.service.UserService;


public class UserServiceImpl implements UserService {

	@Override
	public void register(User user) {
		UserDAO userDAO = new UserDAO();
		userDAO.add(user);
	}

	@Override
	public User login(String userName,String passWord) {
		UserDAO userDAO = new UserDAO();
		User user = userDAO.findByUserName(userName);
		if(user != null && user.getPassWord().equals(passWord)){
			return user;
		}
		return null;
	}

	@Override
	public void updateInfo(User user) {
		UserDAO userDAO = new UserDAO();
		userDAO.update(user);
	}

	@Override
	public List<User> getClassmates(User user) {
		UserDAO userDAO = new UserDAO();
		return userDAO.getClassmates(user);
	}

}
