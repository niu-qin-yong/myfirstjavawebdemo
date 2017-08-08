package com.it61.minecraft.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.it61.minecraft.bean.Sign;
import com.it61.minecraft.bean.User;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class SignDAO implements OnTransformListener<Sign> {
	private DAOTemplate<Sign> temp;
	
	public static void main(String[] args) {
		SignDAO dao = new SignDAO();
		User user = new User();
		user.setId(1);
		
		try {
			dao.sign(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
//		Sign hasSign = dao.hasSign(user);
//		System.out.println(hasSign);
		
	}
	
	public SignDAO(){
		temp = new DAOTemplate<Sign>();
		temp.setOnMapListener(this);
	}

	@Override
	public Sign onTransform(ResultSet rs) {
		try {
			int id = rs.getInt("id");
			int userId = rs.getInt("user_id");
			Timestamp signTime = rs.getTimestamp("sign_time");
			return new Sign(id,userId,signTime);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}

	public Sign hasSign(User user) {
		String sql = "select * from signs where user_id=? and sign_time=current_date();";
		Object[] args = {user.getId()};
		return temp.queryOne(sql, args);
	}

	public void sign(User user) throws Exception {
		String sql = "insert into signs(user_id,sign_time) values(?,?)";
		
		Date currentDate = new Date(System.currentTimeMillis());
		Object[] args = {user.getId(),currentDate.toString()};
		temp.update(sql, args);
	}
}
