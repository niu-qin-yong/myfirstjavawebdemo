package com.it61.minecraft.common;

public class StringUtils {
	public static boolean isNotEmpty(String str){
		return (str != null)&&(!str.equals("")&&(!str.equals("null")));
	}
}
