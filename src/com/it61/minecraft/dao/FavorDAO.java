package com.it61.minecraft.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.it61.minecraft.bean.Favor;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class FavorDAO implements OnTransformListener<Favor> {
	private DAOTemplate<Favor> temp;
	
	public FavorDAO(){
		temp = new DAOTemplate<Favor>();
		temp.setOnMapListener(this);
	}

	@Override
	public Favor onTransform(ResultSet rs) {
		Favor favor = null;
		try {
			int id = rs.getInt("id");
			int mid = rs.getInt("moment_id");
			int fid = rs.getInt("favor_id");
			String fn = rs.getString("favor_name");
			favor = new Favor(mid,fid,fn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return favor;
	}
	
	public void insert(Favor favor) throws Exception{
		String sql = "insert into favors(moment_id,favor_id,favor_name) values(?,?,?)";
		Object[] args = {favor.getMomentId(),favor.getFavorId(),favor.getFavorName()};
		temp.update(sql, args);
	}
}
