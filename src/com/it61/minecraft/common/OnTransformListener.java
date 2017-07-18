package com.it61.minecraft.common;

import java.sql.ResultSet;

public interface OnTransformListener<T> {
	/**
	 * 将 ResultSet 中的数据封装到 JavaBean 中返回
	 * @param rs
	 * @return
	 */
	T onTransform(ResultSet rs);
}
