package com.it61.minecraft.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;

import com.it61.minecraft.bean.Friend;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class TestDAO implements OnTransformListener<Hehe> {
	private DAOTemplate<Hehe> temp;
	
	public static void main(String[] args) {
		TestDAO dao = new TestDAO();
		Hehe hehe = dao.queryOne();
		System.out.println(hehe.id+","+hehe.name+","+hehe.datetime+","+hehe.stamp);
	}
	
	public TestDAO(){
		temp = new DAOTemplate<Hehe>();
		temp.setOnMapListener(this);
	}
	
	private Hehe queryOne(){
		String sql = "select * from tdt where id=?";
		Object[] args = {1};
		return temp.queryOne(sql, args);
	}

	@Override
	public Hehe onTransform(ResultSet rs) {
		Hehe hehe = null;
		try {
			int id = rs.getInt("id");
			String name = rs.getString("name");
			Time dt = rs.getTime("send_time");
			Timestamp stamp = rs.getTimestamp("send_time_stamp");
			
			hehe = new Hehe(id,dt,stamp,name);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return hehe;
	}
	
	
}
class Hehe{
	public int id;
	public Time datetime;
	public Timestamp stamp;
	public String name;
	public Hehe(int id, Time datetime, Timestamp stamp,String name) {
		super();
		this.id = id;
		this.datetime = datetime;
		this.stamp = stamp;
		this.name = name;
	}

}