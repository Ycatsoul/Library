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

import com.dao.LibrarayDao;
import com.entiy.User;

/**
 * Servlet implementation class Admintor
 */
@WebServlet("/Admintor.do")
public class Admintor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Admintor() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String type=request.getParameter("type");
		System.out.println(type);
		if(type.equals("fineadmin")){
			getAdminlist(request, response);
			request.getRequestDispatcher("admg.jsp").forward(request, response);
			return;
		}
		else if(type.equals("delad"))
		{
			delad(request, response);		
			getAdminlist(request, response);
			request.getRequestDispatcher("admg.jsp").forward(request, response);
			return;
		}
		else if(type.equals("fineuser"))
		{
			getUserlist(request, response);			
			request.getRequestDispatcher("usermg.jsp").forward(request, response);
			return;
		}
		else if(type.equals("deluser")){
			System.out.println("deluser");
			deluser(request, response);			
			getUserlist(request, response);
			request.getRequestDispatcher("usermg.jsp").forward(request, response);
			return;
		}
	}
	protected void deluser(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("deluser fuction");
		String id=request.getParameter("delid");
		LibrarayDao librarayDao=new LibrarayDao();
		librarayDao.deleteUser(id);
		getUserlist(request, response);
		
			
	}
	protected void delad(HttpServletRequest request, HttpServletResponse response) {
		String id=request.getParameter("delid");
		LibrarayDao librarayDao=new LibrarayDao();
		librarayDao.deleteUser(id);
		getAdminlist(request, response);
			
	}
	//查找用户
	protected void getUserlist(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("fine userlist");
		List<User> userlist=new ArrayList<User>();
		userlist=new LibrarayDao().findAllUser();
		//结果保存
		request.setAttribute("userlist", userlist);		
	}
	//查找管理员
	protected void getAdminlist(HttpServletRequest request, HttpServletResponse response) {
		List<User> adminlist=new ArrayList<User>();
		adminlist=new LibrarayDao().findAllAdmin();
		//结果保存
		request.setAttribute("adlist", adminlist);		
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type=request.getParameter("type");	
		//String menu=request.getParameter("menu");
		System.out.println("post");
		//HttpSession session=request.getSession();
		
		if(type.equals("addAdmin")){
			//System.out.println("add fuvtion");
			addad(request,response);
			getAdminlist(request, response);
			request.getRequestDispatcher("admg.jsp").forward(request, response);
		}
		if(type.equals("adduser")){
			//System.out.println("add fuvtion");
			adduser(request,response);
			getUserlist(request, response);
			request.getRequestDispatcher("usermg.jsp").forward(request, response);
		}
		return;
		
	}
	protected void adduser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String uname=request.getParameter("username");
		String upwd=request.getParameter("psw");	
		String checkpw=request.getParameter("checkpw");
		uname=new String(uname.getBytes("ISO-8859-1"),"UTF-8");
		upwd=new String(upwd.getBytes("ISO-8859-1"),"UTF-8");
		checkpw=new String(checkpw.getBytes("ISO-8859-1"),"UTF-8");
		System.out.println("admin add");
		LibrarayDao libraryDao=new LibrarayDao();
		if(uname.isEmpty()||upwd.isEmpty()||checkpw.isEmpty())
		{
			//注册为空白
			request.setAttribute("addAdmininfo", "blank");
			
			//request.getRequestDispatcher("usermg.jsp").forward(request, response);
			
			return;
			
		}
		if(uname.length()<6)
		{
			request.setAttribute("addAdmininfo", "namelength");
			return;
		}
		if(upwd.length()<6)
		{
			//注册为空白
			request.setAttribute("addAdmininfo", "length");		
			//request.getRequestDispatcher("admg.jsp").forward(request, response);			
			return;
			
		}
		if(checkpw.equals(upwd)&&libraryDao.addUser(uname, upwd)==true){
			//注册成功
			System.out.print("成功");
			request.setAttribute("addAdmininfo", "true");
			
			//request.getRequestDispatcher("usermg.jsp").forward(request, response);		
			return;
		}
		else{
			request.setAttribute("addAdmininfo", "false");	
			
			//request.getRequestDispatcher("usermg.jsp").forward(request, response);		
			return;
		}
	}
	protected void addad(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String uname=request.getParameter("username");
		String upwd=request.getParameter("psw");	
		String checkpw=request.getParameter("checkpw");
		uname=new String(uname.getBytes("ISO-8859-1"),"UTF-8");
		upwd=new String(upwd.getBytes("ISO-8859-1"),"UTF-8");
		checkpw=new String(checkpw.getBytes("ISO-8859-1"),"UTF-8");
		System.out.println("admin add");
		LibrarayDao libraryDao=new LibrarayDao();
		if(uname.isEmpty()||upwd.isEmpty()||checkpw.isEmpty())
		{
			//注册为空白
			request.setAttribute("addAdmininfo", "blank");		
			return;
		}
		if(uname.length()<6)
		{
			request.setAttribute("addAdmininfo", "namelength");
			return;
		}
		if(upwd.length()<6)
		{
			request.setAttribute("addAdmininfo", "length");		
			return;
		}
		if(checkpw.equals(upwd)&&libraryDao.addAdmin(uname, upwd)==true){
			//注册成功
			System.out.print("成功");
			request.setAttribute("addAdmininfo", "true");			
			return;
		}
		else{
			request.setAttribute("addAdmininfo", "false");			
			return;
		}
	}
}
