package com.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.LibrarayDao;
import com.entiy.*;

/**
 * Servlet implementation class Book
 */
@WebServlet("/Book.do")
public class Bookservice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Bookservice() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type=request.getParameter("type");
		System.out.println(type+"from bookser");
		if(type.equals("finedata")){
			//System.out.println("go bookmg");
			getbooklist(request, response);
			request.getRequestDispatcher("bookmg.jsp").forward(request, response);
			return;
		}if(type.equals("finebook")){
			String bookname=request.getParameter("bookname");
			bookname=new String(bookname.getBytes("ISO-8859-1"),"UTF-8");
			finebooklist(bookname,request, response);
			request.getRequestDispatcher("bookmg.jsp").forward(request, response);
			return;
		}if(type.equals("checkbook")){
			String bookid=request.getParameter("bookid");
			fineAbook(bookid, request, response);
			request.getRequestDispatcher("bookcheck.jsp").forward(request, response);
			return;
		}if(type.equals("addbook")){			
			addAbook(request, response);			
			return;
		}if(type.equals("delbook")){
			String delid=request.getParameter("delid");
			delbook(delid,request,response);
			getbooklist(request, response);
			request.getRequestDispatcher("bookmg.jsp?type=finedata").forward(request, response);
			return;
		}if(type.equals("changedata")){
			String bookid=request.getParameter("bookid");
			fineAbook(bookid, request, response);
			request.getRequestDispatcher("bookchange.jsp").forward(request, response);
			return;
		}
		
		
	}
	protected void delbook(String bookid,HttpServletRequest request, HttpServletResponse response) {
		new LibrarayDao().delbook(bookid);
	}
	protected void addAbook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bookname=request.getParameter("bookname");
		String bookwriter=request.getParameter("bookwriter");
		String bookpublic=request.getParameter("bookpublic");
		String bookversion=request.getParameter("bookversion");
		String pudate=request.getParameter("pudate");
		String bookprice=request.getParameter("bookprice");
		String booknumber=request.getParameter("booknumber");
		if(bookname.isEmpty()||bookwriter.isEmpty()||bookprice.isEmpty()||booknumber.isEmpty()){
			request.setAttribute("addresult", "blank");
			request.getRequestDispatcher("bookadd.jsp").forward(request, response);
			return;
		}	
		Float bp=Float.parseFloat(bookprice);
		Float bn=Float.parseFloat(booknumber);
		if(bp<0||bn<0){
			request.setAttribute("addresult", "feifa");
			request.getRequestDispatcher("bookadd.jsp").forward(request, response);
			return;
		}
		try {
			bookname=new String(bookname.getBytes("ISO-8859-1"),"UTF-8");
			bookwriter=new String(bookwriter.getBytes("ISO-8859-1"),"UTF-8");
			bookpublic=new String(bookpublic.getBytes("ISO-8859-1"),"UTF-8");
			bookversion=new String(bookversion.getBytes("ISO-8859-1"),"UTF-8");
			pudate=new String(pudate.getBytes("ISO-8859-1"),"UTF-8");
			bookprice=new String(bookprice.getBytes("ISO-8859-1"),"UTF-8");
			booknumber=new String(booknumber.getBytes("ISO-8859-1"),"UTF-8");
			String [] bookdata={bookname,bookwriter,bookpublic,bookversion,pudate,bookprice,booknumber};
			for(int i=0;i<7;i++){
				if(bookdata[i].isEmpty()){bookdata[i]="null";}
			}
			if(new LibrarayDao().addbook(bookdata)){
				request.setAttribute("addresult", "ok");
				request.getRequestDispatcher("bookadd.jsp").forward(request, response);
			}else{
				request.setAttribute("addresult", "no");
				request.getRequestDispatcher("bookadd.jsp").forward(request, response);
			}
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			request.setAttribute("addresult", "feifa");
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	protected void fineAbook(String bookid,HttpServletRequest request, HttpServletResponse response) {
		Book book=new Book();
		book=new LibrarayDao().findABook(bookid);
		System.out.println(book.getBookname());
		//结果保存
		request.setAttribute("book", book);		
	}
	protected void finebooklist(String bookname,HttpServletRequest request, HttpServletResponse response) {
		List<Book> booklist=new ArrayList<Book>();
		booklist=new LibrarayDao().findBook(bookname);
		//结果保存
		request.setAttribute("booklist", booklist);		
	}
	protected void getbooklist(HttpServletRequest request, HttpServletResponse response) {
		List<Book> booklist=new ArrayList<Book>();
		booklist=new LibrarayDao().findAllBook();
		//结果保存
		request.setAttribute("booklist", booklist);		
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type");
		if(type.equals("changedata")){
			System.out.println("gochange");
			changebook(request, response);
		}
	}
	protected void changebook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bookid=request.getParameter("bookid").replaceAll(" ","");
		String bookname=request.getParameter("bookname");
		String bookwriter=request.getParameter("bookwriter");
		String bookpublic=request.getParameter("bookpublic");
		String bookversion=request.getParameter("bookversion");
		String pudate=request.getParameter("pudate");
		String bookprice=request.getParameter("bookprice");
		String booknumber=request.getParameter("booknumber");
		if(bookname.isEmpty()||bookwriter.isEmpty()||bookprice.isEmpty()||booknumber.isEmpty()){
			request.setAttribute("addresult", "blank");
			request.setAttribute("bookid", bookid);
			request.getRequestDispatcher("bookchange.jsp").forward(request, response);
			return;
		}	
		Float bp=Float.parseFloat(bookprice);
		Float bn=Float.parseFloat(booknumber);
		if(bp<0||bn<0){
			request.setAttribute("addresult", "feifa");
			request.setAttribute("bookid", bookid);
			request.getRequestDispatcher("bookchange.jsp").forward(request, response);
			return;
		}
		try {
			bookname=new String(bookname.getBytes("ISO-8859-1"),"UTF-8");
			bookwriter=new String(bookwriter.getBytes("ISO-8859-1"),"UTF-8");
			bookpublic=new String(bookpublic.getBytes("ISO-8859-1"),"UTF-8");
			bookversion=new String(bookversion.getBytes("ISO-8859-1"),"UTF-8");
			pudate=new String(pudate.getBytes("ISO-8859-1"),"UTF-8");
			bookprice=new String(bookprice.getBytes("ISO-8859-1"),"UTF-8");
			booknumber=new String(booknumber.getBytes("ISO-8859-1"),"UTF-8");
			String [] bookdata={bookname,bookwriter,bookpublic,bookversion,pudate,bookprice,booknumber,bookid};
			//写入null
			for(int i=0;i<8;i++){
				if(bookdata[i].isEmpty()){bookdata[i].replaceAll(" ",""); bookdata[i]="null";}
				System.out.println(bookdata[i]);
			}
			if(new LibrarayDao().updatebook(bookdata)){
				request.setAttribute("addresult", "ok");
				request.getRequestDispatcher("bookchange.jsp").forward(request, response);
			}else{
				request.setAttribute("addresult", "no");
				request.getRequestDispatcher("bookchange.jsp").forward(request, response);
			}
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			request.setAttribute("addresult", "feifa");
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
