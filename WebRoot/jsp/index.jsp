<%@ page language="java" import="java.util.*"  pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.it61.minecraft.bean.*"%>
<%@page import="com.it61.minecraft.common.*"%>
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

//获取所有在线用户
ArrayList<User> onlineUsers = (ArrayList<User>)getServletContext().getAttribute("online_users");

//获取在线好友
List<Friend> onlineFriends = new ArrayList<Friend>();
for(Friend fri : allFriends){
	for(User u : onlineUsers){
		if(fri.getFriId() == u.getId()){
			onlineFriends.add(fri);
		}
	}
}

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

//获取轮播图图片，规则：默认最多5张随机图片，不包含重复的
AlbumService albumService = new AlbumServiceImpl();
int count = 5;
List<Picture> bannerPics = albumService.getBannerPics(user.getId(), count);
String bannerPicsString = JSON.toJSONString(bannerPics);
%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>我的世界</title>
		<link rel="stylesheet" href="css/index.css"/>
		<link rel="stylesheet" type="text/css" href="plugin/kalendae/css/kalendae.css">
		<link rel="stylesheet" href="css/classroom.css">
		<link rel="stylesheet" href="css/schoolfellow.css">
		<link rel="stylesheet" href="css/friend.css">
		<link rel="stylesheet" href="css/chat.css">
		<link rel="stylesheet" href="css/music.css">
		<link rel="stylesheet" href="css/album.css">
		<link rel="stylesheet" href="plugin/bootstrap/bootstrap.min-4.0.0-alpha.6.css">
		<link rel="stylesheet" href="plugin/viewer/viewer-v-js.css">
	
 	</head>
	<body>
		<!-- 初始化JavaScript变量 -->
		<script>
			/* 应用路径 */
			var basePath = "<%=basePath%>";
			
			/* 轮播图图片 */
			var bannerPicsObj = JSON.parse('<%=bannerPicsString%>');
			var bannerPhotoes = [];
			for(var i=0;i<bannerPicsObj.length;i++){
				var picObj = bannerPicsObj[i];
				var picUrl = basePath+"pictures/"+picObj.userId+"/"+picObj.albumId+"/"+picObj.name;
				var photo = {"i":i+1,"img":picUrl};
				bannerPhotoes.push(photo);
			}

		</script>
		
		<!-- 用户登录部分 -->
		<%
		String username = user.getUserName();
		if(username != null){
		%>
		<div id="welcome">欢迎<div id="username-welcome"><%=username %></div>&nbsp;&nbsp;<a href="<%=basePath%>servlet/LogoutServlet">注销</a></div>
		<%}%>
		<!--外部框架-->
		<div id="base">
		<!--头部部分-->
			<header>
				<!--logo部分-->
				<div id="banner">
					<img src="imgs/logo.gif" alt="logo">
				</div>
				<!--顶部导航栏部分-->
				<nav>
					<div id="friendzone0" class="navct">
						<a href="#"> </a>
					</div>
					<div id="photo1" class="navct">
						<a href="#"> </a>
					</div>
					<div id="dairy2" class="navct">
						<a href="#"> </a>
					</div>
					<div id="plan3" class="navct">
						<a href="#"> </a>
					</div>
					<div id="mgame4" class="navct">
						<a href="#"> </a>
					</div>
				</nav>
			</header>
			<!--左边快速导航栏-->
			<aside id="left-side">
				<div id="signIn" onclick="sign()"> </div>
				<ul id="lnav">
					<li id="friends5" class="lnavc">
						<a href="#" > </a>
					</li>
					<li id="classname6" class="lnavc">
						<a href="#" > </a>
					</li>
					<li id="schoolfellow7" class="lnavc">
						<a href="#" > </a>
					</li>
					<li id="music8" class="lnavc">
						<a href="#" > </a>
					</li>
					<li id="setting9" class="lnavc">
						<a href="#" > </a>
					</li>
				</ul>
			</aside>
			<!--主体内容部分-->
			<section id="contentView">
				<div id="content">
					<div id="friendzone" class="showcontent">
						<div id="send" style="margin-bottom: 10px">
							<form onsubmit="return sendMoment()" id="momentform">
								 <textarea name="moment-text" id="moment_txt_content"  placeholder="说点什么吧"></textarea><br/>
								 <div id="moment-pic-wrap">
								 	<input type="file" name="moment-pic" id="moment-pic" accept="image/png,image/jpeg"/>
								 </div>
								 <div id="moment-send-wrap">
									 <input id="moment-send" type="submit" value="发表"/>
								 </div>                    			 
                    		</form>
						</div>
						<div id="loadmore">
							<button onclick="loadMoreMoments()">点击加载更多</button>
						</div>
					</div>
					<div id="album" class="showcontent">
						<div class="album-header">
							<div id="show-album-create" onclick="album.showAlbumCreate()"></div>
							<!-- <button id="album-create"  data-toggle="modal" data-target="#create-album" >创建相册</button>
							创建相册的模态框
							<div class="modal fade" id="create-album" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<h4 class="modal-title" id="myModalLabel">
												创建相册
											</h4>											
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
												&times;
											</button>
										</div>
										<div class="modal-body">
											<input id="album-create-name" name="ablum-name" class="form-control" placeholder="相册名称" /><br/>
											<input id="album-create-des" name="ablum-des" class="form-control" placeholder="相册描述"/>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">关闭
											</button>
											<button type="button" class="btn btn-primary" data-dismiss="modal" onclick='album.createAlbum()'>
												创建
											</button>
										</div>										
									</div>
								</div>
							</div> -->
							<!-- 缩略图浏览的模态框 -->
