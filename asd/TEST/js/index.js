$(function(){
    $("#header").hover(function(){
        $(".nav_show").show();
    },function(){
        $(".nav_show").hide();
    });

    $(".tab_box .tab_list").click(function(){
        var idx = $(this).index();
        
        $(".tab_box .tab_list span").removeClass('on');
        $(".tab_box .tab_list span").eq(idx).addClass('on');
        $(".table_box .table_list").removeClass('on');
        $(".table_box .table_list").eq(idx).addClass('on');
    })
})