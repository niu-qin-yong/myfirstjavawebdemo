package com.it61.minecraft.bean;

import java.sql.Timestamp;

public class Picture {
	private int id;
	private int userId;
	private int albumId;
	private String name;
	private Timestamp createTime;
	
	public Picture(){};
	
	public Picture(int id, int userId, int albumId, String name,
			Timestamp createTime) {
		super();
		this.id = id;
		this.userId = userId;
		this.albumId = albumId;
		this.name = name;
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
	public int getAlbumId() {
		return albumId;
	}
	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	
}
