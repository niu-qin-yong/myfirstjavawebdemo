package com.it61.minecraft.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionFactory {

	private static String driver;
	private static String url;
	private static String user;
	private static String password;
	

	static{
		driver="com.mysql.jdbc.Driver";
		url="jdbc:mysql://127.0.0.1:3306/mc";
		user="root";
		password="root";
	}

	public static  Connection getConnection() throws Exception{
		Class.forName(driver);
		return DriverManager.getConnection(url,user,password);
	}
	/**
	 * @param rs
	 * @param pstmt
	 * @param conn
	 * */
	public static void close(ResultSet rs,PreparedStatement pstmt,Connection conn) throws SQLException{
		if (rs!=null) {
			rs.close();
		}
		if (pstmt!=null) {
			pstmt.close();
		}
		if (conn!=null) {
			conn.close();
		}
	}
}
