package com.it61.minecraft.common;

import java.sql.ResultSet;

public interface OnTransformListener<T> {
	/**
	 * @param rs
	 * @return
	 */
	T onTransform(ResultSet rs);
}
