package com.it61.minecraft.service.impl;

import com.it61.minecraft.bean.Sign;
import com.it61.minecraft.bean.User;
import com.it61.minecraft.dao.SignDAO;
import com.it61.minecraft.service.SignService;

public class SignServiceImpl implements SignService {

	@Override
	public boolean hasSign(User user) {
		SignDAO dao = new SignDAO();
		Sign sign = dao.hasSign(user);
		return sign == null ? false : true;
	}

	@Override
	public void sign(User user)throws Exception {
		SignDAO dao = new SignDAO();
		dao.sign(user);
	}

}
