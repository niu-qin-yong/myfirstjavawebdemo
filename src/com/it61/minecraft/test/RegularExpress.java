package com.it61.minecraft.test;

public class RegularExpress {
	public static void main(String[] args) {
		String str = "{\"age\":10,\"name\":\"i'm back! You're gonna die!!\"}";
		System.out.println(str);
		String strnew = str.replaceAll("\'", "\\\\'");
		System.out.println(strnew);
		
	}
}
