package com.it61.minecraft.common;

import java.sql.ResultSet;

public interface OnTransformListener<T> {
	/**
	 * �� ResultSet �е����ݷ�װ�� JavaBean �з���
	 * @param rs
	 * @return
	 */
	T onTransform(ResultSet rs);
}
