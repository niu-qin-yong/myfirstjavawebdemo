package com.it61.minecraft.web.listener;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.common.ConnectionFactory;
import com.it61.minecraft.common.TABLE;
import com.it61.minecraft.common.TABLES;

public class ContextListenerImpl implements ServletContextListener,ServletContextAttributeListener{

	@Override
	public void attributeAdded(ServletContextAttributeEvent event) {
		
	}

	@Override
	public void attributeRemoved(ServletContextAttributeEvent event) {
		
	}

	@Override
	public void attributeReplaced(ServletContextAttributeEvent event) {
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("ContextListenerImpl contextDestroyed");
		ArrayList<User> onlineUsers = (ArrayList<User>) sce.getServletContext().getAttribute("online_users");
		onlineUsers.clear();
		onlineUsers = null;
	}

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("ContextListenerImpl contextInitialized");
		
		//在线好友
		sce.getServletContext().setAttribute("online_users", new ArrayList<User>());
		
		//初始化数据表
		Connection conn = null;
		Statement statement = null;
		try {
			conn = ConnectionFactory.getConnectionToCreateDb();
			statement = conn.createStatement();
			
			String checkDbExist = "show databases like '"+ConnectionFactory.db_name+"'";
			ResultSet dbExistRs = statement.executeQuery(checkDbExist);
			if (dbExistRs.next()) {  
				//数据库已存在，说明库和表都建好了
				return;
			}
			
			String dbCreateSql = "create database "+ConnectionFactory.db_name;
			String selectDb = "use "+ConnectionFactory.db_name;
			statement.execute(dbCreateSql);
			statement.execute(selectDb);
			
			//还未初始化，创建所有表
			ArrayList<String> list = new ArrayList<String>();
			list.add(TABLES.users);
			list.add(TABLES.moments);
			list.add(TABLES.albums);
			list.add(TABLES.comments);
			list.add(TABLES.favors);
			list.add(TABLES.friends);
			list.add(TABLES.musics);
			list.add(TABLES.pictures);
			list.add(TABLES.signs);
			
			for(String sql : list){
				statement.execute(sql);
				System.out.println("创建表 "+sql.substring(0, 20));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
				try {
					if(statement != null){
						statement.close();
					}
					if(conn != null){
						conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
	}

	/**
	 * 读文件然后执行
	 * @param sc
	 * @param conn
	 * @throws Exception
	 */
	private void createTablesFromFile(ServletContext sc,Connection conn) throws Exception{
		 InputStream is = sc.getResourceAsStream("/mc_users.sql");
		 
		 StringBuffer sb = new StringBuffer();
		 BufferedInputStream bis = new BufferedInputStream(is);
		 byte[] buff = new byte[1024];
		 int len = -1;
		 while((len = bis.read(buff)) != -1){
			 sb.append(new String(buff,0,len));
		 }
		 
		 bis.close();
		 is.close();
		 
		 String sql = sb.toString();
		 
		 PreparedStatement ps = conn.prepareStatement(sql);
		 ps.execute();
	}
}
