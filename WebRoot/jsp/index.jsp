<%@ page language="java" import="java.util.*"  pageEncoding="UTF-8"%>
<%@page import="com.it61.minecraft.bean.*"%>
<%@page import="com.it61.minecraft.service.*"%>
<%@page import="com.it61.minecraft.service.impl.*"%>
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
%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>我的主页完整布局</title>
		<link rel="stylesheet" href="css/index.css"/>
		<link rel="stylesheet" type="text/css" href="plugin/kalendae/css/kalendae.css">
		<link rel="stylesheet" href="css/classroom.css">
		<link rel="stylesheet" href="css/schoolfellow.css">
		<link rel="stylesheet" href="css/friend.css">
		<script src="/minecraft/plugin/jquery/jquery.min.js"></script>
	</head>
	<body>
		<!-- 用户登录部分 -->
		<%
		String username = user.getUserName();
		if(username != null){
		%>
		<div>欢迎&nbsp;<b><%=username %></b>&nbsp;<a href="/minecraft/servlet/LogoutServlet">注销</a></div>
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
				<div id="signIn"> </div>
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
							     <textarea name="moment-text" id="moment" cols="80" rows="3" placeholder="说点什么吧"></textarea>
							     <input type="file" name="moment-pic" id="moment-pic"/><br/>
                    			 <input type="submit" value="发表"/>
                    		</form>
						</div>
						<div class="remarks">
							<!-- 作者信息 -->
							<div class="remarks-author">
								<img src="imgs/head1.png"/>
								<div class="author-name">Chindy</div>
								<div class="author-class"> </div>
							</div>
							<!-- 说说内容 -->
							<div class="remarks-content">
								<div class="content-text">谁说我白，瘦，漂亮，我就跟他做好朋友。</div>
								<div class="content-time">今天8：15</div>
								<img src="imgs/show1.jpg"/>
								<div class="remarks-comments">
									<div class="comment-like">
										<span> </span>
										<img src="imgs/zan1.png">
										<img src="imgs/zan2.png">
									</div>
									<div class="comment-text">
										<span> </span>
										<textarea> </textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="photo" class="showcontent">
						相册
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
						音乐
					</div>
					<form id="settingform" onsubmit="return ajax_submit_setting()">
					<div id="setting" class="showcontent">
						<div class="userinfo">
							
							<div class="userphoto" id="userphoto">
								<a href="javascript:;">
									<input type="file" name="photo" accept="image/png,image/jpeg" onchange="preView(this)"/>
								</a>
							</div>
							
							<div class="username">
								<%=user.getUserName() %>
							</div>
							<div class="userlevel"> </div>
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
								<input type="text" name="star" value="<%=user.getStar()%>"/>
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
	</body>
	<!-- 引入kalendae日历插件 -->
	<script type="text/javascript" src="plugin/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="plugin/kalendae/js/kalendae.js"></script>
	<!-- JS引入 -->
	<script src="js/elements.js"></script>
	<script src="js/commen.js"></script>
	<script src="js/bubble.js"></script>
	<script src="<%=request.getContextPath()%>/js/main.js"></script>
	
	<script type="text/javascript">
		/**
		 * 使用ajax上传数据
		 * @returns {Boolean}
		 */
		function ajax_submit_setting(){
			var myForm = document.getElementById('settingform');
			var formData = new FormData(myForm);
			
			var xmlhttp = new XMLHttpRequest();
			  xmlhttp.onreadystatechange = function(){
			  	if(xmlhttp.readyState==4 && xmlhttp.status == 200){
			  		alert(xmlhttp.responseText);
			  	}
			  };
			  xmlhttp.open("post","/minecraft/servlet/SettingServlet",true);
			  xmlhttp.send(formData);
			
			//返回false阻止表单提交
			return false;
		}
		
		/**
		*检测性别单选框是否有被选中的，如果没有则默认选中第一个
		**/
        function checkRadio(){
            var genderradio = document.getElementsByName('gender');
            var len = genderradio.length;
            for(var i=0;i<len;i++){
                  //如果有选中的,程序退出不再判断
                 if(genderradio[i].checked){
                      return;
                 }
            }
            //如果没有选中的将第一个默认选中
            genderradio[0].checked = "checked";
        }
       
       /**
       *设置select的选中项
       **/ 
       function setSelectedOption(select,index){
			var options = document.getElementById(select).options;
			options[index].selected = true;		
		}
		
		/**
		*设置用户头像
		**/
		function setUserPhoto(){
			var div = document.getElementById("userphoto");
			div.style.backgroundImage="url(/minecraft/servlet/ShowPicServlet?id="+<%=user.getId()%>+")";
		}
		
		/**
		*上传用户头像后在本地预览
		**/
	 	function preView(file){
			alert(file.files+","+file.files[0]+","+file.files[0].type)
			if (file.files && file.files[0]) {
				//如果上传文件不是图片类型，则不预览，实际上这里可以提示用户上传文件类型错误
              	var imageType = /^image\//;
				if (!imageType.test(file.files[0].type)) {
					  file.files[0] = null;
				      return;
				}
			
				var div = document.getElementById("userphoto");
				
				var reader = new FileReader();
		       	reader.onload = function (evt) {
	          		div.style.backgroundImage = "url("+evt.target.result+")";
	      		}
	      		reader.readAsDataURL(file.files[0]);
			}
		}
		
		/**
		*添加好友，friendId是好友id
		**/
		function addFriend(a){
			var friId = a.getAttribute("data-friId");
			var friName = a.getAttribute("data-friName");
			
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function(){
               if(xmlhttp.readyState==4 && xmlhttp.status == 200){
            	   if(xmlhttp.responseText == "add_friend_ok"){
	            	    a.style.backgroundImage="url(/minecraft/imgs/friends-each-other.png)";
						a.setAttribute("title","移除好友");
						a.setAttribute("data-friId",a.getAttribute("data-friId"));
						a.setAttribute("onclick",'removeFriend(this)');  
						
						//更新好友界面
						addEleFromFriends(a.getAttribute("data-friId"),a.getAttribute("data-friName"));
            	   }
               }
            }
            xmlhttp.open("post","/minecraft/servlet/AddFriendServlet",true);
            xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlhttp.send("friendId="+friId+"&friendName="+friName);
		}
		
		/**
		*判断是否相互是好友
		**/
		function isFriend(friendId){
			<%	for(Friend fri:allFriends){ %>
			
				if(friendId == <%=fri.getFriId()%>){
					return true;
				}
					
			<%}%>
			return false;
		}
		
		/**
		*移除好友关系
		**/
		function removeFriend(a){
			var owerId = "<%=user.getId()%>";
			var friId = a.getAttribute("data-friId");
			
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function(){
               if(xmlhttp.readyState==4 && xmlhttp.status == 200){
            	   if(xmlhttp.responseText == "remove_friend_ok"){
	            	    a.style.backgroundImage="url(/minecraft/imgs/jiafriend.png)";
						a.setAttribute("title","添加好友");
						a.setAttribute("onclick",'addFriend(this)'); 
						
						//更新好友界面
						removeEleFromFriends(a.getAttribute("data-friId"));
            	   }
               }
            }
            xmlhttp.open("post","/minecraft/servlet/RemoveFriendServlet",true);
            xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlhttp.send("owerId="+owerId+"&friId="+friId);			
		}
		
		/**
		*显示班级同学
		**/
		function showClassmates(){
			<%
			UserServiceImpl service = new UserServiceImpl();
			List<User> classmates = service.getClassmates(user);
			
			System.out.println("showClassmates size:"+classmates.size());
			
			for(int i=0;i<classmates.size();i++){
				User mate = classmates.get(i);
				
			%>
				/* 创建代表一个好友的div */
				var classmatee=document.createElement("div");
				classmatee.setAttribute("class","classmatee");
				
				var rank = <%=i%>;
				var jiangpai=document.createElement("div");
				jiangpai.setAttribute("class","jiangpai");
				if(rank==0){
					//gold
					jiangpai.style.backgroundImage="url(/minecraft/imgs/golden.png)";
				}else if(rank==1){
					//silver
					jiangpai.style.backgroundImage="url(/minecraft/imgs/sliver.png)";
				}else if(rank==2){
					//copper
					jiangpai.style.backgroundImage="url(/minecraft/imgs/tong.png)";
				}
				
				var classmatephoto=document.createElement("div");
				classmatephoto.setAttribute("class","classmatephoto");
				classmatephoto.style.backgroundImage="url(/minecraft/servlet/ShowPicServlet?id="+<%=mate.getId()%>+")";	
				
				var classmatename=document.createElement("div");
				classmatename.setAttribute("class","classmatename");
				classmatename.innerHTML = "<%=mate.getUserName()%>";
				
				var classmatecaozuo=document.createElement("div");
				classmatecaozuo.setAttribute("class","classmatecaozuo");
				
				//在自己的条目后面不显示添加好友的按钮
				if(<%=user.getId()%> != <%=mate.getId()%>){
					var addfriend=document.createElement("a");
					addfriend.setAttribute("href","javascript:;");

					if(isFriend(<%=mate.getId()%>)){
						//如果是好友，取消好友
						addfriend.setAttribute("title","取消好友");
						addfriend.setAttribute("data-friId",<%=mate.getId()%>);
						addfriend.style.backgroundImage="url(/minecraft/imgs/friends-each-other.png)";
						addfriend.setAttribute("onclick","removeFriend(this)");
					}else{
						//如果不是好友，添加好友
						addfriend.setAttribute("title","添加好友");
						addfriend.setAttribute("data-friId",<%=mate.getId()%>);
						addfriend.setAttribute("data-friName","<%=mate.getUserName()%>");
						addfriend.setAttribute("onclick","addFriend(this)");
					}
					classmatecaozuo.appendChild(addfriend);
				}
				
				classmatee.appendChild(jiangpai);
				classmatee.appendChild(classmatephoto);
				classmatee.appendChild(classmatename);
				classmatee.appendChild(classmatecaozuo);
				
				/* 将好友div添加到父元素中 */
				var parent = document.getElementById("classmate");
				parent.appendChild(classmatee);
			<%	
				}
			%>
		}
		
		/**
		*显示校友录
		**/		
		function showSchoolmates(){
			<%
			List<User> schoolmates = service.getAllUsers();
			
			System.out.println("showSchoolmates size:"+schoolmates.size());
			
			for(int i=0;i<schoolmates.size();i++){
				User smate = schoolmates.get(i);
			%>		
			var schoolfee=document.createElement("div");
			schoolfee.setAttribute("class","schoolfee");
			
			var schoolephoto=document.createElement("div");
			schoolephoto.setAttribute("class","schoolephoto");
			schoolephoto.style.backgroundImage="url(/minecraft/servlet/ShowPicServlet?id="+<%=smate.getId()%>+")";	
			schoolfee.appendChild(schoolephoto);
			
			var schoolename=document.createElement("div");
			schoolename.setAttribute("class","schoolename");
			schoolename.innerHTML = "<%=smate.getUserName()%>";
			schoolfee.appendChild(schoolename);
			
			var schoolenclass=document.createElement("div");
			schoolenclass.setAttribute("class","schoolenclass");
			schoolenclass.innerHTML = "<%=smate.getGrade()%>"+"年"+"<%=smate.getBanji()%>"+"班";
			schoolfee.appendChild(schoolenclass);
			
			var parent = document.getElementById("schoolfees");
			parent.appendChild(schoolfee);
			
			<%
			}
			%>
		}
		
		/**
		*显示校友录
		**/		
		function showFriends(){
			<%
			List<Friend> friends = allFriends;
			
			for(int i=0;i<friends.size();i++){
				Friend fri = friends.get(i);
			%>
			
			var friendee=document.createElement("div");
			friendee.setAttribute("class","friendee");
			friendee.setAttribute("id","fri"+"<%=fri.getFriId()%>");
			
			var gfriendphoto=document.createElement("div");
			gfriendphoto.setAttribute("class","gfriendphoto");
			gfriendphoto.style.backgroundImage="url(/minecraft/servlet/ShowPicServlet?id="+<%=fri.getFriId()%>+")";	
			friendee.appendChild(gfriendphoto);
			
			var gfriendname=document.createElement("div");
			gfriendname.setAttribute("class","gfriendname");
			gfriendname.innerHTML = "<%=fri.getFriName()%>";
			friendee.appendChild(gfriendname);
			
			var gfriendchat=document.createElement("div");
			gfriendchat.setAttribute("class","gfriendchat");
			gfriendchat.innerHTML = "聊天";
			gfriendchat.setAttribute("onclick","javascript:chat('<%=user.getId()%>','<%=fri.getFriId()%>')");
			friendee.appendChild(gfriendchat);
			
			var parent = document.getElementById("friendcontent");
			parent.appendChild(friendee);

			<%
			}
			%>			
		}
		
		/**
		*从好友界面移除好友
		**/
		function removeEleFromFriends(friId){
			var parent = document.getElementById("friendcontent");
			var child = document.getElementById("fri"+friId);
			parent.removeChild(child);
		}
		
		/**
		*添加好友到好友界面
		**/
		function addEleFromFriends(friId,friName){
			var friendee=document.createElement("div");
			friendee.setAttribute("class","friendee");
			friendee.setAttribute("id","fri"+friId);
			
			var gfriendphoto=document.createElement("div");
			gfriendphoto.setAttribute("class","gfriendphoto");
			gfriendphoto.style.backgroundImage="url(/minecraft/servlet/ShowPicServlet?id="+friId+")";	
			friendee.appendChild(gfriendphoto);
			
			var gfriendname=document.createElement("div");
			gfriendname.setAttribute("class","gfriendname");
			gfriendname.innerHTML = friName;
			friendee.appendChild(gfriendname);
			
			var gfriendchat=document.createElement("div");
			gfriendchat.setAttribute("class","gfriendchat");
			gfriendchat.setAttribute("onclick","javascript:chat(\"<%=user.getId()%>\","+friId+")");
			<%-- gfriendchat.setAttribute("onclick","javascript:chat('<%=user.getId()%>',"+friId+")"); --%>
			gfriendchat.innerHTML = "聊天";
			friendee.appendChild(gfriendchat);
			
			var parent = document.getElementById("friendcontent");
			parent.appendChild(friendee);
		}
		
		/**
		*聊天
		**/
		function chat(person_sender,person_receiver){
			alert(person_sender+" will talk to "+person_receiver);
		}
		
		/**
		*多人聊天
		**/
		function multichat(){
			alert("Let's chat!!!");
		}
		
		function showOnlineFriends(){
			<%
				for(int i=0;i<onlineFriends.size();i++){
			%>
			var friendOn=document.createElement("div");
			friendOn.setAttribute("class","friendOn");
			friendOn.setAttribute("title","<%=onlineFriends.get(i).getFriName()%>");
			friendOn.style.backgroundImage="url(/minecraft/servlet/ShowPicServlet?id=<%=onlineFriends.get(i).getFriId()%>),url(/minecraft/imgs/pop.jpg)";	
			friendOn.style.left=getRandomLeft(<%=i%>);
			friendOn.style.top=(<%=i%>*80)+"px";
			
			var parent = document.getElementById("friendsOnline");
			parent.appendChild(friendOn);
			<%
				}
			%>
		}
		
		/**
		*在线好友泡泡的随机left值
		**/
		function getRandomLeft(index){
			var rand = Math.random();
			var left;
			if(index%2 != 0){
				//1,3,5
				left = (Math.pow(rand,3)*20)+"px";
			}else{
				//2,4,6
				left = (Math.pow(rand,3)*80)+"px";
			}
			return left;
		}
		
		/**
		*发表朋友圈动态
		**/		
		function sendMoment(){
		     var moment = $('#moment').val();
		     var file = $('#moment-pic')[0].files[0];
		     
		     var formData = new FormData();
		     formData.append("moment",moment);
		     formData.append("pic",file);
		     
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
		              alert(data+"\n"+status);
		          },
		          error:function(data,status){
		              alert(data+"========"+status);
		          }
		     })
			return false;
		}
        
		checkRadio();
		setSelectedOption("grade", <%=user.getGrade()-1%>);
		setSelectedOption("banji", <%=user.getBanji()-1%>);
		setUserPhoto();
		showClassmates();
		showSchoolmates();
		showFriends();
		showOnlineFriends();
		
	</script>
	
</html>
