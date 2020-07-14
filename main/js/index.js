$(function(){
    var table_on,
        table_off;
    var flag = 0;
	var filter = "win16|win32|win64|mac|macintel";
	var cook = document.cookie;
	//var cook = getCookie('mo');
	
// console.log(cook);
// console.log(cook.indexOf("mo=ok"))

		if(navigator.platform){
			if(0 > filter.indexOf(navigator.platform.toLowerCase())){
				if(cook.indexOf("mo=ok") == -1){
					document.cookie = 'mo=ok';
					location.href="mo_alert.html";
				}else{
					console.log("쿠키없음");
				}
			}else{
				console.log("pc")
			}
		}

    $("#header").hover(function(){
        $(".nav_show").show();
    },function(){
        $(".nav_show").hide();
    });

    $(".tab_box .tab_list").click(function(){
        var idx = $(this).index();
        console.log(idx);
        $(".tab_box .tab_list span").removeClass('on');
        $(".tab_box .tab_list span").eq(idx).addClass('on');
        $(".table_").removeClass('on');
        $(".table_").eq(idx).addClass('on');
        $(".color_table").removeClass('on');
        $(".color_table").eq(idx).addClass('on');
        $(".apply_box").removeClass('on');
        $(".apply_box").eq(idx).addClass('on');
        $(".apply_").removeClass('on');
        $(".apply_").eq(idx).addClass('on');
    });

    $(".table_hover_list1").mouseenter(function(){
        if($(this).hasClass('on')){
            flag = $(this).attr("class").replace("color_1","").replace("color_2","").replace("color_3","").replace("color_4","").replace("on","").replace("off","").replace("table_hover_list1","").replace(/ /g,"").replace("right_last","").replace("bor_both","").replace("bor_right","");
            console.log(flag)
            $(this).css({display:"none"});
            $(this).parent("tr").children("td.off."+flag).css({display:"table-cell"});
        }
    }).mouseleave(function(){
        if($(this).hasClass('off')){
            $(this).parent("tr").children("td.off").css({display:"none"});
            $(this).parent("tr").children("td.on").css({display:"table-cell"});
        }
    });

	$(".img_box.updating").click(function(){
		var idx = $(this).index();
		$(this).addClass('on');
		$(this).children("p").show();
	});

	$(".news_pop").click(function(){
        $(".pop_bg").toggle();
    });
    $(".news_pop_outer .close").click(function(){
        $(".pop_bg").toggle();
    });



	// $(".footer .sns a").click(function(){
	// 	alert("준비중입니다.");
	// });
})