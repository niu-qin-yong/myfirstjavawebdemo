package com.it61.minecraft.bean;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Favor implements Serializable{
	private int id;
	private int momentId;
	private int favorId;
	private String favorName;
	private Date day;
	private Time time;
	private Timestamp stamp;
	
	public Favor(){}
	
	public Favor(int momentId, int favorId, String favorName) {
		super();
		this.momentId = momentId;
		this.favorId = favorId;
		this.favorName = favorName;
	}
	public Favor(int momentId, int favorId) {
		super();
		this.momentId = momentId;
		this.favorId = favorId;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getMomentId() {
		return momentId;
	}
	public void setMomentId(int momentId) {
		this.momentId = momentId;
	}
	public int getFavorId() {
		return favorId;
	}
	public void setFavorId(int favorId) {
		this.favorId = favorId;
	}
	public String getFavorName() {
		return favorName;
	}
	public void setFavorName(String favorName) {
		this.favorName = favorName;
	}
	public Date getDay() {
		return day;
	}
	public void setDay(Date day) {
		this.day = day;
	}
	public Time getTime() {
		return time;
	}
	public void setTime(Time time) {
		this.time = time;
	}
	public Timestamp getStamp() {
		return stamp;
	}
	public void setStamp(Timestamp stamp) {
		this.stamp = stamp;
	}
	
}
