package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.Friend;
import com.it61.minecraft.bean.User;

public interface FriendService {
	void addFriend(int owerId, int friendId,String friendName)  throws Exception;
	List<Friend> getAllFriends(User user);
	void removeFriend(Friend friend)  throws Exception;
}
