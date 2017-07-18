package com.it61.minecraft.test;

import java.sql.Date;
import java.util.List;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.dao.UserDAO;

public class UserDaoTest {
	public static void main(String[] args) {
		UserDAO userDAO = new UserDAO();
		
		//插入
//		User user = new User("Herry","123","mama","男",20,null,"3年2班","13011112222",null);
//		userDAO.add(user);
		
		//修改
//		User user = new User(1,"mary","123456","mmm","女",22,new Date(2017, 7, 12),"3年2班","13011112222",null);
//		userDAO.update(user);
		
		//单条记录查询
//		User u = userDAO.findById(2);
//		if(u != null){
//			System.out.println(u.getUserName()+","+u.getNickName());
//		}else{
//			System.out.println("no this user");
//		}
		
		//多条记录查询
//		List<User> users = userDAO.findAll();
//		if(users != null && users.size() > 0){
//			for(User u : users){
//				System.out.println(u.getUserName()+","+u.getNickName());
//			}
//		}else{
//			System.out.println("sth wrong");
//		}
		
	}
}
