package com.it61.minecraft.util;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnector {
	private static Connection conn;
	private static Statement stmt;
	
	public static void main(String[] args) {
//		stamMoreRS();
		conn = DBConnector.connect("minecraft", "root", "root");
		DatabaseMetaData md;
		try {
			md = conn.getMetaData();
			System.out.println(md.getDatabaseProductName());
			System.out.println(md.getDriverName());
			System.out.println(md.getURL());
			System.out.println(md.isReadOnly());
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
		

	public static Connection connect(String dbName, String user, String pwd) {

		try {
			// 加载注册驱动器
			Class.forName("com.mysql.jdbc.Driver");
			// 注册驱动器
//			DriverManager.registerDriver(new com.mysql.jdbc.Driver());

			// 建立数据库的连接
			String dburl = "jdbc:mysql://localhost:3306/" + dbName;
			String dbuser = user;
			String dbpwd = pwd;
			conn = DriverManager.getConnection(dburl, dbuser, dbpwd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return conn;
	}
	
	public static void stamMoreRS(){	
		conn = DBConnector.connect("minecraft", "root", "root");
		
		try {
			Statement stam = conn.createStatement();
			String sql = "select id,name from test;select id,name from test where id=2;";
			boolean flag = stam.execute(sql);
			while(flag){
				ResultSet rs = stam.getResultSet();
				System.out.println("rs===========");
				while(rs.next()){
					System.out.println(rs.getInt(1)+":"+rs.getString(2));
				}
				flag = stam.getMoreResults();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
//	public static void close(){
//		//关闭资源
//		 try {
//			conn.close();
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//	    
//	}
}
