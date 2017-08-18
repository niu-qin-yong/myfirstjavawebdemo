package com.it61.minecraft.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.Picture;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;
import com.it61.minecraft.service.PictureService;
import com.it61.minecraft.service.impl.PictureServiceImpl;

public class AlbumDAO implements OnTransformListener<Album> {
	private DAOTemplate<Album> temp;
	
	public static void main(String[] args) {
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

	public void addPictures(List<Picture> pics) throws Exception {
		//对传入参数判断
		if(pics == null || pics.size() == 0){
			return;
		}
		
		//同一用户同一相册下不允许有相同图片，所以先过滤掉重复的
		int userId = pics.get(0).getUserId();
		int albumId = pics.get(0).getAlbumId();
		PictureService picService = new PictureServiceImpl();
		List<Picture> oldPics = picService.getPictures(userId, albumId);
		//也可以遍历 pics ，但边遍历边删除会有问题，所以就遍历已有的图片
		for(Picture picture : oldPics){
			if(pics.contains(picture)){
				// (o==null ? get(i)==null : o.equals(get(i))) 因为已经重新equals，所以比较的不再是对象本身
				pics.remove(picture);
			}
			
			//如果pics已经空了，那就不用比较了，也不用再插入数据库了
			if(pics.size() == 0){
				return;
			}
		}
		
		
		/**
		 * MySQL一次插入多条记录的方式
		 * insert into pictures(user_id,album_id,pic_name) values(1,2,"1.png"),(1,3,"2.png");
		 * values值之间用逗号隔开
		 */
		String sql = "insert into pictures(user_id,album_id,pic_name) values";
		for(int i=0;i<pics.size();i++){
			sql += "(?,?,?),";
		}
		//去掉最后一个逗号
		sql = sql.substring(0,sql.length()-1);
		
		//把user_id,album_id,pic_name依次放到数组里
		Object[] args = new Object[pics.size()*3];
		for(int i=0;i<pics.size();i++){
			Picture picture = pics.get(i);
			args[3*i+0] = picture.getUserId();
			args[3*i+1] = picture.getAlbumId();
			args[3*i+2] = picture.getName();
		}
		
		//或者把user_id,album_id,pic_name依次放到List中，再转到数组中
//		List<Object> temporary = new ArrayList<Object>();
//		for(Picture picture : pics){
//			temporary.add(picture.getUserId());
//			temporary.add(picture.getAlbumId());
//			temporary.add(picture.getName());
//		}
//		Object[] args = temporary.toArray();
		
		temp.update(sql,args);
	}

	
}
