
function seChk(str){
    if(str=="N"){
        self.location.reload();
    }
}

function regChk(str){
    if(str=="N"){
        self.location.replace('/reg/reg.html');
    }
}

function enter(e){  
      if (e.which == 13){goSearch()}  
} 


$(document).ready(function() {
    $('.simple-ajax-popup-align-top').magnificPopup({
          type: 'ajax',
          alignTop: true,
          overflowY: 'auto' // as we know that popup content is tall we set scroll overflow by default to avoid jump
    });

    $('.simple-ajax-popup').magnificPopup({
          type: 'ajax'
    });
        
});
	
	
	
function buttonMake(){
			    
					$(document).ready(function() {
    
            $('.simple-ajax-popup-align-top').magnificPopup({
              type: 'ajax',
              alignTop: true,
							overflowY: 'auto' // as we know that popup content is tall we set scroll overflow by default to avoid jump
              //overflowY: 'scroll' // as we know that popup content is tall we set scroll overflow by default to avoid jump
            });
    
            $('.simple-ajax-popup').magnificPopup({
              type: 'ajax'
            });
            
          });
			
}
		
function popCose(){
//		    magnificPopup.close;
		$('.simple-ajax-popup-align-top').magnificPopup.close
}	
			
	
var changeCount;
changeCount = 0;

var modalCount;
modalCount = 0;
function preloadhan(){
//alert("gfff");
    if(changeCount>0){
		    //alert("파일 등 주요 정보 변경 시\n\n상세 페이지를 다시 호출한 후 변경 내용을 확인해 주세요.")
		    location.reload()
		}else if(modalCount>0){
		    alert("a")
		    delete naver_id_login;
		    alert("b")				
		}
}