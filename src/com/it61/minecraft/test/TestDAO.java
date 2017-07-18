package com.it61.minecraft.test;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;

import com.it61.minecraft.bean.User;
import com.it61.minecraft.dao.UserDAO;
import com.it61.minecraft.util.DBConnector;
import com.mysql.jdbc.PreparedStatement;

public class TestDAO {
	private static Statement statement;
	private static ResultSet resultSet;
	private static Connection conn;
	private PreparedStatement ps;
	

	
	public int insert(String name,InputStream blobInputStream){
		conn = DBConnector.connect("minecraft", "root", "root");
		try {
			String sql = "insert into test (name,pic) values(?,?)";
			ps = (PreparedStatement) conn.prepareStatement(sql);
			
			ps.setString(1,name);
//			ps.setBlob(2, blobInputStream);
			ps.setBinaryStream(2, blobInputStream);
			
			int count = ps.executeUpdate();
			return count;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				ps.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return 0;
	}

	public void query(String  name) {
		conn = DBConnector.connect("minecraft", "root", "root");
		try {
			String sql = "select * from test where name='"+name+"'";
			ps = (PreparedStatement) conn.prepareStatement(sql);
			resultSet = ps.executeQuery();
			
			while(resultSet.next()){
				int id = resultSet.getInt(1);
//				Blob blob = resultSet.getBlob(2);
				InputStream binaryStream = resultSet.getBinaryStream(2);
				
				//��ͼƬ�洢�ڱ����ļ�
				FileOutputStream fos = null;
				BufferedInputStream bis = null;
				try {
					File file = new File("d://"+name+".jpg");
					fos = new FileOutputStream(file);
					bis = new BufferedInputStream(binaryStream);
					byte[] buff = new byte[2*1024];
					int len = -1;
					while((len = bis.read(buff)) != -1){
						fos.write(buff, 0, len);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}finally{
					try {
						fos.close();
						bis.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				resultSet.close();
				statement.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
	}
	

}
