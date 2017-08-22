function sliderConfig() {
	slider.photos = bannerPhotoes;
	
	//如果没有图片轮播，则不显示任何DOM
	if(slider.photos.length == 0){
		return;
	}
	
	slider.init();
}

var slider = {
	WIDTH : 660,
	DURATION : 1000,
	INTERVAL : 20,
	WAIT : 2000,
	photos : [],
	timer : null,
	canAuto : true,
	frame : document.querySelector("#slider"),
	imageUl : null,
	indexUl : null,
	curIndex : 1,
	init : function() {
		var self = this;
		self.frame.innerHTML = "<ul id='images'></ul><ul id='index'></ul>";
		self.imageUl = document.querySelector("#images");
		self.indexUl = document.querySelector("#index");
		self.updateView();
		//初始化下标数字
		var node = "";
		for (var i = 0; i < self.photos.length; i++) {
			node += "<li>" + self.photos[i].i + "</li>"
		}
		self.indexUl.innerHTML = node;
		self.updateIndex(self.curIndex);
		//实现一个简单的图片轮播，无过渡时间
		self.autoPlay();
		var indexs = document.querySelectorAll("#index li");
		for (var i = 0; i < indexs.length; i++) {
			indexs[i].onmouseover = function() {
				self.curindex = this.innerHTML;
				if (self.curindex != self.photos[0].i) {
					self.move(self.curindex - self.photos[0].i);
				}
			}
		}
		document.querySelector("#slider").onmouseover = function() {
			self.canAuto = false;
		}
		document.querySelector("#slider").onmouseout = function() {
			self.canAuto = true;
		}
	},
	updateView : function() {
		//将所有要轮播的图片和下标号码导入到页面中
		var self = this;
		self.frame.style.width = self.WIDTH + "px";
		self.imageUl.style.width = (self.WIDTH * self.photos.length) + "px";
		var li = "";
		for (var i = 0; i < self.photos.length; i++) {
			li += "<li style='width:" + self.WIDTH + "px;'><img src='" + self.photos[i].img + "'/></li>";
		}
		self.imageUl.innerHTML = li;
	},
	updateIndex : function(n) {
		//当前图片的下标显示为红色
		var indexs = document.querySelectorAll("#index li");
		for (var i = 0; i < indexs.length; i++) {
			indexs[i].className = "";
		}
		indexs[n - 1].className = "current";
	},
	move : function(n) {
		var self = this;
		clearTimeout(self.timer);
		self.timer = null;
		if (n < 0) {
			var ary = self.photos.splice(self.photos.length - (-n), -n);
			self.photos = ary.concat(self.photos);
			self.updateView();
			self.imageUl.style.left = self.WIDTH * n + "px";
		}
		self.moveStep(n);
	},
	moveStep : function(n) {
		var self = this;
		var step = self.WIDTH * n / (self.DURATION / self.INTERVAL);
		var style = getComputedStyle(self.imageUl);
		var left = parseFloat(style.left) - step;
		self.imageUl.style.left = left + "px";
		//图片移动
		if (n < 0 && left < 0 || n > 0 && left > self.WIDTH * (-n)) {
			self.timer = setTimeout(function() {
				self.moveStep(n);
			}, self.INTERVAL);
		} else {
			if (n > 0) {
				var ary = self.photos.splice(0, n);
				self.photos = self.photos.concat(ary);
				self.updateView();
				self.imageUl.style.left = "0px";
			}
			self.curindex = self.photos[0].i;
			self.updateIndex(self.curindex);
			self.autoPlay();
		}
	},
	autoPlay : function() {
		var self = this;
		self.timer = setTimeout(function() {
			if (self.canAuto) {
				self.move(1);
			} else {
				self.autoPlay();
			}
		}, self.WAIT);
	}
}

