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
import com.entiy.Reader;
import com.entiy.User;

public class BrolenDao {
	Connection conn = null;
	PreparedStatement pstmt=null;
	Statement stmt=null;
	ResultSet rs=null;
	public boolean applybro(String returnid){
		String sql="update reader set state='申请退还中' where id=?";
		try{
			conn=DBUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(returnid));
			int rs=pstmt.executeUpdate();				
			//System.out.print(rs.getInt(8));
			if (rs==1) {
				
				return true;
			}
			else{
				return false;
			}
			
		}
		catch (SQLException e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }
		return false;
	}
	public boolean passbro(String passid){
		String sql="update reader set state='已借阅' where id=?";
		try{
			conn=DBUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(passid));
			int rs=pstmt.executeUpdate();				
			//System.out.print(rs.getInt(8));
			if (rs==1) {
				
				return true;
			}
			else{
				return false;
			}
			
		}
		catch (SQLException e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }
		return false;
	}
	public List<Reader> findallbro()
	{
		List<Reader> list=new ArrayList<Reader>();
		String sql="select * from reader where state in('申请借阅','申请退还中','已借阅')";
        try {
            conn=DBUtil.getConnection();  
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();
            System.out.println(rs.getRow());
            while(rs.next()){
            	Reader reader=new Reader(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4));
            	reader.setBook(new LibrarayDao().findABook(reader.getBookid()));
            	reader.setUser(new LibrarayDao().getUser(reader.getReaderid()));
            	//System.out.println(reader.getUser().getUsername());
            	//System.out.println(reader.getBook().getBookname());
                list.add(reader);        
            }
            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }        
        return list;
	}
	public List<Reader> findBrolist(String id)
	{
		List<Reader> list=new ArrayList<Reader>();
		String sql="select * from reader where reader_id=?";
        try {
            conn=DBUtil.getConnection();  
            pstmt=conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            System.out.println(sql);
            rs=pstmt.executeQuery();
            //System.out.println(rs.getRow());
            while(rs.next()){
            	Reader reader=new Reader(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4));
            	reader.setBook(new LibrarayDao().findABook(reader.getBookid()));
            	reader.setUser(new LibrarayDao().getUser(reader.getReaderid()));
            	//System.out.println(reader.getUser().getUsername());
            	//System.out.println(reader.getBook().getBookname());
                list.add(reader);        
            }
            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }        
        return list;
	}
	public int booknumberleft(String bookid){
		String sql="select * from book where book_id=?";
		try{
			conn=DBUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(bookid));
			rs=pstmt.executeQuery();				
			//System.out.print(rs.getInt(8));
			if (rs.next()) {
				int number=rs.getInt(8);
				int left=rs.getInt(9);
				return number-left;
			}
			else{
				return 0;
			}
			
		}
		catch (SQLException e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }
		return 0;
	}
	public boolean borone(String bookid){
		String sql="update book set borrow_number=borrow_number+1 where book_id =?";
		try{
			conn=DBUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,Integer.parseInt(bookid));
			int rs=pstmt.executeUpdate();				
			System.out.print(rs);
			if (rs==1) {
				return true;
			}
			else{
				return false;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }
		return false;
	}		
	public boolean brobook(String userid,String bookid)

	{
		
		String sql="insert into reader(reader_id,book_id,state) values (?,?,'申请借阅')";
		try{
			conn=DBUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, bookid);
			int rs=pstmt.executeUpdate();				
			System.out.print(rs);
			if (rs==1) {
				
				borone(bookid);
				return true;
			}
			else{
				return false;
			}
			
		}
		catch (SQLException e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }
		return false;
	}
	public boolean returnbro(String retid,String bookid){
		  String sql="delete from reader where id=?";
	        try {
	            conn=DBUtil.getConnection();
	            pstmt=conn.prepareStatement(sql);
	            pstmt.setObject(1, retid);
	            int rs=pstmt.executeUpdate();  
	            if(rs==1){
	            	returnone(bookid);
	            	return true;
	            }
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }finally{
	            DBUtil.closeAll(rs, pstmt, conn);
	        }
	        return false;
	}
	public boolean returnone(String bookid){
		String sql="update book set borrow_number=borrow_number-1 where book_id =?";
		try{
			conn=DBUtil.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,Integer.parseInt(bookid));
			int rs=pstmt.executeUpdate();				
			System.out.print(rs);
			if (rs==1) {
				return true;
			}
			else{
				return false;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			// TODO: handle exception
		}finally{
            DBUtil.closeAll(rs, pstmt, conn);
        }
		return false;
	}		
}
