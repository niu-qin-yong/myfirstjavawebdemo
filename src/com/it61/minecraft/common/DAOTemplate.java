package com.it61.minecraft.common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public  class DAOTemplate<T> {
	private OnTransformListener< T> listener;
	
	public void setOnMapListener(OnTransformListener< T> mapper){
		this.listener=mapper;
	}
	
	public void update(String sql, Object[] args){
		try {
			Connection conn=null;
			PreparedStatement pstmt=null;
			try {
				conn=ConnectionFactory.getConnection();
				pstmt=conn.prepareStatement(sql);
				for (int i = 0; i < args.length; i++) {
					pstmt.setObject(i+1, args[i]);
				}
				pstmt.executeUpdate();
			} finally {
				ConnectionFactory.close(null, pstmt, conn);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	/**
	 * @param sql
	 * @param args
	 * @return
	 */
	public T queryOne(String sql,Object[] args){  
        T obj=null;  
        try {  
            Connection conn=null;  
            PreparedStatement pstmt=null;  
            ResultSet rs=null;  
            try {  
                conn=ConnectionFactory.getConnection();  
                pstmt=conn.prepareStatement(sql);  
                for (int i = 0; i < args.length; i++) {  
                    pstmt.setObject(i+1, args[i]);  
                }  
                rs=pstmt.executeQuery();  
                if (rs.next()) {  
                    if (listener!=null) { 
                        obj=listener.onTransform(rs);
                    }  
  
                }  
            } finally {  
                ConnectionFactory.close(rs, pstmt, conn);  
            }  
        } catch (Exception e) { 
        	System.out.println(e.getMessage());
        }  
        return obj;  
    }  
	
	/**
	 * @param sql
	 * @param args
	 * @return
	 */
	public List<T> queryAll(String sql,Object[] args){
		List<T>list=new ArrayList<T>();
		try {
			Connection conn=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				conn=ConnectionFactory.getConnection();
				pstmt=conn.prepareStatement(sql);
				if(args != null){
					for (int i = 0; i < args.length; i++) {
						pstmt.setObject(i+1, args[i]);
					}
				}
				rs=pstmt.executeQuery();
				while (rs.next()) {
					if (listener!=null) {
						T obj=listener.onTransform(rs);
						list.add(obj);			
					}
				}
			} finally {
				ConnectionFactory.close(rs, pstmt, conn);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return list;
	}

}
