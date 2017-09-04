package com.it61.minecraft.service.impl;

import java.util.List;

import com.it61.minecraft.bean.Music;
import com.it61.minecraft.dao.MusicDAO;
import com.it61.minecraft.service.MusicService;

public class MusicServiceImpl implements MusicService{


	@Override
	public List<Music> searchMusic(String key) {
		MusicDAO dao = new MusicDAO();
		return dao.searchMusic(key);
	}

	@Override
	public void addLike(int id, int count) throws Exception {
		MusicDAO dao = new MusicDAO();
		dao.addLike(id,count);
	}

	@Override
	public void addMusics(Music musics) throws Exception {
		MusicDAO dao = new MusicDAO();
		dao.addMusics(musics);
	}

	@Override
	public Music getLatestMusic(int userId) {
		MusicDAO dao = new MusicDAO();
		return dao.getLatestMusic(userId);
	}

	@Override
	public List<Music> getSystemMusic() {
		MusicDAO dao = new MusicDAO();
		return dao.findSystemMusic();
	}

	@Override
	public List<Music> getMineMusic(int userId) {
		MusicDAO dao = new MusicDAO();
		return dao.getMineMusic(userId);
	}

	@Override
	public List<Music> getFriendMusic(List<Integer> userIds) {
		MusicDAO dao = new MusicDAO();
		return dao.getFriendMusic(userIds);
	}

}
