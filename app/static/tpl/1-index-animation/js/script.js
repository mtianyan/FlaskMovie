$(function(){


//myCanvas---------------------------------------------------------------------------
	var clock_x = $(".main_banner_wrap").width()-150;
	var clock_y = $(".main_banner_wrap").height()-150;

	$("#myCanvas").css({"left":clock_x,"top":clock_y});

	var moveTimer = null;
	var disX = 0, disY = 0;
	var prevX = 0, prevY = 0;//上一记录点
	var iSpeedX = 0, iSpeedY = 0;//松手速度 = 松手点 - 上一记录点

	$("#myCanvas").mousedown(function(ev){
		$(this).css("opacity",0.9);
		var seft = $(this);
		disX = ev.pageX-$(this).offset().left+$(this).parent().offset().left;
		disY = ev.pageY-$(this).offset().top+$(this).parent().offset().top;

		prevX = ev.pageX;
		prevY = ev.pageY;

		//console.log(prevX+"||"+prevY)

		$(document).mousemove(function(ev){
			var x = ev.pageX - disX;
			var y = ev.pageY - disY;
			if(x<=0){
				x = 0;
			}else if(x > clock_x){
				x = clock_x;
			}
			if(y<=0){
				y = 0;
			}else if(y > clock_y){
				y = clock_y;
			}
			seft.css({"left":x,"top":y});

			iSpeedX = ev.pageX - prevX;//松手速度 = 松手点 - 上一记录点
			iSpeedY = ev.pageY - prevY;

			prevX = ev.pageX;//随着拖动 不断更新 上一记录点
			prevY = ev.pageY;

			console.log(iSpeedX+"||"+iSpeedY)

		});
		$(document).mouseup(function(){
			seft.css("opacity",0.8);
			$(document).off();
			move();
		});
		return false;
	});

	function move(){
		clearInterval(moveTimer);
		moveTimer = setInterval(function(){
			iSpeedY += 1;
			var iL = $("#myCanvas").position().left+iSpeedX;
			var iT = $("#myCanvas").position().top+iSpeedY;
			if(iL>clock_x){
				iL = clock_x;
				iSpeedX *= -1;
				iSpeedX *= 0.95;
			}else if(iL < 0){
				iL = 0;
				iSpeedX *= -1;
				iSpeedX *= 0.95;
			}
			if(iT>clock_y){
				iT = clock_y;
				iSpeedY *= -1;
				iSpeedY *= 0.95;
				iSpeedX *= 0.95;
			}else if(iT < 0){
				iT = 0;
				iSpeedY *= -1;
				iSpeedY *= 0.95;
			}
			if(Math.abs(iSpeedX)<1&&Math.abs(iSpeedY)<1&&Math.abs(iT-clock_y)<1){
				clearInterval(moveTimer);
			}
			$("#myCanvas").css({"left": iL,"top": iT});
		},30);
	};



	var iNow = 0;
	var arr = ["#ffae00","black"];

	myClock();
    setInterval(myClock,1000);//每一秒钟重绘一次

    function myClock(){

		var myCanvas = document.getElementById("myCanvas");
		var oC = myCanvas.getContext("2d");

		//得到时分秒
		var now = new Date(),
		sec = now.getSeconds(),
		min = now.getMinutes(),
		hour = now.getHours();
		hour = hour>=12 ? hour-12 : hour;

		iNow++;
		iNow = iNow%2;

		oC.save();
			//初始化画布
			oC.clearRect(0,0,myCanvas.width,myCanvas.height);
			oC.translate(75,75);
			oC.scale(0.5,0.5);
			oC.rotate(-Math.PI/2);

			//白色背景
			oC.save();
				oC.fillStyle = "#fff";
				oC.beginPath();
				oC.arc(0,0,140,0,Math.PI*2,true);
				oC.fill();
			oC.restore();

			oC.strokeStyle = "black";
			oC.fillStyle = "black";
			oC.lineWidth = 4;
			oC.lineCap = "round";

			//时针刻度
			oC.save();
				oC.beginPath();
				for(var i=0; i<12; i++){
					oC.moveTo(110,0);
					oC.lineTo(120,0);
					oC.rotate(Math.PI/6);
				}
				oC.stroke();
			oC.restore();

			//分针刻度
			oC.save();
				oC.fillStyle = "black";
				oC.lineWidth = 2;
				oC.beginPath();
				for(var i=0; i<60; i++){
					if(i%5 != 0){
						oC.moveTo(116,0);
						oC.lineTo(120,0);
					}
					oC.rotate(Math.PI/30);
				}
				oC.stroke();
			oC.restore();

			oC.save();
				oC.rotate(Math.PI/2);
				oC.font = "30px impact";
				//12点
				oC.fillText("12",-15,-80);
				//3点
				oC.fillText("3",88,13);
				//6点
				oC.fillText("6",-8,104);
				//9点
				oC.fillText("9",-103,11);
			oC.restore();

			//画时针
			oC.save();
				oC.strokeStyle = "#ff3300";
				oC.rotate((Math.PI/6)*hour+(Math.PI/360)*min+(Math.PI/21600)*sec);
				oC.lineWidth = 8;
				oC.beginPath();
				oC.moveTo(-20,0);
				oC.lineTo(60,0);
				oC.stroke();
			oC.restore();

			//画分针
			oC.save();
				oC.rotate((Math.PI/30)*min+(Math.PI/1800)*sec);
				oC.strokeStyle = "#27A9E3";
				oC.lineWidth = 6;
				oC.beginPath();
				oC.moveTo(-28,0);
				oC.lineTo(90,0);
				oC.stroke();
			oC.restore();

			//画秒针
			/*oC.save();
				oC.rotate(sec*Math.PI/30);
				oC.strokeStyle = "#D40000";
				oC.lineWidth = 3;
				oC.beginPath();
				oC.moveTo(-30,0);
				oC.lineTo(105,0);
				oC.stroke();
			oC.restore();*/

			//风车秒针
			oC.save();
				oC.rotate(sec*Math.PI/30);

				oC.save();
					oC.fillStyle = "#f23";
					oC.beginPath();
					oC.arc(94,0,10,0,Math.PI,true);
					oC.fill();
				oC.restore();

				oC.save();
					oC.rotate(Math.PI/2);
					oC.fillStyle = "#ffae00";
					oC.beginPath();
					oC.arc(10,-84,10,0,Math.PI,true);
					oC.fill();
				oC.restore();

				oC.save();
					oC.fillStyle = "#27A9E3";
					oC.beginPath();
					oC.arc(74,0,10,Math.PI,Math.PI*2,true);
					oC.fill();
				oC.restore();

				oC.save();
					oC.rotate(Math.PI/2);
					oC.fillStyle = "#0eaf52";
					oC.beginPath();
					oC.arc(-10,-84,10,Math.PI,Math.PI*2,true);
					oC.fill();
				oC.restore();
			oC.restore()
			//风车秒针


			//表框
			oC.save();
				oC.lineCap = "butt";
				oC.lineWidth = 16;
				oC.save();
					oC.strokeStyle = "#0eaf52";
					oC.beginPath();
					oC.arc(0,0,142,0,Math.PI*2,true);
					oC.stroke();
				oC.restore();

				oC.save();
					oC.strokeStyle = "#ffae00";
					oC.beginPath();
					oC.arc(0,0,142,0,Math.PI/iNow*5/3,true);
					oC.stroke();
				oC.restore();
			oC.restore();

			//中心点
			oC.save();
				oC.fillStyle = "#fff";
				oC.beginPath();
				oC.arc(0,0,4,0,Math.PI*2,true);
				oC.fill();
			oC.restore();


		oC.restore();



	};

//五、轮播图-------------------------------------------------------------------------------------

	var len=$(".main_banner li").length;
	var index_2=0;
	var timer=800;
	var intervaltimer=0;
	var isMoving=false;

	function slide(slideMode){//轮播方法
		if (isMoving==false){
			isMoving=true;
			var prev; var next; var hidden;
			var curr=$("#imgCard"+index_2);//当前正中显示

			if(index_2==0){								//当前正中显示的是第0张时 prev为最后一张
				prev=$("#imgCard"+(len-1));
			}else{												//否则  序列号-1
				prev=$("#imgCard"+(index_2-1));
			}
			if(index_2==(len-1)){					//当前正中显示的是最后一张时 next为第0张
				next=$("#imgCard0");
			}else{											//否则  序列号+1
				next=$("#imgCard"+(index_2+1));
			}

			if(slideMode){			//slideMode为1(true)，执行slide(1)，上一张
				if(index_2-2>=0){									//index_2						2		3		4
					hidden=$("#imgCard"+(index_2-2));//									0		1		2
				}else{													//index_2		0		1
					hidden=$("#imgCard"+(len+index_2-2));//			3		4
				}
				prev.css("z-index","5");			//点击prev按钮  让prev位置上的这张图片 层级最高 显示
				next.css("z-index","1");
				curr.css("z-index","2");
				hidden.css("z-index","1");
				//当index_2自减，各图片往右运动效果
				hidden.css({width:"450px",height:"180px",top:"60px","left":"0px","opacity":0});
				hidden.stop(true,true).animate({width:"580px",height:"240px",top:"20px",left:"0px",opacity:1},timer);
				curr.stop(true,true).animate({width:"580px",height:"240px",top:"20px",left:"600px",opacity:1},timer);
				next.stop(true,true).animate({width:"450px",height:"180px",top:"60px","left":"730px","opacity":0},timer,function(){next.find("span").css("opacity",0); isMoving = false;});
				//prev  -->  curr     prev中的图片li轮换到curr的位置      其他一次轮换
				prev.find("span").css("opacity",0);
				$(".main_banner_box li").find("p").css({"bottom":"-50px"});//所有标题隐藏
				prev.stop(true,true).animate({width:"670px",height:"280px",left:"255px",top:0,opacity:1},timer,function(){
					$(this).find("p").animate({"bottom":"0px"});	//当前这张图片的标题运动出来
				});
				index_2--;
			}else{			//执行next 操作
				if(index_2+2>=len){								//index_2								3		4
					hidden=$("#imgCard"+(index_2+2-len));//										0		1
				}else{													//index_2		0		1		2
					hidden=$("#imgCard"+(index_2+2));//						2		3		4
				}
				prev.css("z-index","1");
				next.css("z-index","5");			//点击next按钮  让next位置上的这张图片 层级最高 显示
				curr.css("z-index","2");
				hidden.css("z-index","1");
				//当index_2自增，各图片往左运动效果
				hidden.css({width:"450px",height:"180px",top:"60px","left":"730px","opacity":0});
				hidden.stop(true,true).animate({width:"580px",height:"240px",top:"20px",left:"600px",opacity:1},timer);
				curr.stop(true,true).animate({width:"580px",height:"240px",top:"20px",left:"0px",opacity:1},timer);
				//next  -->  curr     next中的图片li轮换到curr的位置      其他一次轮换
				next.find("span").css("opacity",0);
				$(".main_banner_box li").find("p").css({"bottom":"-50px"});//所有标题隐藏
				next.stop(true,true).animate({width:"670px",height:"280px",left:"255px",top:0,opacity:1},timer,function(){
					$(this).find("p").animate({"bottom":"0px"});	//当前这张图片的标题运动出来
				});
				prev.stop(true,true).animate({width:"450px",height:"180px",left:"0px",top:"60px",opacity:0},timer,function(){
					isMoving = false;
				});
				index_2++;
			}//if else

			hidden.find("span").css("opacity",0.5);
			curr.find("span").css("opacity",0.5);

			if(index_2==len) index_2=0;
			if(index_2<0) index_2=len+index_2;			//限制index_2的范围
			$(".btn_list span").removeClass('curr').eq(index_2).addClass('curr');//给序列号按钮添加、移除样式
		}
	}//slide()


	if(len>3){
		//序列号按钮 跳序切换 方法
		$(".btn_list span").click(function(event){

			if (isMoving ) return;
			var oIndex=$(this).index();

			if(oIndex==index_2) return;//点击按钮的序列号与当前图片的序列号一致，return
			clearInterval(intervaltimer)
			intervaltimer=null;

			var flag=false;
			//当前显示图片的序列号  和  被点击按钮的序列号  间隔超过1且不是首尾两个的时候
			if(Math.abs(index_2-oIndex)>1&&Math.abs(len-Math.abs(index_2-oIndex))!=1){
				//统一样式
				$(".main_banner_box li").css({width:"300px",height:"120px",left:"600px",top:"60px",opacity:0});
				//如果当前的序列号   比    被点击按钮序列号     大     而且     不相邻、不是首尾
				if(index_2>oIndex&&len-Math.abs(index_2-oIndex)!=1){
					flag=true;
					index_2=oIndex+1;		//oIndex+1    通过slide()  运动回上一张    oIndex
				}else{//比   小     而且     不相邻、不是首尾
					index_2=oIndex-1;		//oIndex-1     通过slide()  运动到下一张    oIndex
					if(index_2<0) index_2=len-1;
				}
			}else{//当前 比 被点击  大	且   相邻									//从0    跳到     4		要执行上一张方法
				if((index_2>oIndex&&len-(index_2-oIndex)!=1)||(index_2<oIndex&&len+(index_2-oIndex)==1)){
					flag=true;			//执行上一张
				}
			}
			slide(flag);
			intervaltimer=setInterval(slide,3000);//自动轮播

		});

		$(".main_banner_box li").on("mousemove",function(){
			if($(this).css("width")=="670px"){//鼠标移入为当前正中显示的图片li，则清除定时器
				clearInterval(intervaltimer);
				intervaltimer=null;
			}
		}).on("mouseout",function(){//鼠标移除重新滚动
				clearInterval(intervaltimer);
				intervaltimer=null;
				intervaltimer=setInterval(slide,3000);
		});

		$(".js_pre").click(function(event){//上一张
			if (isMoving ) return;
			clearInterval(intervaltimer);
			intervaltimer=null;
			slide(1);
			intervaltimer=setInterval(slide,3000);
		});

		$(".js_next").click(function(event){//下一张
			if (isMoving ) return;
			clearInterval(intervaltimer);
			intervaltimer=null;
			slide();
			intervaltimer=setInterval(slide,3000);
		});

		intervaltimer=setInterval(slide,3000);

	}else{

		$(".js_pre").hide();
		$(".js_next").hide();

	}//if else

});