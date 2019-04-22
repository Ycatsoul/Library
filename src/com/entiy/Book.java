package com.entiy;

public class Book {
	private String bookid;
	private String bookname;
	private String bookwriter;
	private String bookpublic;
	private String bookversion;
	private String pudate;
	private String bookprice;
	private int booknumber=0;
	private int borrownumber=0;
	
	public Book() {
		super();
	}
	public Book(String bookid, String bookname, String bookwriter,
			String bookpublic, String bookversion, String pudate,
			String bookprice, int booknumber, int borrownumber) {
		super();
		this.bookid = bookid;
		this.bookname = bookname;
		this.bookwriter = bookwriter;
		this.bookpublic = bookpublic;
		this.bookversion = bookversion;
		this.pudate = pudate;
		this.bookprice = bookprice;
		this.booknumber = booknumber;
		this.borrownumber = borrownumber;
	}
	public String getBookid() {
		return bookid;
	}
	public void setBookid(String bookid) {
		this.bookid = bookid;
	}
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	public String getBookwriter() {
		return bookwriter;
	}
	public void setBookwriter(String bookwriter) {
		this.bookwriter = bookwriter;
	}
	public String getBookpublic() {
		return bookpublic;
	}
	public void setBookpublic(String bookpublic) {
		this.bookpublic = bookpublic;
	}
	public String getBookversion() {
		return bookversion;
	}
	public void setBookversion(String bookversion) {
		this.bookversion = bookversion;
	}
	public String getPudate() {
		return pudate;
	}
	public void setPudate(String pudate) {
		this.pudate = pudate;
	}
	public String getBookprice() {
		return bookprice;
	}
	public void setBookprice(String bookprice) {
		this.bookprice = bookprice;
	}
	public int getBooknumber() {
		return booknumber;
	}
	public void setBooknumber(int booknumber) {
		this.booknumber = booknumber;
	}
	public int getBorrownumber() {
		return borrownumber;
	}
	public void setBorrownumber(int borrownumber) {
		this.borrownumber = borrownumber;
	}
	
}
