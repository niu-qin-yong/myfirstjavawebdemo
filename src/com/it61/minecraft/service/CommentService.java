package com.it61.minecraft.service;

import java.util.List;

import com.it61.minecraft.bean.Comment;
import com.it61.minecraft.bean.Favor;

public interface CommentService {
	void addComment(Comment comment)throws Exception;
	/**
	 * 返回最新的一条留言
	 * @param momentId
	 * @param commenterId
	 * @return
	 * @throws Exception
	 */
	Comment getCommentLatest(Integer momentId,Integer commenterId)throws Exception;
	Comment getCommentByCommenterId(Integer momentId,Integer commenterId)throws Exception;
	List<Comment> getAllCommentsByMomentId(Integer momentId);
}
