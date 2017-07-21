package com.it61.minecraft.bean;

import java.io.InputStream;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Moment {
	public Moment(){
		
	}
	public Moment(String content, int id, int sendId, String sendName,
			Date day, Time time, InputStream pic,Timestamp stamp) {
		super();
		this.content = content;
		this.id = id;
		this.senderId = sendId;
		this.senderName = sendName;
		this.day = day;
		this.time = time;
		this.pic = pic;
		this.stamp = stamp;
	}
	private String content;
	private int id;
	private int senderId;
	private String senderName;
	private Date day;
	private Time time;
	private InputStream pic;
	private Timestamp stamp;
	
	public Timestamp getStamp() {
		return stamp;
	}
	public void setStamp(Timestamp stamp) {
		this.stamp = stamp;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSenderId() {
		return senderId;
	}
	public void setSenderId(int senderId) {
		this.senderId = senderId;
	}
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
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
	public InputStream getPic() {
		return pic;
	}
	public void setPic(InputStream pic) {
		this.pic = pic;
	}
}
