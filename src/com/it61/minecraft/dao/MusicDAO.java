package com.it61.minecraft.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.it61.minecraft.bean.Comment;
import com.it61.minecraft.bean.Music;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class MusicDAO implements OnTransformListener<Music> {
	private DAOTemplate<Music> temp;
	
	public static void main(String[] args) {
		MusicDAO dao = new MusicDAO();
		List<Integer> userIds = new ArrayList<Integer>();
		userIds.add(1);
		userIds.add(2);
		List<Music> friendMusic = dao.getFriendMusic(userIds);
		System.out.println(friendMusic.size());
	}

	public MusicDAO() {
		temp = new DAOTemplate<Music>();
		temp.setOnMapListener(this);
	}

	@Override
	public Music onTransform(ResultSet rs) {
		Music m = null;
		try {
			String music = rs.getString("music");
			String poster = rs.getString("poster");
			String title = rs.getString("title");
			int id = rs.getInt("id");
			int count = rs.getInt("like_count");
			int userId = rs.getInt("user_id");
			
			m = new Music(id,userId,music,poster,title,count);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return m;
	}
	
	public List<Music> findSystemMusic(){
		String sql = "select * from musics where server_side = 1";
		Object[] args = {};
		return temp.queryAll(sql, args);
	}

	public List<Music> searchMusic(String key) {
		//这种写法获取不到数据
//		String sql = "select * from musics where singer like '%?%' or title like '%?%' ";
//		Object[] args = {key,key};
		
		String sql = "select * from musics where singer like ? or title like ? ";
		Object[] args = {"%"+key+"%","%"+key+"%"};//注意不要加单引号，MySQL会自动加，否则加上取不到数据
		return temp.queryAll(sql, args);
	}

	public void addLike(int id, int count) throws Exception {
		String sql = "update musics set like_count=? where id=?";
		Object[] args = {count,id};
		temp.update(sql, args);
	}

	public void addMusics(Music m) throws Exception {
		String sql = "insert into musics(music,poster,title,singer,server_side,user_id) values(?,?,?,?,?,?)";
		//初始化参数数组
		Object[] args = new Object[6];
		args[0] = m.getMusic();
		args[1] = m.getPoster();
		args[2] = m.getTitle();
		args[3] = m.getSinger();
		args[4] = m.getServerSide();
		args[5] = m.getUserId();
		
		temp.update(sql, args);
	}

	public Music getLatestMusic(int userId) {
		String sql = "select * from musics where user_id = ? order by upload_time desc limit 1";
		Object[] args = {userId};
		return temp.queryOne(sql, args);
	}

	public List<Music> getMineMusic(int userId) {
		String sql = "select * from musics where user_id = ?";
		Object[] args = {userId};
		return temp.queryAll(sql, args);
	}

	public List<Music> getFriendMusic(List<Integer> userIds) {
		String sql = "select * from musics where user_id in (";
		for(int i=0;i<userIds.size();i++){
			sql += "?,";
		}
		//去掉最后的逗号
		sql = sql.substring(0,sql.length()-1);
		//加上另一个括号
		sql += ")";
		
		Object[] args = userIds.toArray();
		
		return temp.queryAll(sql, args);
	}

}
