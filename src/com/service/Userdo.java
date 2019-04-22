package com.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.LibrarayDao;

/**
 * Servlet implementation class Userdo
 */
@WebServlet("/Userdo")
public class Userdo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Userdo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type=request.getParameter("type");
		if(type.equals("openchange")){
			request.setAttribute("openpw", "true");
			request.getRequestDispatcher("myinfo.jsp").forward(request, response);
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type");
		if(type.equals("changepw")){
			changepw(request,response);
		}
	}
	protected void changepw(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id=request.getParameter("userid");
		String oldpw=request.getParameter("oldpw");
		String newpw=request.getParameter("newpw");
		System.out.println("修改密码"+id);
		oldpw=new String(oldpw.getBytes("ISO-8859-1"),"UTF-8");
		newpw=new String(newpw.getBytes("ISO-8859-1"),"UTF-8");
		if(oldpw.isEmpty()||newpw.isEmpty()){
			request.setAttribute("changeresult", "blank");
			request.getRequestDispatcher("myinfo.jsp").forward(request, response);
			return;
		}	
		if(!oldpw.equals(newpw)){
			if(new LibrarayDao().changepw(id,newpw)){
				request.setAttribute("changeresult", "ok");
				request.getRequestDispatcher("myinfo.jsp").forward(request, response);
				return;
			}else{
				request.setAttribute("changeresult", "no");
				request.getRequestDispatcher("myinfo.jsp").forward(request, response);
				return;
			}
		}
		else {
			request.setAttribute("changeresult", "same");
			request.getRequestDispatcher("myinfo.jsp").forward(request, response);
			return;
		}
	}
}
