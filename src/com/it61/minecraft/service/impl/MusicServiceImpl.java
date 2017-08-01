package com.it61.minecraft.service.impl;

import java.util.List;

import com.it61.minecraft.bean.Music;
import com.it61.minecraft.dao.MusicDAO;
import com.it61.minecraft.service.MusicService;

public class MusicServiceImpl implements MusicService{

	@Override
	public List<Music> getAllMusic() {
		MusicDAO dao = new MusicDAO();
		return dao.findAllMusic();
	}

}
