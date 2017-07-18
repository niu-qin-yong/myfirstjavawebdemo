package com.it61.minecraft.dao;

import java.sql.ResultSet;
import java.util.List;

import com.it61.minecraft.bean.Friend;
import com.it61.minecraft.bean.User;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class FriendDAO implements OnTransformListener<Friend>{
	private DAOTemplate<Friend> temp;

	public FriendDAO(){
		temp = new DAOTemplate<Friend>();
		temp.setOnMapListener(this);
	}

	@Override
	public Friend onTransform(ResultSet rs) {
		
		return null;
	}
	
	public void addFriend(int owerId, int friendId,String friendName) {
		String sql = "insert into friends(ower_id,fri_id,fri_name) values(?,?,?)";
		Object[] args = {owerId,friendId,friendName};
		temp.update(sql, args);
	}

	public List<Friend> findAllFriends(User user) {
		String sql = "select * from friends where ower_id=?";
		Object[] args = {user.getId()};
		return temp.queryAll(sql, args);
	}
}
