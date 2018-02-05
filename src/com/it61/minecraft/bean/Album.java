package com.it61.minecraft.bean;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

public class Album implements Serializable{

	private int id;
	private int userId;
	private String name;
	private String des;
	private List<Picture> pics;
	private Timestamp createTime;
	
	public Album(int userId,int id){
		this.id=id;
		this.userId=userId;
	}
	
	public Album(int userId,int id,String name){
		this.id=id;
		this.userId=userId;
		this.name = name;
	}
	
	public Album(int userId, String name, String des) {
		super();
		this.userId = userId;
		this.name = name;
		this.des = des;
	}
	public Album(int id,int userId, String name, String des,Timestamp crTimestamp) {
		super();
		this.id = id;
		this.userId = userId;
		this.name = name;
		this.des = des;
		this.createTime = crTimestamp;
	}
	
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public List<Picture> getPics() {
		return pics;
	}
	public void setPics(List<Picture> pics) {
		this.pics = pics;
	}
}
