package com.it61.minecraft.bean;

import java.io.Serializable;

public class VIPUser extends User implements Serializable{
	public VIPUser(String userName, String passWord, String phonenumber){
		super(userName,passWord,phonenumber);
		//VIPUser的初始经验值为120，默认User的经验值是30
		setLevel(120);
	}
}
