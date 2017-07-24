package com.it61.minecraft.dao;

import java.io.InputStream;
import java.lang.reflect.Type;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.it61.minecraft.bean.Moment;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class MomentDAO implements OnTransformListener<Moment> {
	private DAOTemplate<Moment> temp;
	
	public MomentDAO(){
		temp = new DAOTemplate<Moment>();
		temp.setOnMapListener(this);
	}
	
	public static void main(String[] args) {
//		
		MomentDAO dao = new MomentDAO();
		Moment moment = dao.findById(1);
		
		JsonSerializer<Date> ser = new JsonSerializer<Date>() {
			  @Override
			  public JsonElement serialize(Date src, Type typeOfSrc, JsonSerializationContext 
			             context) {
			    return src == null ? null : new JsonPrimitive(src.getTime());
			  }

			};
			
		Gson gson = new GsonBuilder()
		.setExclusionStrategies(new ExclusionStrategy() {
			
			@Override
			public boolean shouldSkipField(FieldAttributes f) {
				return f.getName().equals("pic");
			}
			
			@Override
			public boolean shouldSkipClass(Class<?> arg0) {
				return false;
			}
		}).create() ; 
		
		String json = gson.toJson(moment);
		System.out.println(json);
		System.out.println("day==="+moment.getDay());
		System.out.println("time==="+moment.getTime());
		System.out.println("Stamp==="+moment.getStamp());
		
	}

	@Override
	public Moment onTransform(ResultSet rs) {
		try {
			int id = rs.getInt("id");
			int sId = rs.getInt("sender_id");
			Date day = rs.getDate("daytime");
			Time time = rs.getTime("daytime");
			InputStream pic = rs.getBinaryStream("pic");
			String sName = rs.getString("sender_name");
			String content = rs.getString("content");
			Timestamp stamp = rs.getTimestamp("daytime");
			
			return new Moment(content,id,sId,sName,day,time,pic,stamp);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void insert(Moment moment) throws Exception{
		String sql = "insert into moments(sender_id,sender_name,content,pic) values(?,?,?,?)";
		Object[] args = {moment.getSenderId(),moment.getSenderName(),moment.getContent(),moment.getPic()};
		temp.update(sql, args);
	}
	
	/**
	 * 使用 union 操作符合并多个查询的结果集
	 * @param senderIds
	 * @return
	 */
	public List<Moment> getAllMoments(List<Integer> senderIds){
		String sql = "";
		Object[] args = senderIds.toArray();
		for(int i=0;i<senderIds.size();i++){
			
			if(i == 0){
				sql += "select * from moments where sender_id=?";
			}else if(i > 0){
				sql += " UNION ALL select * from moments where sender_id=?";
			}
				
			//左连接，一次查询获取动态和对应的点赞和留言
//			if(i == 0){
//				sql += "select moments.id,moments.content,moments.daytime,moments.sender_id,moments.sender_name"
//					+",favors.id as fid,favors.moment_id,favors.favor_id,favors.favor_name,favors.daytime"
//					+",comments.id as cid,comments.moment_id,comments.content,comments.commenter_id,comments.commenter_name,comments.daytime"
//					+" from moments"
//					+" left join favors"
//					+" on moments.id=favors.moment_id"
//					+" left join comments"
//					+" on moments.id=comments.moment_id"
//					+" where moments.sender_id=?";
//			}else if(i > 0){
//				sql += " UNION ALL select moments.id,moments.content,moments.daytime,moments.sender_id,moments.sender_name"
//						+",favors.id as fid,favors.moment_id,favors.favor_id,favors.favor_name,favors.daytime"
//						+",comments.id as cid,comments.moment_id,comments.content,comments.commenter_id,comments.commenter_name,comments.daytime"
//						+" from moments"
//						+" left join favors"
//						+" on moments.id=favors.moment_id"
//						+" left join comments"
//						+" on moments.id=comments.moment_id"
//						+" where moments.sender_id=?";
//			}
		}
		return temp.queryAll(sql, args);
	}

	/**
	 * 根据动态id返回动态
	 * @param momentId
	 * @return
	 */
	public Moment findById(Integer momentId) {
		String sql = "select * from moments where id=?";
		Object[] args = {momentId};
		return temp.queryOne(sql, args);
	}
	
	/**
	 * 返回指定发送者的最新一条动态
	 * @param senderId
	 * @return
	 */
	public Moment findLatestBySenderId(Integer senderId) {
		String sql = "select * from moments where sender_id=? order by daytime desc limit 1";
		Object[] args = {senderId};
		return temp.queryOne(sql, args);
	}
	
	
}
