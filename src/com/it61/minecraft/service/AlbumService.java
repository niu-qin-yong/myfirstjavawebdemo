package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.Picture;

public interface AlbumService {
	void addAlbum(Album album)throws Exception;
	/**
	 * 获取最新添加的相册
	 * @return
	 */
	Album getAlbumLatest(int userId);
	/**
	 * 获取某个用户的所有相册
	 * @param userId
	 * @return
	 */
	List<Album> getAllAlbums(int userId);
	/**
	 * 上传图片，保存记录到数据库
	 * @param args 要保存的图片数据，依次是userid，albumid，picname
	 */
	void addPictures(Object[] args)throws Exception;

}
