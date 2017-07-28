//页面主方法
var bubbles = document.getElementsByClassName("friendOn");
var currentBubbleStyle;

//关于所有事件绑定动作
function binding(){
    //给每个泡泡绑定事件
    for (var i=0;i<bubbles.length;i++){
        bubbles[i].onmouseover=pause;
        bubbles[i].onmouseout=move;
        bubbles[i].onclick=firstShow;
    }
}
//鼠标移入泡泡停止运动
function pause(){
    clearInterval(timer);
}

//被点击的泡泡最上面显示
function firstShow(currentBubble){
    currentBubble=this;
    for(var i=0;i<bubbles.length;i++){
        if(window.getComputedStyle(bubbles[i]).zIndex==999){
            bubbles[i].style.zIndex=998;
        }
    }
    currentBubble.style.zIndex=999;
    
    //弹出聊天窗口
    var toUserId = currentBubble.getAttribute("data-toUserId");
    var toUserName = currentBubble.getAttribute("data-toUserName");
    chat(toUserId,toUserName);
}
//储存每个泡泡一开始的位置，并规定初始运动方向
function recordPosition(){
    for(var i=0;i<bubbles.length;i++){
        if(i%2==0){
            bubbles[i].h=1;
            bubbles[i].v=1;
        }else{
            bubbles[i].h=-1;
            bubbles[i].v=-1;
        }
        currentBubbleStyle = window.getComputedStyle(bubbles[i]);
        //储存每个泡泡一开始的位置
        bubbles[i].initTop=parseFloat(currentBubbleStyle.top);
        bubbles[i].initLeft=parseFloat(currentBubbleStyle.left);
    }
}
//泡泡开始运动
function move(){
    timer=setInterval(function(){
        for(var i=0;i<bubbles.length;i++){
            currentBubbleStyle = window.getComputedStyle(bubbles[i]);
            //控制上下弹
            if(parseFloat(currentBubbleStyle.top)<bubbles[i].initTop-10){
                bubbles[i].v=-1;
            }else if(parseFloat(currentBubbleStyle.top)>bubbles[i].initTop+30){
                bubbles[i].v=1;
            }
            //控制左右弹
            if(parseFloat(currentBubbleStyle.left)<bubbles[i].initLeft-30){
                bubbles[i].h=1;
            }else if(parseFloat(currentBubbleStyle.left)>bubbles[i].initLeft+30){
                bubbles[i].h=-1;
            }         
            bubbles[i].style.top=(parseFloat(currentBubbleStyle.top)-0.1*bubbles[i].v)+"px";
            bubbles[i].style.left=(parseFloat(currentBubbleStyle.left)+0.1*bubbles[i].h)+"px";
        }
    },10);
}