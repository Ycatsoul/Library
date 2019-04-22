package com.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.omg.CORBA.Request;


import com.dao.LibrarayDao;
import com.entiy.User;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login.do")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * Default constructor. 
     */
    public Login() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession session=request.getSession();
			session.setAttribute("level", "游客");
			request.getRequestDispatcher("from.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("utf-8");
		String type=request.getParameter("type");
		//System.out.println(type);
		String uname=request.getParameter("username");
		String upwd=request.getParameter("psw");	
		String checkpw=request.getParameter("checkpw");
		
//		System.out.println(uname);
//		System.out.println(upwd);
//		System.out.println(checkpw);
		if(type.equals("login")){		
			//验证
			uname=new String(uname.getBytes("ISO-8859-1"),"UTF-8");
			upwd=new String(upwd.getBytes("ISO-8859-1"),"UTF-8");
			userlog(uname, upwd,request,response);
		}
		if(type.equals("adduser")){
			//System.out.println("add fuvtion");
			add(uname, upwd,checkpw,request,response);
		}
		
	}
	//注册方法
	protected void add(String uname,String upwd,String checkpw,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		
		uname=new String(uname.getBytes("ISO-8859-1"),"UTF-8");
		upwd=new String(upwd.getBytes("ISO-8859-1"),"UTF-8");
		checkpw=new String(checkpw.getBytes("ISO-8859-1"),"UTF-8");
		System.out.println(uname);
		System.out.println(upwd);
		System.out.println(checkpw);
		System.out.println("use add");
		LibrarayDao libraryDao=new LibrarayDao();
		if(uname.isEmpty()||upwd.isEmpty())
		{
			//注册为空白
			request.setAttribute("addinfo", "blank");
			request.getRequestDispatcher("adduser.jsp").forward(request, response);
			return;
		}if(uname.length()<6)
		{
			
			request.setAttribute("addinfo", "namelength");
			request.getRequestDispatcher("adduser.jsp").forward(request, response);
			return;
		}
		if(upwd.length()<6)
		{
			
			request.setAttribute("addinfo", "length");
			request.getRequestDispatcher("adduser.jsp").forward(request, response);
			return;
		}
		if(checkpw.equals(upwd)&&libraryDao.addUser(uname, upwd)==true){
			//注册成功
			System.out.print("成功");
			request.setAttribute("addinfo", "true");
			
			request.getRequestDispatcher("adduser.jsp").forward(request, response);
		}
		else if(libraryDao.addUser(uname, upwd)==false){
			request.setAttribute("addinfo", "false");
			request.getRequestDispatcher("adduser.jsp").forward(request, response);
		}
	}
	
	//用户验证方法
	protected void userlog(String uname,String upwd,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		LibrarayDao libraryDao=new LibrarayDao();
		if(uname==""||upwd=="")
		{
			request.setAttribute("loginfo", "blank");
			request.getRequestDispatcher("index.jsp").forward(request, response);
			return;
		}
		User user=libraryDao.getUser(uname, upwd);
		if(user!=null&&user.getUsername().equals(uname)&&user.getUserpassword().equals(upwd)){
			HttpSession session=request.getSession();
			session.setAttribute("username", uname);
			session.setAttribute("level", user.getLeavel());
			session.setAttribute("user", user);//管理员和会员
			if(user.getLeavel().equals("管理员")){
			request.getRequestDispatcher("from.jsp").forward(request, response);
			}
			else if(user.getLeavel().equals("会员")){
				request.getRequestDispatcher("from.jsp").forward(request, response);
			}
			
		}
		else {
			request.setAttribute("loginfo", "false");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	}
}
