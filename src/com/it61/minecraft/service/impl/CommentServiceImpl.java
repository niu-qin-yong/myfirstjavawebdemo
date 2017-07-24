package com.it61.minecraft.service.impl;

import java.util.List;

import com.it61.minecraft.bean.Comment;
import com.it61.minecraft.dao.CommentDAO;
import com.it61.minecraft.service.CommentService;

public class CommentServiceImpl implements CommentService {

	@Override
	public void addComment(Comment comment) throws Exception {
		CommentDAO dao = new CommentDAO();
		dao.insert(comment);
	}

	@Override
	public Comment getCommentByCommenterId(Integer momentId,Integer commenterId) throws Exception {
		CommentDAO dao = new CommentDAO();
		return dao.findCommentByCommenterId(momentId, commenterId);
	}

	@Override
	public List<Comment> getAllCommentsByMomentId(Integer momentId) {
		CommentDAO dao = new CommentDAO();
		return dao.findAllCommentsByMomentId(momentId);
	}

	@Override
	public Comment getCommentLatest(Integer momentId, Integer commenterId)
			throws Exception {
		CommentDAO dao = new CommentDAO();
		return dao.findCommentLatest(momentId,commenterId);
	}

}
