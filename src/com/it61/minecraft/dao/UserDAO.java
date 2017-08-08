package com.it61.minecraft.dao;

import java.io.InputStream;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.it61.minecraft.bean.Friend;
import com.it61.minecraft.bean.User;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class UserDAO implements OnTransformListener<User>{
	
	private DAOTemplate<User> temp;

	public UserDAO(){
		temp = new DAOTemplate<User>();
		temp.setOnMapListener(this);
	}
	
	/**
	 * @param user
	 * @throws Exception 
	 */
	public void add(User user) throws Exception{
		String sql = "insert into "
				+ "users(username,password,phonenumber)"
				+ "values(?,?,?)";
		Object[] args = {user.getUserName(),user.getPassWord(),user.getPhonenumber()};
		temp.update(sql, args);
	}
	
	/**
	 * @param user
	 * @throws Exception 
	 */
	public void update(User user) throws Exception{
		String sql = "update users "
				+ "set username=?,password=?,nick_name=?,gender=?,age=?,birth=?,class=?,phonenumber=?,photo=?,star=?,email=?,grade=?"
				+ " where id=?"; //注意where和之前的字符之间有空格，不要因为换行忘记了
		Object[] args = {
				user.getUserName(),user.getPassWord(),user.getNickName()
				,user.getGender(),user.getAge(),user.getBirth()
				,user.getBanji(),user.getPhonenumber(),user.getPhoto()
				,user.getStar(),user.getEmail(),user.getGrade()
				,user.getId()};
		temp.update(sql, args);
	}
	
	public User findById(int id){
		String sql = "select * from users where id=?";
		Object[] args = {id};
		return temp.queryOne(sql, args);
	}
	
	public User findByUserName(String name){
		String sql = "select * from users where username=?";
		Object[] args = {name};
		return temp.queryOne(sql, args);
	}
	
	public List<User> findAll(){
		String sql = "select * from users";
		return temp.queryAll(sql, null);
	}
	
	@Override
	public User onTransform(ResultSet rs)  {
		User user = null;
		try {
			int id = rs.getInt(1);
			String username = rs.getString("username");
			String password = rs.getString("password");
			String nick_name = rs.getString("nick_name");
			String gender = rs.getString("gender");
			int age = rs.getInt("age");
			String birth = rs.getString("birth");
			int banji = rs.getInt("class");
			String phonenumber = rs.getString("phonenumber");
			InputStream photo = rs.getBinaryStream("photo");
			String star = rs.getString("star");
			String email = rs.getString("email");
			int grade = rs.getInt("grade");
			int level = rs.getInt("level");
			
			user = new User(id,username,password,nick_name,gender,age,birth,banji,phonenumber,photo,star,email,grade,level);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	public List<User> getClassmates(User user) {
		String sql = "select * from users where grade=? and class=? order by level desc";
		Object[] args = {user.getGrade(),user.getBanji()};
		List<User> classmates = temp.queryAll(sql, args);
		return classmates;
	}

	public List<User> getAllUsers() {
		String sql = "select * from users";
		Object[] args = {};
		return temp.queryAll(sql, args);
	}

	/**
	 * 增加经验值，打卡一次，经验值加10
	 * @param user
	 * @throws Exception
	 */
	public void addExperience(User user) throws Exception {
		String sql = "update users set level=level+10 where id=?";
		Object[] args = {user.getId()};
		temp.update(sql, args);
	}


}
