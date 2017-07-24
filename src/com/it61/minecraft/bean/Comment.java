package com.it61.minecraft.bean;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Comment {
	private int id;
	private int commenterId;
	private int momentId;
	private String commenterName;
	private Date day;
	private Time time;
	private Timestamp stamp;
	private String content;
	
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
	public int getCommenterId() {
		return commenterId;
	}
	public void setCommenterId(int commenterId) {
		this.commenterId = commenterId;
	}
	public int getMomentId() {
		return momentId;
	}
	public void setMomentId(int momentId) {
		this.momentId = momentId;
	}
	public String getCommenterName() {
		return commenterName;
	}
	public void setCommenterName(String commenterName) {
		this.commenterName = commenterName;
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
	public Comment(int id,int commenterId, int momentId, String commenterName,Date day,Time time,Timestamp stamp,String content) {
		super();
		this.id=id;
		this.commenterId = commenterId;
		this.momentId = momentId;
		this.commenterName = commenterName;
		this.commenterName = commenterName;
		this.day=day;
		this.time=time;
		this.stamp=stamp;
		this.content = content;
	}
	public Comment(int commenterId, int momentId, String commenterName,
			String content) {
		super();
		this.commenterId = commenterId;
		this.momentId = momentId;
		this.commenterName = commenterName;
		this.content = content;
	}
	
	
	
	
	
}
