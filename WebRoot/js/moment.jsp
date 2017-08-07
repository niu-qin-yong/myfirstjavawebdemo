<%@ page contentType="text/javascript; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.it61.minecraft.bean.*"%>
<%@page import="com.it61.minecraft.service.*"%>
<%@page import="com.it61.minecraft.service.impl.*"%>
<%@page import="com.alibaba.fastjson.*" %>
<%@page import="com.alibaba.fastjson.serializer.*" %>
<%@page import="java.sql.*" %>

<%
User user = (User)session.getAttribute("user");
String webName = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webName+"/";

//获取所有好友
FriendService friService = new FriendServiceImpl();
List<Friend> allFriends = friService.getAllFriends(user);

//获取自己及好友的所有动态
//获取自己及好友的id
List<Integer> senderIds = new ArrayList<Integer>();
senderIds.add(user.getId());
for(Friend fri : allFriends){
	senderIds.add(fri.getFriId());
}
//获取首次显示的动态
MomentService momentService = new MomentServiceImpl();
Timestamp time = new Timestamp(System.currentTimeMillis());
List<Moment> moments = momentService.getMomentsPaging(senderIds,time.toString(),3);
//获取动态的点赞
FavorService favorService = new FavorServiceImpl();
for(Moment m : moments){
	m.setFavors(favorService.getAllFavorsByMomentId(m.getId()));
}
//获取动态的留言
CommentService commentService = new CommentServiceImpl();
for(Moment m : moments){
	m.setComments(commentService.getAllCommentsByMomentId(m.getId()));
}

%>

/*显示首页朋友圈 */
function showMoments(){
	<%
	for(int i=0;i < moments.size();i++){
		Moment m = moments.get(i);
		PropertyFilter filter = new PropertyFilter(){
	
			@Override
			public boolean apply(Object obj, String name, Object value) {
				//返回false表示过滤
				if(name.equals("pic")){
					return false;
				}
				return true;
			}  
			
		};
		String json = JSON.toJSONString(m,filter,SerializerFeature.WriteDateUseDateFormat);
	%>	
	
		var moment = JSON.parse('<%=json%>');
		createMomentElement(moment,false);
	
	<%					
	}
	%>
}

/**
*加载下一组动态
**/
var hasMore = true;
function loadMoreMoments(){
	if(!hasMore){
		alert("亲,没有了！");
		return;
	}
	
	var lastMomentStamp = $('#loadmore').prev().attr("data-daytime");
	var url = "<%=basePath%>"+"servlet/LoadMoreMomentServlet?stamp="+lastMomentStamp;
	$.get(url,function(data,status){
		var moreMoments = JSON.parse(data);
		
		if(moreMoments.length == 0){
			hasMore = false;
			alert("亲,没有了！");
			return;
		}
		
		for(var i=0;i < moreMoments.length;i++){
		 	createMomentElement(moreMoments[i],false);
		}
	});
}

		
/**
*取消点赞
**/
function onCancelFavor(ele){
	var momentId = ele.getAttribute("data-commentId");
	var favorId = "<%=user.getId()%>";
	
	$.post("/minecraft/servlet/FavorCancelServlet"
			,{"momentId":momentId,"favorId":favorId}
			,function(data,status){
				if(data == "favor-cancel-success"){
					/* 在界面上移除点赞者头像 */
					$("#favor"+momentId+favorId).remove();
					/* 改变点赞元素背景和点击事件，再次点击可以点赞 */
					ele.setAttribute("title","点赞");
					ele.style.backgroundImage="url(/minecraft/imgs/like.jpg)";
					ele.setAttribute("onclick","onFavor(this)");							
				}else{
					alert("favor-cancel-fail");
				}
			});
	
}

