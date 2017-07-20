package com.it61.minecraft.bean;

import java.io.InputStream;
import java.sql.Date;
import java.sql.Time;

public class Moment {
	public Moment(){
		
	}
	public Moment(String content, int id, int sendId, String sendName,
			Date day, Time time, InputStream pic) {
		super();
		this.content = content;
		this.id = id;
		this.sendId = sendId;
		this.sendName = sendName;
		this.day = day;
		this.time = time;
		this.pic = pic;
	}
	private String content;
	private int id;
	private int sendId;
	private String sendName;
	private Date day;
	private Time time;
	private InputStream pic;
	
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
	public int getSendId() {
		return sendId;
	}
	public void setSendId(int sendId) {
		this.sendId = sendId;
	}
	public String getSendName() {
		return sendName;
	}
	public void setSendName(String sendName) {
		this.sendName = sendName;
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
