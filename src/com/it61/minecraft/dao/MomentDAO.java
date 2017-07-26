package com.it61.minecraft.dao;

import java.io.InputStream;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.PropertyFilter;
import com.alibaba.fastjson.serializer.SerializerFeature;
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
		
		MomentDAO dao = new MomentDAO();
		Moment moment = dao.findById(1);
		
		//分页
/*		List<Integer> senderIds = new ArrayList<Integer>();
		senderIds.add(1);
		senderIds.add(7);
		
		Timestamp time = new Timestamp(System.currentTimeMillis());
		
		List<Moment> momentsPaging = dao.getMomentsPaging(senderIds, "2017-07-25 09:30:21", 3);
		System.out.println(momentsPaging.size());*/
		
		//转json
		PropertyFilter filter = new PropertyFilter(){

			@Override
			public boolean apply(Object obj, String name, Object value) {
				if(name.equals("pic")){
					return false;
				}
				return true;
			}  
			
		};
//		SerializerFeature
//		JSON.toJSONStringWithDateFormat(moment,"",);
		JSON.DEFFAULT_DATE_FORMAT = "yyyy-MM-dd hh:mm:ss"; 
		
		List<Moment> list = new ArrayList<Moment>();
		list.add(moment);
		
		String jsonString = JSON.toJSONString(list,filter,SerializerFeature.WriteDateUseDateFormat);
		System.out.println(jsonString);
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
	 * 分页查询获取动态
	 * @param senderIds
	 * @param time	
	 * @param limit	
	 * @return 返回 senderIds 发表的动态中发表时间晚于 time 的 limit 条记录
	 */
	public List<Moment> getMomentsPaging(List<Integer> senderIds,String time,int limit){
		String sql = "";
		Object[] args = senderIds.toArray();
		for(int i=0;i<senderIds.size();i++){
			if(i == 0){
				sql += "select * from moments where sender_id=? and daytime<'_daytime_'";
			}else if(i > 0){
				sql += " UNION ALL select * from moments where sender_id=? and daytime<'_daytime_'";
			}
		}
		//将sql语句中的_daytime_替换为真实时间，注意replaceAll操作后原来的String并没有改变，要将replaceAll的返回值再赋值给sql
		sql = sql.replaceAll("_daytime_",time);
		sql += " order by daytime desc limit "+limit;
		return temp.queryAll(sql, args);
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
		
		//按时间倒序排序
		sql+=" order by daytime desc";
		
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