/**
*点赞
**/
function onFavor(ele){
	var momentId = ele.getAttribute("data-commentId");
	var favorId = "<%=user.getId()%>";
	var favorName = "<%=user.getUserName()%>";
	
	$.post("/minecraft/servlet/FavorAddServlet"
			,{"momentId":momentId,"favorId":favorId,"favorName":favorName}
			,function(data,status){
				if(data == "favor-add-success"){
					/* 在界面上显示点赞者头像 */
					createFavorPhotoEle(momentId,favorId,favorName);
					/* 改变点赞元素背景和点击事件，再次点击取消点赞 */
					ele.setAttribute("title","取消点赞");
					ele.style.backgroundImage="url(/minecraft/imgs/like-cancel.jpg)";
					ele.setAttribute("onclick","onCancelFavor(this)");
				}else{
					alert("favor-add-fail");
				}
			});
}
/**
*创建动态的DOM，并将其添加到父元素中
**/
function createMomentElement(moment,top){
	var container = $("<div></div>");
	container.attr("class","remarks");
	container.attr("data-daytime",moment.stamp);
	
	/* 动态发布者信息 */
	var author = $("<div></div>");
	author.attr("class","remarks-author");
	var photo = $("<img/>");
	photo[0].src="/minecraft/servlet/ShowPicServlet?id="+moment.senderId;
	var authorName = $("<div></div>");
	authorName.attr("class","author-name");
	authorName.html(moment.senderName);
	var authorClass = $("<div></div>");
	authorClass.attr("class","author-class");
	
	var levelImg = $("<img />");
	var level = "<%=user.getLevel()%>";
	var levelUrl = "<%=basePath%>/imgs/star-level-1.png";
	if(Math.floor(level/30) == 2){
		levelUrl = "<%=basePath%>/imgs/star-level-2.png";
	}else if(Math.floor(level/30) == 3){
		levelUrl = "<%=basePath%>/imgs/star-level-3.png";
	}
	levelImg.attr("src",levelUrl);
	
	authorClass.append(levelImg);
	author.append(photo,authorName,authorClass);
	
	/* 动态内容 */
	var content = $("<div></div>");
	content.attr("class","remarks-content");
	
	var text = $("<div></div>");
	text.attr("class","content-text");
	text.html(moment.content);
	var time = $("<div></div>");
	time.attr("class","content-time");
	time.html(moment.stamp);
	var img = $("<img/>");
	img[0].src="/minecraft/servlet/ShowMomentPicServlet?id="+moment.id;
	
	var remarksComments = $("<div></div>");
	remarksComments.attr("class","remarks-comments");
	var favor = $("<div></div>");
	favor.attr("class","comment-like");
	favor.attr("id","comment-like"+moment.id);
	/* 点赞 */
	var span = $("<span></span>");
	if(checkWhetherFavor(moment.favors)){
		/* 已点赞，显示取消 */
		span.attr("data-commentId",moment.id);
		span.attr("onclick","onCancelFavor(this)");
		span[0].style.backgroundImage="url(/minecraft/imgs/like-cancel.jpg)";
		span.attr("title","取消点赞");
	}else{
		/* 未点赞，显示可点赞 */
		span.attr("data-commentId",moment.id);
		span.attr("onclick","onFavor(this)")
		span.attr("title","点赞");
	}
	favor.append(span);

	
	/* 留言  */
	var comments = $("<div></div>");
	comments.attr("class","comment-text");
	comments.attr("id","comment-text"+moment.id);
	var span = $("<span></span>");
	comments.append(span);
	var tarea = $("<textarea> </textarea>");
	tarea.attr("data-momentId",moment.id);
	comments.append(tarea);
	var btn = $("<button></button>");
	btn.html("发表");
	btn.attr("onclick","onComment(this)");
	comments.append(btn);

	
	remarksComments.append(favor);
	remarksComments.append(comments);
	content.append(text,time,img,remarksComments);
	/* 有图片则显示img标签，没有则不显示 */
<%-- 				if("<%=m.getPic()%>" === "null"){
				content.append(text,time,remarksComments);
			}else{
				content.append(text,time,img,remarksComments);
			} --%>
	
	container.append(author,content);
	
	if(top){
	/* 如果top是true，将动态显示在发送动态框的下面*/
		$('#send').after(container);
	}else{
		/* 显示在加载更多框的上面 */
		$("#loadmore").before(container);			
	}
	
	/* 显示所有点赞头像 */
	var favors = moment.favors;
	if(favors != undefined){
		for(var i=0;i < favors.length;i++){
			var favorObj = favors[i];
			createFavorPhotoEle(favorObj.momentId,favorObj.favorId,favorObj.favorName);
		}
	}
	
	/* 显示所有留言 */
	var mms = moment.comments;
	if(mms != undefined){
		for(var j=0;j < mms.length;j++){
			var commentObj = mms[j];
			createCommentEle(commentObj);
		}
	}
}