<!-- 							<div class="modal fade" id="album-brower" role="dialog" aria-labelledby="modalLabel" tabindex="-1">
							     <div class="modal-dialog">
							       <div class="modal-content">
							         <div class="modal-header">
							           <h4 class="modal-title" id="modalLabel">浏览相册</h4>
							           <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							         </div>
							         <div class="modal-body">
							           <div id="galley">
							              <ul class="album-pictures" id="pictures-container">
							              </ul>
							            </div>
							         </div>
							         <div class="modal-footer" id="modal-footer">
							           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							         </div>
							       </div>
							     </div>
							   </div> -->							
						</div>
						<!-- 相册轮播图 -->
						<div id="slider">

						</div>						
						<!-- 相册内容区 -->
						<div class="album-content" id="album-content">
						</div>
					</div>
					<div id="dairy" class="showcontent">
						<div id="dairyleft">
							<div id="operation">
								<div id="opr-left">
									<span> </span><span> </span>
								</div>
								<div id="opr-right">
									<span> </span><span>草稿箱</span>
									<span> </span><span>回收站</span>
								</div>
							</div>
							<div id="dairycontent">
								<table>
									<tr>
										<td><span>[顶]</span><a href="#">我的新年大计划</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">女生为什么那么喜欢星座</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">科技馆奇妙夜</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">门外的班主任</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">阿里巴巴的秘密</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">12星座谁最具有内在美</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">12月10日</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><span>[转]</span><a href="#">我们怎么才能远离雾霾</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">编程十法&nbsp;</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><a href="#">00后八大派 你是哪一派？&nbsp;</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
									<tr>
										<td><span>[转]</span><a href="#">龙的九个儿子！大家知道几个！</a></td>
										<td><a href="#">编辑</a><span> </span></td>
									</tr>
								</table>
							</div>
						</div>
						<div id="dairyright">
							<!-- 顶部功能区 搜索+日历 -->
							<div id="newshead">
								<input type="text" value="搜索">
								<div id="calendar">
									
								</div>
							</div>
							<!-- 底部热门消息区 -->
							<div id="newslist">
								<div>
									<img src="imgs/d16.png"/>
									<span>惊吓！在喜马拉雅山上驾车时是一种什么体验</span>
									<br/>
									<p>
										<span> </span>
										<a href="#">感兴趣</a>
										<a href="#">121</a>
									</p>
								</div>
								<div>
									<img src="imgs/d17.png"/>
									<span>气象局停发霾预警？回应：正协商联合发布机制</span>
									<br/>
									<p>
										<span> </span>
										<a href="#">感兴趣</a>
										<a href="#">169</a>
									</p>
								</div>
								<div>
									<img src="imgs/d18.png"/>
									<span>亲情是最浓的年味,联合15所高校奏响家庭欢乐颂</span>
									<br/>
									<p>
										<span> </span>
										<a href="#">感兴趣</a>
										<a href="#">234</a>
									</p>
								</div>
							</div>
						</div>
					</div>
					<div id="studyplan" class="showcontent">
						学习计划
					</div>
					<div id="mgame" class="showcontent">
						<div class="userinfo">
                    		<div class="userphoto"> </div>
                    		<div class="username">Chindy</div>
		                    <div class="userlevel"> </div>
		                    <div id="recentgame" class="unitgame">最近游戏</div>
		                    <div id="gamecenter" class="unitgame">游戏大厅</div>
		                </div>
						<div id="gamelist">
		                    <div class="gamelistitem" id="gameitem1">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                    </div>
		                    <div class="gamelistitem" id="gameitem2">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                    </div>
		                    <div class="gamelistitem" id="gameitem3">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                    </div>
		                    <div class="gamelistitem" id="gameitem4">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                     </div>
		                    <div class="gamelistitem" id="gameitem5">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                    </div>
		                    <div class="gamelistitem" id="gameitem6">
		                        <div class="gamenum"> </div>
		                        <div class="gamephoto"> </div>
		                        <div class="gamename"> </div>
		                    </div>
		                </div>
					</div>
					<div id="friendd6" class="showcontent">
						<div class="classmask"></div>
		                <div class="friendbgdecoration"></div>
		                <div class="friendcontent" id="friendcontent">
		                	<div class="multichat" onclick="multichat()"></div>
		                </div>
					</div>
					<div id="classname" class="showcontent">
		                <div class="classmask"></div>
		                <div class="classbgdecoration"></div>
		                <div class="classmate" id="classmate">
		                
		                </div>				
					</div>
					<div id="schoolfellows8" class="showcontent">
		                <div class="classmask"></div>
		                <div class="schoolbgdecoration"></div>
		                <div class="schoolfellowcontent" id="schoolfees">
		                </div>						
					</div>
					<div id="music" class="showcontent">
						<div id="music-head">
							<div id="allMusic" onclick="player.showMusics('music-content')" ></div>
							<div id="friendMusic" onclick="player.showMusics('music-friend')" ></div>
							<div id="mineMusic" onclick="player.showMusics('music-mine')" ></div>
							<input type="text" placeholder="输入单曲或歌手,按回车键搜索" id="music_search_input">
						</div>
						<div id="music-content" class="music-container">
						</div>
						<div id="music-mine" class="music-container">
							<div id="show-music-upload" onclick="showMusicUpload()">
							</div>
						</div>
						<div id="music-friend" class="music-container">
						</div>
						<div id="music-search" class="music-container">
						</div>
						<audio id="player" autoplay="autoplay" loop="true"></audio>
					</div>
					<form id="settingform" onsubmit="return ajax_submit_setting()">
					<div id="setting" class="showcontent">
						<div class="userinfo">
							
							<div class="userphoto" id="userphoto">
								<a href="javascript:;">
									<input type="file" name="photo" accept="image/png,image/jpeg" onchange="preView(this,$('#userphoto')[0])"/>
								</a>
							</div>
							
							<div class="username">
								<%=user.getUserName() %>
							</div>
							<div > 
								<img id="userlevel"/>
							</div>
						</div>
						<div id="edit">
							<div id="nick">
								<span> </span>
								<input type="text" name="nickname" value="<%=user.getNickName()%>"/>
							</div>
							<div id="age">
								<span> </span>
								<input type="number" min="1" name="age" value="<%=user.getAge()%>"/>
							</div>
							<div id="birthday">
								<span>  </span>
								<input type="date" name="birthday" value="<%=user.getBirth()%>"/>
							</div>
							<div id="star">
								<span> </span>
								<select name="star" id="star-select">
									<option value="<%=Stars.BYZ%>"><%=Stars.BYZ%></option>
									<option value="<%=Stars.JNZ%>"><%=Stars.JNZ%></option>
									<option value="<%=Stars.SHUANGZZ%>"><%=Stars.SHUANGZZ%></option>
									<option value="<%=Stars.JXZ%>"><%=Stars.JXZ%></option>
									<option value="<%=Stars.SHIZZ%>"><%=Stars.SHIZZ%></option>
									<option value="<%=Stars.TCZ%>"><%=Stars.TCZ%></option>
									<option value="<%=Stars.TXZ%>"><%=Stars.TXZ%></option>
									<option value="<%=Stars.SSZ%>"><%=Stars.SSZ%></option>
									<option value="<%=Stars.MJZ%>"><%=Stars.MJZ%></option>
									<option value="<%=Stars.SPZ%>"><%=Stars.SPZ%></option>
									<option value="<%=Stars.SYZ%>"><%=Stars.SYZ%></option>
								</select>
							</div>
							<div id="mail">
								<span> </span>
								<input type="text" name="email" value="<%=user.getEmail()%>"/>
							</div>
							<div id="myclass">
								<span> </span>
								<select name="grade" id="grade">
									<option value="1">1年级</option>
									<option value="2">2年级</option>
									<option value="3">3年级</option>
									<option value="4">4年级</option>
									<option value="5">5年级</option>
									<option value="6">6年级</option>
									<option value="7">7年级</option>
									<option value="8">8年级</option>
									<option value="9">9年级</option>
								</select>
								<select name="banji" id="banji">
									<option value="1">1班</option>
									<option value="2">2班</option>
									<option value="3">3班</option>
									<option value="4">4班</option>
									<option value="5">5班</option>
									<option value="6">6班</option>
									<option value="7">7班</option>
								</select>
							</div>
							<div id="phone">
								<span> </span>
								<input type="text" value="<%=user.getPhonenumber()%>" name="phonenumber"/>
							</div>
							<div id="sex">
								<span>  </span>
								<input type="radio" name="gender" <%="male".equals(user.getGender())?"checked":""%> value="male"/>
								<b>男</b>
								<input type="radio" name="gender" <%="female".equals(user.getGender())?"checked":"" %> value="female"/>
								<b>女</b>
							</div>
							<div id="oldpass">
								<span> </span>
								<input  type="password" value="<%=user.getPassWord()%>"/>
							</div>
							<div id="newpass" >
								<span> </span>
								<input  type="password" name="newpwd"/>
							</div>
							<div id="sub">
								<input type="submit" value="" />
							</div>
						</div>
						<div id="flower"> </div>
					</div>
					</form>
				</div>
			</section>
			<!--右边在线好友栏-->
			<aside id="right-side">
				<!--泡泡部分-->
				<div id="friendsOnline">
