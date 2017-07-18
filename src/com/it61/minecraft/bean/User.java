package com.it61.minecraft.bean;

import java.io.InputStream;
import java.sql.Date;

public class User {
	private int id;
	private String userName;
	private String passWord;
	private String nickName;
	private String gender;
	private int age;
	private String birth;
	private int banji;
	private String phonenumber;
	private InputStream photo;
	private String star;
	private String email;
	private int grade;
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * 新注册用户
	 * @param userName
	 * @param passWord
	 * @param phonenumber
	 */
	public User(String userName, String passWord, String phonenumber) {
		super();
		this.userName = userName;
		this.passWord = passWord;
		this.phonenumber = phonenumber;
	}
	
	/**
	 * 向数据库添加新用户时使用
	 * @param userName
	 * @param passWord
	 * @param nickName
	 * @param gender
	 * @param age
	 * @param birth
	 * @param banji
	 * @param phonenumber
	 * @param photo
	 */
	public User(String userName, String passWord, String nickName,
			String gender, int age, String birth, int banji,
			String phonenumber, InputStream photo,String star,String email,int grade) {
		super();
		this.userName = userName;
		this.passWord = passWord;
		this.nickName = nickName;
		this.gender = gender;
		this.age = age;
		this.birth = birth;
		this.banji = banji;
		this.phonenumber = phonenumber;
		this.photo = photo;
		this.star = star;
		this.email = email;
		this.grade = grade;
	}
	
	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	/**
	 * 包含id，由数据库记录转成Bean User,或者更新记录时使用
	 * @param id
	 * @param userName
	 * @param passWord
	 * @param nickName
	 * @param gender
	 * @param age
	 * @param birth
	 * @param banji
	 * @param phonenumber
	 * @param photo
	 */
	public User(int id, String userName, String passWord, String nickName,
			String gender, int age, String birth, int banji,
			String phonenumber, InputStream photo,String star,String email,int grade) {
		super();
		this.id = id;
		this.userName = userName;
		this.passWord = passWord;
		this.nickName = nickName;
		this.gender = gender;
		this.age = age;
		this.birth = birth;
		this.banji = banji;
		this.phonenumber = phonenumber;
		this.photo = photo;
		this.star = star;
		this.email = email;
		this.grade = grade;
	}
	public String getStar() {
		return star;
	}

	public void setStar(String star) {
		this.star = star;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public int getBanji() {
		return banji;
	}
	public void setBanji(int banji) {
		this.banji = banji;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public InputStream getPhoto() {
		return photo;
	}
	public void setPhoto(InputStream photo) {
		this.photo = photo;
	}
	
}
