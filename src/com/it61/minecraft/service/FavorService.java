package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.Favor;

public interface FavorService {
	void addFavor(Favor favor)throws Exception;
	void removeFavor(Favor favor)throws Exception;
	List<Favor> getAllFavorsByMomentId(Integer momentId);
}
