package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.Picture;

public interface PictureService {
	/**
	 * 获取相册里的所有照片
	 * @param album
	 * @return
	 */
	List<Picture> getPictures(Album album);
	/**
	 * 获取相册里的照片(方法重载)
	 * @param album
	 * @return
	 */
	List<Picture> getPictures(int userId,int albumId);
	/*
	 * 获取相册里部分图片
	 * @param album
	 * @param size
	 * @return
	 */
	List<Picture> getPictures(Album album,int size);
}
