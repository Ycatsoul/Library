package com.dbutil;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class DBUtil {
	
	final String JDBCDRIVER="com.mysql.jdbc.Driver";
	final static String DBURL="jdbc:mysql://localhost:3306/javaweb";
	final static String USER="root";
	final static String PASS="root";
	public static Connection getConnection(){
        Connection conn=null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn=DriverManager.getConnection(DBURL,USER,PASS);
           
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

   
    public static void closeAll(ResultSet rs,Statement stmt,Connection conn){
        try {
            if(rs!=null)
                rs.close();
            if(stmt!=null)
                stmt.close();
            if(conn!=null)
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
