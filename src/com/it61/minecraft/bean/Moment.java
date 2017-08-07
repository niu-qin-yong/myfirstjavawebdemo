package com.it61.minecraft.bean;

import java.io.InputStream;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

public class Moment {
	public Moment(){
		
	}
	public Moment(String content, int id, int sendId, String sendName,
			Date day, Time time, InputStream pic,Timestamp stamp,List<Favor> favors,List<Comment> comments) {
		super();
		this.content = content;
		this.id = id;
		this.senderId = sendId;
		this.senderName = sendName;
		this.day = day;
		this.time = time;
		this.pic = pic;
		this.stamp = stamp;
		this.favors = favors;
		this.comments = comments;
	}
	public Moment(String content, int id, int sendId, String sendName,
			Date day, Time time, InputStream pic,Timestamp stamp,int senderLevel) {
		super();
		this.content = content;
		this.id = id;
		this.senderId = sendId;
		this.senderName = sendName;
		this.day = day;
		this.time = time;
		this.pic = pic;
		this.stamp = stamp;
		this.senderLevel = senderLevel;
	}
	private String content;
	private int id;
	private int senderId;
	private String senderName;
	private Date day;
	private Time time;
	private InputStream pic;
	private Timestamp stamp;
	private List<Favor> favors;
	private List<Comment> comments;
	private int senderLevel;
	
	public int getSenderLevel() {
		return senderLevel;
	}
	public void setSenderLevel(int senderLevel) {
		this.senderLevel = senderLevel;
	}
	public List<Favor> getFavors() {
		return favors;
	}
	public void setFavors(List<Favor> favors) {
		this.favors = favors;
	}
	public List<Comment> getComments() {
		return comments;
	}
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}
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
