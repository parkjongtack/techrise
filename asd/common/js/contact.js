<!--

function inEmail(){
    var f=document.contactForm;
		var beginObj=f.email_03;
		var targetObj=f.email_02;
		if(beginObj.selectedIndex==0){
		    targetObj.value="";
				targetObj.disabled=
				targetObj.focus();
		}else{
		    targetObj.value=beginObj[beginObj.selectedIndex].value;
				targetObj.disabled=true;
		}
}

function goSend(){
    var f=document.contactForm;
		
		if (!f.cate.value.Trim()) {
        alert("문의 유형을 선택해 주세요."); f.cate.focus(); return;
    }
		if (!f.quesCate.value.Trim()) {
        alert("질문 분야를 선택해 주세요."); f.quesCate.focus(); return;
    }
		if (!f.s_name.value.Trim()) {
        alert("이름을 입력해 주세요."); f.s_name.focus(); return;
    }
		
		var email_01=f.email_01.value;
		var email_02=f.email_02.value;
		var email_03=f.email_03.value;
		
		if (!f.email_01.value.Trim()) {
        alert("이메일을 입력해 주세요."); f.email_01.focus(); return;
    }
		
		if (!f.email_02.value.Trim()) {
        alert("이메일을 입력해 주세요."); f.email_02.focus(); return;
    }
		var fullEmail=email_01+"@"+email_02;
		
		if (!isMailChars(fullEmail)) {
        alert('이메일 형식을 확인해 주세요.'); f.email_01.focus();return;
    }
		
		f.s_email.value = fullEmail;
		
		if (!f.s_title.value.Trim()) {
        alert("제목을 입력해 주세요."); f.s_title.focus(); return;
    }
		
		if (!f.s_content.value.Trim()) {
        alert("내용을 입력해 주세요."); f.s_content.focus(); return;
    }
		
		/* f.action="contact_proc.asp";
		f.method="post"
		f.target="_blank"
		f.submit();
		return;   */
		
		var formData =  $("#contactForm").serialize();
		if(document.getElementById("id_but")){document.getElementById("id_but").style.display="none"};
		
		
		$.ajax({
            cache : false,
            url : "contact_proc.asp", // ��⿡
            type : 'POST', 
            data : formData, 
            success : function(responseData) {
    						//alert(responseData)
								if(responseData=="OK"){
								    alert("문의 접수가 완료되었습니다.");
										f.reset();
										if(document.getElementById("id_but")){document.getElementById("id_but").style.display="block"};
								}else if(responseData=="Fail"){
								    alert("메일발송에 실패하였습니다.\n관리자에 문의해 주세요.");
										if(document.getElementById("id_but")){document.getElementById("id_but").style.display="block"};		
								}else if(responseData=="NO_VALUE"){
								    alert("필수값이 빠져있습니다.\n관리자에 문의해 주세요.");
										if(document.getElementById("id_but")){document.getElementById("id_but").style.display="block"};
								}else if(responseData=="DBERROR"){
								    alert("DB Insert Error\n\nPlease try again.");
										location.reload();
								}else{
								    alert("ERROR.");
										location.reload();
								}
								
            }, // success 
    
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
      });
				
		
}


function goLetter(){
    var f=document.contactForm;
		
		if (!f.cate.value.Trim()) {
        alert("유형을 선택해 주세요."); f.cate.focus(); return;
    }
		
		var email_01=f.email_01.value;
		var email_02=f.email_02.value;
		var email_03=f.email_03.value;
		
		if (!f.email_01.value.Trim()) {
        alert("이메일을 입력해 주세요."); f.email_01.focus(); return;
    }
		
		if (!f.email_02.value.Trim()) {
        alert("이메일을 입력해 주세요."); f.email_02.focus(); return;
    }
		var fullEmail=email_01+"@"+email_02;
		
		if (!isMailChars(fullEmail)) {
        alert('이메일 형식을 확인해 주세요.'); f.email_01.focus();return;
    }
		
		f.s_email.value = fullEmail;
		
		var formData =  $("#contactForm").serialize();
		if(document.getElementById("id_but")){document.getElementById("id_but").style.display="none"};
		
		
		$.ajax({
            cache : false,
            url : "letter_proc.asp", // ��⿡
            type : 'POST', 
            data : formData, 
            success : function(responseData) {
    						//alert(responseData)
								if(responseData=="OK"){
								    alert("정상적으로 구독 신청이 접수되었습니다.");
										f.reset();
										$(".pop_bg").toggle();
										//if(document.getElementById("id_but")){document.getElementById("id_but").style.display="block"};
								}else if(responseData=="NO_VALUE"){
								    alert("필수값이 빠져있습니다.\n관리자에 문의해 주세요.");
										if(document.getElementById("id_but")){document.getElementById("id_but").style.display="block"};
								}else if(responseData=="DBERROR"){
								    alert("DB Insert Error\n\nPlease try again.");
										location.reload();
								}else{
								    alert("ERROR.");
										location.reload();
								}
								
            }, // success 
    
            error : function(xhr, status) {
                alert(xhr + " : " + status);
            }
      });
				
		
}
//-->