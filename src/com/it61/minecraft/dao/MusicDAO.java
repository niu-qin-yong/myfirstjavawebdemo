package com.it61.minecraft.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.it61.minecraft.bean.Comment;
import com.it61.minecraft.bean.Music;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class MusicDAO implements OnTransformListener<Music> {
	private DAOTemplate<Music> temp;
	
	public static void main(String[] args) {
		MusicDAO dao = new MusicDAO();
		List<Music> list = dao.searchMusic("赵");
		System.out.println(list.size());
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
			
			m = new Music(id,music, poster,title,count);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return m;
	}
	
	public List<Music> findAllMusic(){
		String sql = "select * from musics";
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

}
