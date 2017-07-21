package com.it61.minecraft.service.impl;

import com.it61.minecraft.bean.Favor;
import com.it61.minecraft.dao.FavorDAO;
import com.it61.minecraft.service.FavorService;

public class FavorServiceImpl implements FavorService{

	@Override
	public void addFavor(Favor favor)throws Exception {
		FavorDAO dao = new FavorDAO();
		dao.insert(favor);
	}

}
