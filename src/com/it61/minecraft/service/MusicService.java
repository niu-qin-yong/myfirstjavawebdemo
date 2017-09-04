package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.Music;

public interface MusicService {
	/**
	 * 获取服务器上公共的歌曲，对应音乐馆对应的歌曲
	 * @return
	 */
	List<Music> getSystemMusic();
	/**
	 * 搜索
	 * @param key
	 * @return
	 */
	List<Music> searchMusic(String key);
	/**
	 * 点赞
	 * @param id
	 * @param count
	 * @throws Exception
	 */
	void addLike(int id,int count)throws Exception;
	/**
	 * 用户上传歌曲
	 * @param musics
	 * @throws Exception
	 */
	void addMusics(Music musics)throws Exception;
	/**
	 * 获取某个用户最新上传的歌曲
	 * @param userId
	 * @return
	 */
	Music getLatestMusic(int userId);
	/**
	 * 获取我的音乐
	 * @param userId
	 * @return
	 */
	List<Music> getMineMusic(int userId);
	/**
	 * 获取好友音乐
	 * @param userIds
	 * @return
	 */
	List<Music> getFriendMusic(List<Integer> userIds);
	
}
