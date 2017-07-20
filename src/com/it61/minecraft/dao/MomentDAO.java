package com.it61.minecraft.dao;

import java.io.InputStream;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.List;

import com.it61.minecraft.bean.Moment;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class MomentDAO implements OnTransformListener<Moment> {
	private DAOTemplate<Moment> temp;
	
	public MomentDAO(){
		temp = new DAOTemplate<Moment>();
		temp.setOnMapListener(this);
	}

	@Override
	public Moment onTransform(ResultSet rs) {
		try {
			int id = rs.getInt("id");
			int sId = rs.getInt("sender_id");
			Date day = rs.getDate("daytime");
			Time time = rs.getTime("daytime");
			InputStream pic = rs.getBinaryStream("pic");
			String sName = rs.getString("sender_name");
			String content = rs.getString("content");
			
			return new Moment(content,id,sId,sName,day,time,pic);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void insert(Moment moment) throws Exception{
		String sql = "insert into moments(sender_id,sender_name,content,pic) values(?,?,?,?)";
		Object[] args = {moment.getSendId(),moment.getSendName(),moment.getContent(),moment.getPic()};
		temp.update(sql, args);
	}
	
	public List<Moment> getAllMoments(int senderId){
		String sql = "select * from moments where sender_id=?";
		Object[] args = {senderId};
		return temp.queryAll(sql, args);
	}
}
