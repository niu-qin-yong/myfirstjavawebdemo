window.onload = function(){
		recordPosition();
		move();
		binding();
		bindingNav();
        kalendae();
}

function kalendae(){
  var k = new Kalendae(document.getElementById('calendar'),{
    selected:Kalendae.moment()   //显示今天的时间
  });
  k.subscribe('change',function(){
    console.log(this.getSelected());
  });
}

/**
 * 使用ajax上传数据
 * @returns {Boolean}
 */
function ajax_submit_setting(){
	alert("ajax_submit");
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
