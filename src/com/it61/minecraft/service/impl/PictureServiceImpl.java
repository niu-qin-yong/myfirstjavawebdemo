package com.it61.minecraft.service.impl;

import java.util.List;

import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.Picture;
import com.it61.minecraft.dao.PictureDAO;
import com.it61.minecraft.service.PictureService;

public class PictureServiceImpl implements PictureService{

	@Override
	public List<Picture> getPictures(Album album) {
		PictureDAO dao = new PictureDAO();
		return dao.getPictures(album);
	}

	@Override
	public List<Picture> getPictures(int userId, int albumId) {
		PictureDAO dao = new PictureDAO();
		return dao.getPictures(userId,albumId);
	}

}
