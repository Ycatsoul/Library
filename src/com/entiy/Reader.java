package com.entiy;


public class Reader {
	private int id;
	//图书id
	private String bookid;
	//会员id
	private String readerid;
	//状态
	private String state;
	
	public Reader(int id,String readerid, String bookid, String state) {
		super();
		this.id=id;
		this.bookid = bookid;
		this.readerid = readerid;
		this.state = state;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Book getBook() {
		return book;
	}
	public void setBook(Book book) {
		this.book = book;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	
	private Book book;
	private User user;
	public String getBookid() {
		return bookid;
	}
	public void setBookid(String bookid) {
		this.bookid = bookid;
	}
	public String getReaderid() {
		return readerid;
	}
	public void setReaderid(String readerid) {
		this.readerid = readerid;
	}
	
}
