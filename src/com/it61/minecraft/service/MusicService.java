package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.Music;

public interface MusicService {
	List<Music> getAllMusic();
	List<Music> searchMusic(String key);
	void addLike(int id,int count)throws Exception;
}
