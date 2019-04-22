package com.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.omg.CORBA.Request;

import com.dao.BrolenDao;
import com.entiy.Reader;
import com.entiy.User;

/**
 * Servlet implementation class Brolen
 */
@WebServlet("/Brolen.do")
public class Brolen extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Brolen() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type=request.getParameter("type");
		if(type.equals("finemyborrow")){
			HttpSession session=request.getSession();
			User user=(User)session.getAttribute("user");
			finemybro(user.getUserid(),request,response);
			request.getRequestDispatcher("bromg.jsp").forward(request, response);
		}if(type.equals("borrow")){
			String bookid=request.getParameter("borid");
			if(new BrolenDao().booknumberleft(bookid)<=0){
				//数量不够
				request.setAttribute("broresult", "full");
				request.getRequestDispatcher("bookmg.jsp").forward(request, response);
				return;
			}
			HttpSession session=request.getSession();
			User user=(User)session.getAttribute("user");
			bookbro(user.getUserid(),bookid, request, response);
			request.getRequestDispatcher("bookmg.jsp").forward(request, response);
		}if(type.equals("returnbro")){
			String retid=request.getParameter("retid");
			String bookid=request.getParameter("bookid");
			returnbro(retid,bookid, request, response);
			HttpSession session=request.getSession();
			User user=(User)session.getAttribute("user");
			if(user.getLeavel().equals("会员")){
			request.getRequestDispatcher("Brolen.do?type=finemyborrow").forward(request, response);
			}else if(user.getLeavel().equals("管理员")){
				request.getRequestDispatcher("Brolen.do?type=fineallbro").forward(request, response);
			}
		}if(type.equals("fineallbro")){
			findallbro(request, response);
			request.getRequestDispatcher("adbromg.jsp").forward(request, response);
		}if(type.equals("passbro")){
			String passid=request.getParameter("retid");
			passbro(passid, request, response);
		}if(type.equals("applybor")){
			String returnid=request.getParameter("retid");
			//String bookid=request.getParameter("bookid");
			applybro(returnid, request, response);
		}if(type.equals("passreturn")){
			String returnid=request.getParameter("retid");
			String bookid=request.getParameter("bookid");
			passreturn(returnid, bookid, request, response);
		}
		
	}
	protected void passreturn(String returnid,String bookid, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		if(new BrolenDao().returnbro(returnid,bookid)){
			request.getRequestDispatcher("Brolen.do?type=fineallbro").forward(request, response);
			return;
		}
		else{
			return;
		}
	}
	protected void applybro(String returnid,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		if(new BrolenDao().applybro(returnid)){
			request.getRequestDispatcher("Brolen.do?type=finemyborrow").forward(request, response);
			return;
		}
		else{
			return;
		}
	}
	protected void passbro(String passid,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		if(new BrolenDao().passbro(passid)){
			request.getRequestDispatcher("Brolen.do?type=fineallbro").forward(request, response);
			return;
		}
		else{
			return;
		}
	}
	protected void findallbro(HttpServletRequest request, HttpServletResponse response){
		List<Reader> list=new ArrayList<Reader>();
		list=new BrolenDao().findallbro();
		request.setAttribute("brolist", list);
	}
	protected void returnbro(String retid,String bookid, HttpServletRequest request, HttpServletResponse response){
		if(new BrolenDao().returnbro(retid,bookid)){
			return;
		}
		else{
			return;
		}
	}
	protected void bookbro(String userid,String bookid, HttpServletRequest request, HttpServletResponse response){
		
		if(new BrolenDao().brobook(userid,bookid)){
			request.setAttribute("broresult", "ok");
			return;
		}
		else{
			request.setAttribute("broresult", "no");
			return;
		}
	}
	
	protected void finemybro(String bookid, HttpServletRequest request, HttpServletResponse response){
		List<Reader> list=new ArrayList<Reader>();
		list=new BrolenDao().findBrolist(bookid);
		request.setAttribute("brolist", list);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
