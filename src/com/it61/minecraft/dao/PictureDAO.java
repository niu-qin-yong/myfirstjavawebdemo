package com.it61.minecraft.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.Picture;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class PictureDAO implements OnTransformListener<Picture> {
	private DAOTemplate<Picture> temp;
	
	public PictureDAO(){
		temp = new DAOTemplate<Picture>();
		temp.setOnMapListener(this);
	}
	
	public static void main(String[] args) {
		PictureDAO dao = new PictureDAO();
		List<Picture> pictures = dao.getPictures(new Album(7, 1));
		System.out.println(pictures.size());
		
	}
	
	
	@Override
	public Picture onTransform(ResultSet rs) {
		try {
			int id = rs.getInt("id");
			int userId = rs.getInt("user_id");
			int albumId = rs.getInt("album_id");
			String picName = rs.getString("pic_name");
			Timestamp timestamp = rs.getTimestamp("create_time");
			
			return new Picture(id,userId,albumId,picName,timestamp);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	public List<Picture> getPictures(Album album) {
		String sql = "select * from pictures where user_id=? and album_id=?";
		Object[] args = {album.getUserId(),album.getId()};
		return temp.queryAll(sql,args);
	}
	
	public List<Picture> getPictures(int userId,int albumId) {
		String sql = "select * from pictures where user_id=? and album_id=?";
		Object[] args = {userId,albumId};
		return temp.queryAll(sql,args);
	}
}
