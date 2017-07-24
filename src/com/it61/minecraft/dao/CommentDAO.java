package com.it61.minecraft.dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

import com.it61.minecraft.bean.Comment;
import com.it61.minecraft.bean.Favor;
import com.it61.minecraft.common.DAOTemplate;
import com.it61.minecraft.common.OnTransformListener;

public class CommentDAO implements OnTransformListener<Comment> {
	private DAOTemplate<Comment> temp;
	
	public CommentDAO(){
		temp = new DAOTemplate<Comment>();
		temp.setOnMapListener(this);
	}

	@Override
	public Comment onTransform(ResultSet rs) {
		Comment comment = null;
		try {
			int id = rs.getInt("id");
			int mid = rs.getInt("moment_id");
			int cid = rs.getInt("commenter_id");
			String cn = rs.getString("commenter_name");
			Date day = rs.getDate("daytime");
			Time time = rs.getTime("daytime");
			Timestamp timestamp = rs.getTimestamp("daytime");
			String content = rs.getString("content");
			comment = new Comment(id,cid,mid,cn,day,time,timestamp,content);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return comment;
	}
	
	public void insert(Comment comment) throws Exception {
		String sql = "insert into comments(moment_id,commenter_id,commenter_name,content) values(?,?,?,?)";
		Object[] args = {comment.getMomentId(),comment.getCommenterId(),comment.getCommenterName(),comment.getContent()};
		temp.update(sql, args);
	}
	
	public Comment findCommentByCommenterId(Integer momentId,Integer commenterId){
		String sql = "select * from comments where moment_id=? and commenter_id=?";
		Object[] args = {momentId,commenterId};
		return temp.queryOne(sql, args);
	}

	public List<Comment> findAllCommentsByMomentId(Integer momentId) {
		String sql = "select * from comments where moment_id=?";
		Object[] args = {momentId};
		return temp.queryAll(sql, args);
	}

	public Comment findCommentLatest(Integer momentId, Integer commenterId) {
		String sql = "select * from comments where moment_id=? and commenter_id=? order by daytime desc limit 1";
		Object[] args = {momentId,commenterId};
		return temp.queryOne(sql, args);
	}
}
