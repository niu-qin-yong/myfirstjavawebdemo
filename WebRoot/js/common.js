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




