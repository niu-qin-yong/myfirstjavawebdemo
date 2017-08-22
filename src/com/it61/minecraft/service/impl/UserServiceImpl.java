package com.it61.minecraft.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.dao.UserDAO;
import com.it61.minecraft.service.UserService;


public class UserServiceImpl implements UserService {
	public static List<User> onlineUsers = new ArrayList<User>();
	
	public static void main(String[] args) {
		UserServiceImpl service = new UserServiceImpl();
		UserDAO udao = new UserDAO();
		User user = udao.findById(1);
		List<User> classmates = service.getClassmates(user);
		
		System.out.println(classmates.size());
	}

	@Override
	public void register(User user) throws Exception {
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
	public void updateInfo(User user) throws Exception {
		UserDAO userDAO = new UserDAO();
		userDAO.update(user);
	}

	@Override
	public List<User> getClassmates(User user) {
		UserDAO userDAO = new UserDAO();
		
		List<User> classmates = userDAO.getClassmates(user);
		
		return classmates;
	}

	@Override
	public List<User> getAllUsers() {
		UserDAO userDAO = new UserDAO();
		return userDAO.getAllUsers();
	}

	@Override
	public void addExperience(User user) throws Exception{
		UserDAO userDAO = new UserDAO();
		userDAO.addExperience(user);
	}

	@Override
	public boolean userNameExist(String userName) {
		UserDAO userDAO = new UserDAO();
		User user = userDAO.findByUserName(userName);
		return user == null ? false : true;
	}

}
