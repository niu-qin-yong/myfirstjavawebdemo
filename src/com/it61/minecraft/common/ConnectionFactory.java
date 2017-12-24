package com.it61.minecraft.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

public class ConnectionFactory {

	private static String driver;
	private static String db_host;
	private static String url;
	private static String user;
	private static String password;
	public static String db_name;

	static{
		//本地调试
//		driver = "com.mysql.jdbc.Driver";
//		db_host = "jdbc:mysql://127.0.0.1:3306/";
//		db_name = "mc";
//		url = db_host+db_name;
//		user = "root";
//		password = "root";
		
		//线上
		driver = "com.mysql.jdbc.Driver";
		db_host = "jdbc:mysql://10.10.62.70:3306/";
		db_name = "minecraft";
		url = db_host+db_name;
		user = "minecraft";
		password = "jFOR0Qqv";
	}
	
	static HashMap<String,String> nameSqls = new HashMap<String,String>();
	
	public static Connection getConnectionToCreateDb() throws Exception{
		Class.forName(driver);
		return DriverManager.getConnection(db_host,user,password);
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
