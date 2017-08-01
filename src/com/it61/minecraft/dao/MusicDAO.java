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
			
			m = new Music(id,music, poster,title);
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

}
