package com.it61.minecraft.bean;

public class Friend {
	private int id;
	private int owerId;
	private int friId;
	private String friName;
	
	public Friend(){
		
	}
	
	public Friend(int owerId,int friId){
		this.owerId = owerId;
		this.friId = friId;
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOwerId() {
		return owerId;
	}
	public void setOwerId(int owerId) {
		this.owerId = owerId;
	}
	public int getFriId() {
		return friId;
	}
	public void setFriId(int friId) {
		this.friId = friId;
	}
	public String getFriName() {
		return friName;
	}
	public void setFriName(String friName) {
		this.friName = friName;
	}
	
}
