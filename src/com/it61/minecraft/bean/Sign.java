package com.it61.minecraft.bean;

import java.io.Serializable;
import java.sql.Timestamp;

public class Sign implements Serializable{
	private int id;
	private int user_id;
	private Timestamp sign_time;
	
	
	
	public Sign(int id, int user_id, Timestamp sign_time) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.sign_time = sign_time;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public Timestamp getSign_time() {
		return sign_time;
	}
	public void setSign_time(Timestamp sign_time) {
		this.sign_time = sign_time;
	}
}
