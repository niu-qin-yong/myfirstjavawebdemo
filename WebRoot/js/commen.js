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







