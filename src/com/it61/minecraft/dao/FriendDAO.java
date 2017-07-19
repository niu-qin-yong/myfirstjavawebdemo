package com.it61.minecraft.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.it61.minecraft.bean.Friend;
import com.it61.minecraft.bean.User;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class FriendDAO implements OnTransformListener<Friend>{
	private DAOTemplate<Friend> temp;
	
	
//	public static void main(String[] args) {
//		FriendDAO dao = new FriendDAO();
//		User user = new User();
//		user.setId(1);
//		List<Friend> friends = dao.findAllFriends(user);
//		System.out.println(friends.size()+","+friends.get(0).getFriName());
//	}

	public FriendDAO(){
		temp = new DAOTemplate<Friend>();
		temp.setOnMapListener(this);
	}

	@Override
	public Friend onTransform(ResultSet rs) {
		Friend friend = null;
		try {
			friend = new Friend();
			friend.setId(rs.getInt("id"));
			friend.setOwerId(rs.getInt("ower_id"));
			friend.setFriId(rs.getInt("fri_id"));
			friend.setFriName(rs.getString("fri_name"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return friend;
	}
	
	public void addFriend(int owerId, int friendId,String friendName) throws Exception {
		String sql = "insert into friends(ower_id,fri_id,fri_name) values(?,?,?)";
		Object[] args = {owerId,friendId,friendName};
		temp.update(sql, args);
	}

	public List<Friend> findAllFriends(User user) {
		String sql = "select * from friends where ower_id=?";
		Object[] args = {user.getId()};
		return temp.queryAll(sql, args);
	}

	public void removeFriend(Friend friend) throws Exception {
		String sql = "delete from friends where ower_id=? and fri_id=?;";
		Object[] args = {friend.getOwerId(),friend.getFriId()};
		temp.update(sql, args);
	}
}
