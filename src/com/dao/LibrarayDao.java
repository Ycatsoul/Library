package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.dbutil.DBUtil;
import com.entiy.Book;
import com.entiy.User;
import com.mysql.jdbc.Blob;

public class LibrarayDao {
	Connection conn = null;
	PreparedStatement pstmt=null;
	Statement stmt=null;
	ResultSet rs=null;
	
	public void delbook(String id) {
		System.out.println("DAO DEL");
        String sql="delete from book where book_id=?";
        try {
            conn=DBUtil.getConnection();
            pstmt=conn.prepareStatement(sql);
            pstmt.setObject(1, id);
            pstmt.executeUpdate();           	            
            System.out.println("del"+id);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }
    }
	public boolean updatebook(String[]bookdata)
	{
			
			//String sql="insert into book(book_name,book_writer,book_public,book_version,puc_date,book_price,book_number) values (?,?,?,?,?,?,?)";
			String sql="update book set book_name=?,book_writer=?,book_public=?,book_version=?,puc_date=?,book_price=?,book_number=? where book_id=?";
	        try {
	            conn=DBUtil.getConnection();
	            pstmt=conn.prepareStatement(sql);
	            for(int i=0;i<8;i++){
	            	bookdata[i]=bookdata[i].replaceAll(" ","");
	            	if(i==5){
	            		
	            		pstmt.setFloat(i+1, Float.parseFloat(bookdata[i]));
	            	}
	            	else if(i==6||i==7){
	            		System.out.println(bookdata[i]);
	            		
	            		pstmt.setInt(i+1, Integer.parseInt(bookdata[i]));
	            	}	
	            		
	            	 pstmt.setString(i+1, bookdata[i]);
	            }
	            int r=pstmt.executeUpdate();
	            if(r>=1){
	            	 System.out.println("添加成功"); 
	            	 return true;
	            }
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }finally{
	            DBUtil.closeAll(rs, pstmt, conn);	      
	            
	        }
	        return false;
	}	
	public boolean addbook(String[]bookdata)
	{
			
			String sql="insert into book(book_name,book_writer,book_public,book_version,puc_date,book_price,book_number) values (?,?,?,?,?,?,?)";
	        try {
	            conn=DBUtil.getConnection();
	            pstmt=conn.prepareStatement(sql);
	            for(int i=0;i<7;i++){
	            	if(i==5){
	            		pstmt.setFloat(i+1, Float.parseFloat(bookdata[i]));
	            	}
	            	else if(i==6){
	            		pstmt.setInt(i+1, Integer.parseInt(bookdata[i]));
	            	}	
	            	 pstmt.setString(i+1, bookdata[i]);
	            }
	            int r=pstmt.executeUpdate();
	            if(r>=1){
	            	 System.out.println("添加成功"); 
	            	 return true;
	            }
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }finally{
	            DBUtil.closeAll(rs, pstmt, conn);	      
	            
	        }
	        return false;
	}	
	public User getUser(String uname,String upsw)
	{
		//System.out.print("in allselect");		
		 String sql="select * from user where user_name=? and user_password=?";
		try{
			conn=DBUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, uname);
			pstmt.setString(2, upsw);
			rs=pstmt.executeQuery();				
			System.out.print(rs.getRow());
			if (rs.next()) {
				//用户验证成功
				User user=new User(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
				
				return user;
			}
			else{
				return null;
			}
			
		}
		catch (SQLException e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }
		return null;
	}
	public User getUser(String id)
	{
		//System.out.print("in allselect");		
		 String sql="select * from user where user_id=?";
		try{
			conn=DBUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();				
			System.out.print(rs.getRow());
			if (rs.next()) {
				//用户验证成功
				User user=new User(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));
				return user;
			}
			else{
				return null;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }
		return null;
	}
	public boolean addUser(String uname,String upsw)
	{
		if(!isExists(uname, upsw)){		
			String sql="insert into user(user_name,user_password,user_level) values (?,?,'会员')";
	        try {
	            conn=DBUtil.getConnection();
	            pstmt=conn.prepareStatement(sql);
	            pstmt.setString(1, uname);
	            pstmt.setString(2, upsw);          
	            int r=pstmt.executeUpdate();
	            if(r>=1){
	            	 System.out.println("添加成功");           		            	 
	            }
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }finally{
	            DBUtil.closeAll(rs, pstmt, conn);	            
	        }
	        return true;
        }
		else{
			return false;
		}
	}
	//判断是否存在
	public boolean isExists(String uname,String upsw) {
		String sql="select * from user where user_name='"+uname+"' and user_password='"+upsw+"'";
		System.out.println(sql);
		try {
            conn=DBUtil.getConnection();
            Statement stm=conn.createStatement();            
            rs=stm.executeQuery(sql);
            rs.last();
            System.out.println(rs.getRow());
            if(rs.getRow()==1){
            	  //存在        	
            	 return true;
            }
            else{
            	//不存在
            	return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            DBUtil.closeAll(rs, pstmt, conn);            
        }
		return false;
	}
	
	//添加管理员
	public boolean addAdmin(String uname,String upsw)
	{
		if(!isExists(uname, upsw)){		
			String sql="insert into user(user_name,user_password,user_level) values (?,?,'管理员')";
	        try {
	            conn=DBUtil.getConnection();
	            pstmt=conn.prepareStatement(sql);
	            pstmt.setString(1, uname);
	            pstmt.setString(2, upsw);          
	            int r=pstmt.executeUpdate();
	            if(r>=1){
	            	 System.out.println("添加成功");           		            	 
	            }
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }finally{
	            DBUtil.closeAll(rs, pstmt, conn);	            
	        }
	        return true;
        }
		else{
			return false;
		}		
		
	}
	//查看用户
	public List<User> findAllUser()
	{
		List<User> list=new ArrayList<User>();
        String sql="select * from user where user_level='会员'";
        try {
            conn=DBUtil.getConnection();           
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();
            while(rs.next()){
            	User user=new User(rs.getString(1),rs.getString(2), rs.getString(3), rs.getString(4));
            	System.out.println(user.getUsername());
                list.add(user);        
            }
            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }        
        return list;
	}
	//查看图书信息
	public Book findABook(String bookid)
	{
		Book book=new Book();
		String sql="select * from book where book_id=?";
        try {
            conn=DBUtil.getConnection();           
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, bookid);
            rs=pstmt.executeQuery();
            while(rs.next()){
            	book=new Book(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8),rs.getInt(9));
            	//System.out.println(user.getUsername());
                return book;        
            }
            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }        
        return null;
	}
	//查询图书条目
	public List<Book> findBook(String bookname)
	{
		List<Book> list=new ArrayList<Book>();
		String sql="select * from book where book_name like ?";
        try {
            conn=DBUtil.getConnection();  
            System.out.println(bookname);
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, "%"+bookname+"%");
            rs=pstmt.executeQuery();
            while(rs.next()){
            	Book book=new Book(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8),rs.getInt(9));
            	//System.out.println(user.getUsername());
            	System.out.println(book.getBookname());
                list.add(book);        
            }
            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }        
        return list;
	}
	//查看图书数据
	public List<Book> findAllBook()
	{
		List<Book> list=new ArrayList<Book>();
        String sql="select * from book";
        try {
            conn=DBUtil.getConnection();           
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();
            while(rs.next()){
            	Book book=new Book(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8),rs.getInt(9));
            	//System.out.println(user.getUsername());
                list.add(book);        
            }
            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }        
        return list;
	}
	//
	
	//查看所有管理员
	public List<User> findAllAdmin()
	{
		List<User> list=new ArrayList<User>();
        String sql="select * from user where user_level='管理员'";
        try {
            conn=DBUtil.getConnection();           
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();
            while(rs.next()){
            	User user=new User(rs.getString(1),rs.getString(2), rs.getString(3), rs.getString(4));
            	//System.out.println(user.getUsername());
                list.add(user);        
            }
            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }        
        return list;
	}
	//删除用户
	public void deleteUser(String id) {
		System.out.println("DAO DEL");
        String sql="delete from user where user_id=?";
        try {
            conn=DBUtil.getConnection();
            pstmt=conn.prepareStatement(sql);
            pstmt.setObject(1, id);
            pstmt.executeUpdate();           	            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }
    }
	//修改密码
	public boolean changepw(String id,String newpw){
		  String sql="update user set user_password=? where user_id=?";
		  try {
	            conn=DBUtil.getConnection();
	            pstmt=conn.prepareStatement(sql);
	            pstmt.setString(1, newpw);
	            pstmt.setString(2, id);
	            pstmt.executeUpdate();      
	            return true;
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }finally{
	            DBUtil.closeAll(rs, pstmt, conn);
	        }
		  return false;
	}
}
