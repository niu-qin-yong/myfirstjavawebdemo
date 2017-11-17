var inputs = document.querySelectorAll("form input");
var warnings = document.getElementsByClassName("warning");
window.onload = function() {
	for (var i = 0; i < inputs.length - 1; i++) {
		bindingOnblur(i);
	}
}
function bindingOnblur(i) {
	inputs[i].onblur = function() {
		validate(i);
	}
}
// 遍历每一个输入框进行判断
function validate(i) {
	//邀请码可以不填
	if(i == 5){
		return true;
	}
	
	warnings[i].innerHTML = "";
	var reg = /^(\s)*$/;
	var empty = inputs[i].value;
	if (reg.test(empty)) {
		warnings[i].innerHTML = "请输入" + inputs[i].dataset.point;
		return false;
	}

	// 用户名
	if (i == 0) {
		var userName = inputs[i].value;
		var reg = /[a-zA-Z0-9_]{3,10}/;
		if (!reg.test(userName)) {
			warnings[i].innerHTML = "用户名为3~10个字符";
			return false;
		}
	}
	// 密码
	if (i == 1) {
		var reg1 = /[A-Z]+/;
		var reg2 = /[a-z]+/;
		var reg3 = /[0-9]+/;
		var password = inputs[i].value;
		if (!(reg1.test(password) && reg2.test(password) && reg3.test(password))
				|| password.length < 6) {
			warnings[i].innerHTML = "密码最少6位并包含大写，小写字母及数字";
			return false;
		}
	}
	// 重复密码
	if (i == 2) {
		var password = inputs[i - 1].value;
		var repass = inputs[i].value;
		if (password != repass) {
			warnings[i].innerHTML = "两次密码不一致";
			return false;
		}
	}
	// 手机号
	if (i == 3) {
		var reg = /^1[3|4|5|8][0-9]\d{8}$/;
		var phone = inputs[i].value;
		if (!(reg.test(phone))) {
			warnings[i].innerHTML = "请输入正确手机号码";
			return false;
		}
	}

	// 验证码
	if (i == 4) {
		var value = inputs[i].value;
		
		if(value == "" | value == "null" | value == null ){
			warnings[i].innerHTML = "验证码输入错误";
			showValidateCode();
			return false;
		}
		
		//检查验证码是否正确，将用户输入的验证码提交给服务器，服务器返回判断结果
		$.ajax({
			url:basePath+"servlet/CheckValidateCodeServlet",
			async: false,
			type:'post',
			data:{'code':value},
			success:function(data,status){
	              if (data == 'false') {
					warnings[i].innerHTML = "验证码输入错误";
					showValidateCode();
					return false;
	              }
	        },
	        error:function(data,status){
	        	alert("GetValidateCode "+status+"\n"+data);
	        }
		});
		
	}
	
	// 协议勾选
	if (i == 6) {
		if (!inputs[i].checked) {
			warnings[i].innerHTML = "请阅读童程注册协议"
			return false;
		}
	}
	
	return true;
}

function check() {
	var result = 0;
	for (var i = 0; i < inputs.length - 1; i++) {
		// 检查所有的内容是否都通过
		if (validate(i)) {
			result++;
		}
	}
	if (result == 7) {
		return true;
	} else {
		return false;
	}
}

//显示动态验证码,首次显示注册页面，用户点击验证码,注册失败这些情况下都更新验证码
function showValidateCode() {
	var div = document.querySelector("#vertify");
	div.style.backgroundImage = "url("+basePath+"servlet/ValidateCodeServlet?randomId="
			+ Math.random() + ")";
}

showValidateCode();