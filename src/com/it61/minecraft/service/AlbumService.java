package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.Picture;

public interface AlbumService {
	/**
	 * 创建相册
	 * @param album
	 * @throws Exception
	 */
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
	/**
	 * 获取轮播图图片.获取规则：先从第一个相册获取，如果取够了，就返回，否则去下一个相册获取，依次类推，直到取够
	 * @param userId 用户ID
	 * @param size	图片个数
	 */
	List<Picture> getBannerPics(int userId,int count);
}