/**
*判断当前用户是否点赞
**/
function checkWhetherFavor(favors){
	/* 如果favors为undefined,返回false */
	if(favors === undefined){
		return false;
	}
	
	var myid = "<%=user.getId()%>";
	for(var i=0;i < favors.length;i++){
		if(myid == favors[i].favorId){
			return true;
		}
	}
	return false;			
}

/**
*创建留言对应的DOM并添加到父元素中
**/
function createCommentEle(commentObj){
	var comment = $("<div></div>");
	comment.attr("class","comment-style");
	
	var commenterPhoto = $("<img/>");
	commenterPhoto[0].src="/minecraft/servlet/ShowPicServlet?id="+commentObj.commenterId;
	
	var commenterName = $("<p></p>");
	commenterName.attr("class","commenter-name");
	
	commenterName.html("<b>"+commentObj.commenterName+"</b>"+":");
	
	var commentContent = $("<p></p>");
	commentContent.attr("class","comment-content");
	commentContent.html(commentObj.content);
	
	var commentTime = $("<p></p>");
	commentTime.attr("class","comment-time");
	commentTime.html(commentObj.stamp);
	
	comment.append(commenterPhoto,commenterName,commentContent,commentTime);
	$("#comment-text"+commentObj.momentId).append(comment);			
}

/**
*留言
**/
function onComment(btn){
	var textarea = $(btn).prev();
	var content = textarea.val();
	var momentId = textarea.attr("data-momentId");
	var commenterId = "<%=user.getId()%>";
	var commenterName = "<%=user.getUserName()%>";
	
	$.post("/minecraft/servlet/CommentServlet"
			,{"content":content,"momentId":momentId,"commenterId":commenterId,"commenterName":commenterName}
			,function(data,status){
				
				if(status == "success"){
					var commentObj = JSON.parse(data);
					/*修改界面*/
					createCommentEle(commentObj);
					/* 还原输入框,将内容置为空 */
					textarea.val("");
				}else{
					
				}
			});
}

/**
*创建点赞者头像DOM，并添加到父元素
**/
function createFavorPhotoEle(momentId,favorId,favorName){
	var favorPhoto = $("<img/>");
	favorPhoto.attr("id","favor"+momentId+favorId);
	favorPhoto.attr("title",favorName);
	favorPhoto[0].src="/minecraft/servlet/ShowPicServlet?id="+favorId; 
	$("#comment-like"+momentId).append(favorPhoto);
}

/**
*发表朋友圈动态
**/		
function sendMoment(){
     var content = $('#moment').val();
     var file = $('#moment-pic')[0];
     
     /* 检测图片大小 */
     if(file.files[0].size > 65536){
    	 $('#moment-pic').val("");
    	 alert("您上传的图片过大，请上传小于64k的图片");
    	 return false;
     }
     
     var formData = new FormData();
     formData.append("moment",content);
     formData.append("pic",file.files[0]);
     
     /* 发送到服务端保存 */
     $.ajax({
          url:"<%=basePath%>"+"servlet/MomentServlet",
          type:"post",
          data : formData,
          //发送请求前执行，如果返回false取消请求
          beforeSend:function(xhr){
          },
          // 告诉jQuery不要去处理发送的数据
          processData : false,
          // 告诉jQuery不要去设置Content-Type请求头
          contentType : false,
          success:function(data,status){
              
              /* 显示自己发的这条动态在最上面 */
              createMomentElement(JSON.parse(data),true);
              
              /* 清除文本输入框等的内容 */
              $('#moment').val("");
              $('#moment-pic').val("");
          },
          error:function(data,status){
              alert("sendMoment()\n"+data+"========"+status);
          }
     })
     
     
	return false;
}
