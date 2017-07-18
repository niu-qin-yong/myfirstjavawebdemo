package com.it61.minecraft.service.impl;

import java.util.List;

import com.it61.minecraft.bean.Friend;
import com.it61.minecraft.bean.User;
import com.it61.minecraft.dao.FriendDAO;
import com.it61.minecraft.dao.UserDAO;
import com.it61.minecraft.service.FriendService;

public class FriendServiceImpl implements FriendService{
	@Override
	public void addFriend(int owerId, int friendId,String friendName) {
		FriendDAO dao = new FriendDAO();
		dao.addFriend(owerId,friendId,friendName);
	}

	@Override
	public List<Friend> getAllFriends(User user) {
		FriendDAO dao = new FriendDAO();
		return dao.findAllFriends(user);
	}
}