<!-- 					<div class="friendOn" id="friend1"> </div>
					<div class="friendOn" id="friend2"> </div>
					<div class="friendOn" id="friend3"> </div>
					<div class="friendOn" id="friend4"> </div>
					<div class="friendOn" id="friend5"> </div>
					<div class="friendOn" id="friend6"> </div>
					<div class="friendOn" id="friend7"> </div> -->
				</div>
				<div id="right-down">
					<img id="onlinefriend"src="imgs/onlinefriend.gif">
				</div>
			</aside>
		</div>
		<!-- 聊天对话框 -->
		<div id="chatbox">
			<div id="chatmain">
				<div id="bar">
					<div id="chat-person">尼古拉斯凯奇尼</div>
					<div id="chat-close" onclick="hideChatWindow()"></div>
				</div>
				<div id="chatborard"></div>
				<div id="chat-footer">
					<textarea id="inputcontent"></textarea>
					<span id="chatsend" onclick="onSend()"></span>
				</div>
			</div>
		</div>
		<!-- 相册创建对话框 -->
		<div id="album-create">
			<div id="ac-header">
				<div id="ac-header-title">
				</div>
			</div>
			<div id="ac-body">
				<input id="album-create-name" placeholder="相册名称"/>
				<input id="album-create-des" placeholder="相册描述" />
			</div>
			<div id="ac-footer">
				<div id="al-create" onclick="album.createAlbum()">
				</div>
				<div id="al-close" onclick="album.hideAlbumCreate()">
				</div>
			</div>
		</div>		
		<!-- 相册浏览对话框 -->
		<div id="album-browser">
			<div id="ab-header">
				<div id="ab-header-title">
				</div>
			</div>
			<div class="scroll_wrap">
				<div id="ab-body">
					<ul class="album-pictures" id="pictures-container">
	              	</ul>
				</div>
			</div>
			<div id="ab-footer">
				<div id="ab-close" onclick="album.hideAlbumBrowser()">
				</div>
			</div>
		</div>	
		<!-- 音乐上传弹出框 -->
		<div id="music-upload">
			<div id="mu-header">
				<div id="mu-header-title">
				</div>
			</div>
			<div id="mu-body">
				<input id="music-upload-singer" placeholder="歌手名称"/>
				<div class="music-upload-item-wrap">
					<span class="mu-item-hint" id="mu-item-hint-audio">选择歌曲</span>
					<input type="file" accept="audio/mpeg" id="music-upload-audio"/>
				</div>
				<div class="music-upload-item-wrap">
					<span class="mu-item-hint" id="mu-item-hint-poster">选择封面</span>
					<input type="file" accept="image/png,image/jpeg" id="music-upload-poster" />
				</div>
			</div>
			<div id="mu-footer">
				<div id="mu-create" onclick="onMusicUpload()"></div>
				<div id="mu-close" onclick="hideMusicUpload()"></div>
			</div>
		</div>	
				
		<!-- JiaThis Button BEGIN -->
		<div class="jiathis_style_24x24" id="jiathis">
			<a class="jiathis_button_qzone"></a>
			<a class="jiathis_button_tsina"></a>
			<a class="jiathis_button_tqq"></a>
			<a class="jiathis_button_weixin"></a>
			<a class="jiathis_button_renren"></a>
			<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jtico jtico_jiathis" target="_blank"></a>
		</div>
		<!-- JiaThis Button END -->	

		<!-- 音乐点赞数 -->
		<span id="like-count"></span>
			
	</body>
	
	<script type="text/javascript">
		jiathis_config = {
			title:"我做的网站哦，进来看看嘛^_^"
		}
	</script>
	
	<!-- 引入kalendae日历插件 -->
	<script type="text/javascript" src="plugin/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="plugin/kalendae/js/kalendae.js"></script>
	<!-- 第三方分享插件 -->
	<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
	<!-- Bootstrap -->
	<script type="text/javascript" src="plugin/bootstrap/bootstrap.min-4.0.0-alpha.6.js"></script>
	<!-- Viewer -->
	<script type="text/javascript" src="plugin/viewer/viewer-v-js.js"></script>
	<!-- JS引入 -->
	<script src="<%=request.getContextPath()%>/js/elements.js"></script>
	<script src="<%=request.getContextPath()%>/js/common.js"></script>
	<script src="<%=request.getContextPath()%>/js/bubble.js"></script>
	<script src="<%=request.getContextPath()%>/js/main.js"></script>
	<script src="<%=request.getContextPath()%>/js/box-drag.js"></script>
	<script src="<%=request.getContextPath()%>/js/slider.js"></script>
	<script src="<%=request.getContextPath()%>/js/moment.jsp"></script>
	<script src="<%=request.getContextPath()%>/js/classmate_schoolmate.jsp"></script>
	<script src="<%=request.getContextPath()%>/js/friend.jsp"></script>
	<script src="<%=request.getContextPath()%>/js/chat.jsp"></script>
	<script src="<%=request.getContextPath()%>/js/music.jsp"></script>
	<script src="<%=request.getContextPath()%>/js/album.jsp"></script>
	<!-- 客户端看起来引用的是js，实际上这只是url，映射的是Servlet -->
	<script src="<%=request.getContextPath()%>/setting.js"></script>
	
	<script type="text/javascript">
	

	
		setting.init();
		showClassmates();
		showSchoolmates();
		showFriends();
		showOnlineFriends();
		showMoments();
		Chat.initialize();
		makeChatBoxCanMove();//使聊天框可拖动
		player.init();    //音乐播放
		album.initAlbum(); //相册
		sliderConfig();   //图片轮播配置
	</script>
</html>
