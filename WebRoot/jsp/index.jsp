<%@page import="com.it61.minecraft.service.impl.UserServiceImpl"%>
<%@ page language="java" import="java.util.*" import="com.it61.minecraft.bean.User" pageEncoding="UTF-8"%>
<%
User user = (User)session.getAttribute("user");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>我的主页完整布局</title>
		<link rel="stylesheet" href="css/index.css"/>
		<link rel="stylesheet" type="text/css" href="plugin/kalendae/css/kalendae.css">
		<link rel="stylesheet" href="css/classroom.css">
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
						<!-- ******************* -->
						<!-- 20课 -->
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
					<div id="friends" class="showcontent">
						好友
					</div>
					<div id="classname" class="showcontent">
		                <div class="classmask"></div>
		                <div class="classbgdecoration"></div>
		                <div class="classmate">
		                
		                </div>				
					</div>
					<div id="schoolfellow" class="showcontent">
						校友录
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
								<input type="radio" name="gender" <%=user.getGender().equals("male")?"checked":"" %> value="male"/>
								<b>男</b>
								<input type="radio" name="gender" <%=user.getGender().equals("female")?"checked":"" %> value="female"/>
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
					<div class="friendOn" id="friend1"> </div>
					<div class="friendOn" id="friend2"> </div>
					<div class="friendOn" id="friend3"> </div>
					<div class="friendOn" id="friend4"> </div>
					<div class="friendOn" id="friend5"> </div>
					<div class="friendOn" id="friend6"> </div>
					<div class="friendOn" id="friend7"> </div>
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
			if (file.files && file.files[0]) {
				//如果上传文件不是图片类型，则不预览，实际上这里可以提示用户上传文件类型错误
              	var imageType = /^image\//;
				if (!imageType.test(file[0].type)) {
					  file[0] = null;
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
		*显示班级同学
		**/
		function showClassmates(){
			<%
			UserServiceImpl service = new UserServiceImpl();
			List<User> classmates = service.getClassmates(user);
			for(User mate : classmates){
			%>
				var classmatee=document.createElement("div");
				classmatee.setAttribute("class","classmatee");
				
				
				
				var parent = document.getElementById("classname");
				parent.appendChild(classmatee)
			<%	
				}
			%>
		}
        
		checkRadio();
		setSelectedOption("grade", <%=user.getGrade()-1%>);
		setSelectedOption("banji", <%=user.getBanji()-1%>);
		setUserPhoto();
		showClassmates();
		
	</script>
	
</html>
