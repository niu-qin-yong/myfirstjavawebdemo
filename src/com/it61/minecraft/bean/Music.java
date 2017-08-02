package com.it61.minecraft.bean;

public class Music {
	/**
	 * 音乐的路径
	 */
	private String music;
	/**
	 * 海报
	 */
	private String poster;
	private String title;
	private int id;
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	private int likeCount;
	
	public Music(int id,String music, String poster,String title,int likeCount) {
		super();
		this.id = id;
		this.music = music;
		this.poster = poster;
		this.title = title;
		this.likeCount = likeCount;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMusic() {
		return music;
	}
	public void setMusic(String music) {
		this.music = music;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
}
