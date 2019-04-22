package com.entiy;

public class User {
	
	private String userid;
	private String username;
	private String userpassword;
	private String leavel;
	
	public User(String userid, String username, String userpassword,
			String leavel) {
		super();
		this.userid = userid;
		this.username = username;
		this.userpassword = userpassword;
		this.leavel = leavel;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserpassword() {
		return userpassword;
	}
	public void setUserpassword(String userpassword) {
		this.userpassword = userpassword;
	}
	public String getLeavel() {
		return leavel;
	}
	public void setLeavel(String leavel) {
		this.leavel = leavel;
	}
	
}
