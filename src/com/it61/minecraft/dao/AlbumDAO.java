package com.it61.minecraft.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.Picture;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class AlbumDAO implements OnTransformListener<Album> {
	private DAOTemplate<Album> temp;
	
	public static void main(String[] args) {
		AlbumDAO dao = new AlbumDAO();
		Object[] ids = {1,1,"cd.jpg",1,2,"ll.jpg"};
		try {
			dao.addPictures(ids);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public AlbumDAO(){
		temp = new DAOTemplate<Album>();
		temp.setOnMapListener(this);
	}

	@Override
	public Album onTransform(ResultSet rs) {
		try {
			int id = rs.getInt("id");
			int userId = rs.getInt("user_id");
			String name = rs.getString("name");
			String des = rs.getString("des");
			Timestamp createTime = rs.getTimestamp("create_time");
			
			return new Album(id, userId, name, des, createTime);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void addAlbum(Album album) throws Exception{
		String sql = "insert into albums(user_id,name,des) values(?,?,?)";
		Object[] args = {album.getUserId(),album.getName(),album.getDes()};
		temp.update(sql,args);
	}

	public Album getAlbumLatest(int userId) {
		String sql = "select * from albums where user_id=? order by create_time desc";
		Object[] args = {userId};
		return temp.queryOne(sql,args);
	}

	public List<Album> getAllAlbums(int userId) {
		String sql = "select * from albums where user_id=?";
		Object[] args = {userId};
		return temp.queryAll(sql,args);
	}

	public void addPictures(Object[] args) throws Exception {
		/**
		 * MySQL一次插入多条记录的方式
		 * insert into pictures(user_id,album_id,pic_name) values(1,2,"1.png"),(1,3,"2.png");
		 * values值之间用逗号隔开
		 */
		String sql = "insert into pictures(user_id,album_id,pic_name) values";
		for(int i=0;i<args.length/3;i++){
			sql += "(?,?,?),";
		}
		//去掉最后一个逗号
		sql = sql.substring(0,sql.length()-1);
		
		temp.update(sql,args);
	}

	
}
