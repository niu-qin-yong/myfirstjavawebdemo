package com.it61.minecraft.service.impl;

import java.util.List;

import com.it61.minecraft.bean.Album;
import com.it61.minecraft.bean.Picture;
import com.it61.minecraft.dao.AlbumDAO;
import com.it61.minecraft.service.AlbumService;


public class AlbumServiceImpl implements AlbumService {

	@Override
	public void addAlbum(Album album) throws Exception {
		AlbumDAO dao = new AlbumDAO();
		dao.addAlbum(album);
	}

	@Override
	public Album getAlbumLatest(int userId) {
		AlbumDAO dao = new AlbumDAO();
		return dao.getAlbumLatest(userId);
	}

	@Override
	public List<Album> getAllAlbums(int userId) {
		AlbumDAO dao = new AlbumDAO();
		return dao.getAllAlbums(userId);
	}

	@Override
	public void addPictures(Object[] args) throws Exception{
		AlbumDAO dao = new AlbumDAO();
		dao.addPictures(args);
	}

}
