function bindingNav(){
	for(var i=0;i<topnav.length;i++){
		topnav[i].onclick = show;
	}
	for(var i=0;i<leftnav.length;i++){
		leftnav[i].onclick = show;
	}
}
function show(){
	var navid = this.id;
	var index = navid.substr(-1,1);
	for(var i=0;i<showcontent.length;i++){
		showcontent[i].style.display = "none";
	}
	showcontent[index].style.display = "block";
}
/**
 * 监听按键事件
 */
window.onkeydown = function(event) {
	/* 如果按下 ESC 键，隐藏聊天对话框 */
	if (event.keyCode == 27) {
		/*把文本输入框中的toUserId属性值置为空，这是个标志，如果有值是1v1聊天，如果为空则是多人聊天*/
		$("#inputcontent").attr("data-toUserId","");
		$("#chatbox").css("display", "none");
	}
}

/* 定义格式化Date的方法Format */
Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

//重写JQuery的ajax方法，如果服务器返回的响应内容是登录页，说明以后已经掉线，让其重新登录
//重写的好处是不需要在每个ajax方法里判断是否需要跳转登录页，这里是入口函数，统一处理掉
jQuery(function($){
    // 备份jquery的ajax方法  
    var _ajax=$.ajax;
    // 重写ajax方法，先推断登录在运行success函数 
    $.ajax=function(opt){
    	var _success = opt && opt.success || function(a, b){};
        var _opt = $.extend(opt, {
        	success:function(data, textStatus){
        		// 假设后台将请求重定向到了登录页，则data里面存放的就是登录页的源代码，这里须要找到data是登录页的证据(标记)
        		if(data.indexOf('iamloginpage') != -1) {
        			window.location.href= "/mc/jsp/login.jsp";
        			return;
        		}
        		_success(data, textStatus);  
            }  
        });
        _ajax(_opt);
    };
});



