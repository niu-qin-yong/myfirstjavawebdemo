package com.it61.minecraft.service.impl;

import java.util.List;

import com.it61.minecraft.bean.Favor;
import com.it61.minecraft.dao.FavorDAO;
import com.it61.minecraft.service.FavorService;

public class FavorServiceImpl implements FavorService{

	@Override
	public void addFavor(Favor favor)throws Exception {
		FavorDAO dao = new FavorDAO();
		dao.insert(favor);
	}

	@Override
	public void removeFavor(Favor favor) throws Exception {
		FavorDAO dao = new FavorDAO();
		dao.delete(favor);
	}

	@Override
	public List<Favor> getAllFavorsByMomentId(Integer momentId) {
		FavorDAO dao = new FavorDAO();
		List<Favor> favors = dao.findAllFavorsByMomentId(momentId);
		return favors;
	}

}
