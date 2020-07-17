<!--



function goBD(){
    var f=document.bbsForm;
		var boardCate=f.boardCate.value;
		
		if(!f.title.value.Trim()){
		     alert("제목을 입력해 주세요");f.title.focus();return;
		}
		
		
		if(boardCate=="VIDEO"||boardCate=="MEDIA"){
		    if(!f.link_txt.value.Trim()){
				    if(boardCate=="VIDEO"){
		         alert("연결할 URL을 입력해 주세요");
						}else{
		         alert("연결할 유투브 URL을 입력해 주세요");
						} 
						f.link_txt.focus();return;
		    }
		}
		
		
		
		var deposit_01 = f.sY.value;
    var deposit_02 = f.sM.value;
    var deposit_03 = f.sD.value; 
		
		if (!deposit_01.Trim()) {
          alert("작성 날짜를 확인해 주세요."); f.sY.focus();return;
    }

 		if (deposit_01.length<4) {
         alert("작성 날짜를 확인해 주세요."); f.sY.focus();return;
    }
      		
 		if (!deposit_02.Trim()) {
         alert("작성 날짜를 확인해 주세요."); f.sM.focus();	return;
    }

 		if (parseInt(deposit_02,10)==0||parseInt(deposit_02,10)>12) {
         alert("작성 날짜를 확인해 주세요."); f.sM.focus();return;
    }
      		
 		if (!deposit_03.Trim()) {
         alert("작성 날짜를 확인해 주세요."); f.sD.focus();return;
    }
      		
    var bDateCheck = true;
         
    var nYear = Number(deposit_01);
    var nMonth = Number(deposit_02);
    var nDay = Number(deposit_03);
      		
      		
    var nMaxDay = new Date(new Date(nYear, nMonth, 1) - 86400000).getDate();
    if (nDay < 1 || nDay > nMaxDay){ 
	 			 // ��밡�� ���� ���� ���� üũ
         bDateCheck = false;
    }
    if(bDateCheck == false){ 
         alert("작성 날짜를 확인해 주세요."); f.sD.focus();return;
    } 
		
				
		
		if(!f.b_langCheck.value){
		    alert("보여질 언어를 선택해 주세요.");f.b_langCheck.focus();return;
		}
		
		if(boardCate=="NEWS"||boardCate=="LETTER"||boardCate=="MEDIA"){
    		CKEDITOR.instances.content.updateElement();
    		if(!f.content.value.Trim()){
             alert("내용을 입력해 주세요.");
        		 //f.content.focus();
    				 return;
        }
		}
		
		var formData =  $("#bbsForm").serialize();
		document.getElementById("bbsBtn").style.display="none";
		
		var procUrl;
		if(boardCate=="PHOTO"){
		    procUrl = "wp_proc.asp";
		}else{
		    procUrl = "w_proc.asp";
		}
		
		$.ajax({
            cache : false,
            url  : procUrl, // ��⿡
            type : 'POST', 
            data : formData, 
            success : function(responseData) {
								
								if(responseData=="OK"){
										alert("정상적으로 처리되었습니다.");
										parent.location.reload();
								}else if(responseData=="NO_VALUE"){
										alert("필수 항목이 빠졌습니다.");
										document.getElementById("bbsBtn").style.display="block";
								}else if(responseData=="NOLEVEL"){
										location.replace("/_mngr/");
								}else if(responseData=="DBERROR"){
										alert("DB 인서트 중 에러가 발생하였습니다.");
										document.getElementById("bbsBtn").style.display="block";
								}else{
										alert("Error.");
										document.getElementById("bbsBtn").style.display="block";
								} 
								
            }, // success 
    
            error : function(xhr, status) {
                alert(xhr + " : " + status);
								document.getElementById("bbsBtn").style.display="block";
            }
     });
				
}













function fileFun(){
		var f = document.bbsForm;
		var fileTypes;
    fileTypes=["pdf","ppt","pptx","xls","xlsx","doc","docx","zip","jpeg","jpg","gif","bmp","png"];
    
	  var source=f.upFile.value;
		if(source.Trim()){
				document.getElementById("upBtn").style.display="none";
				document.getElementById("viewFileDiv").style.display="none";
				document.getElementById("bbsBtn").style.display="none";
				document.getElementById("lodingDiv").style.display="block";
				document.getElementById("lodingDiv_file").style.display="block";
				
		   if(f.upFile.files[0].size>20000000){
    		    alert("Maximum upload capacity : 20,000,000 bytes");
						resetDiv();
    				return;
    		}
				f.action="f_proc.asp";
				f.target="board_procFrame_file";
		    f.submit();
    }		 
}


function resetDiv(){
    document.getElementById("lodingDiv").style.display="none";
		document.getElementById("lodingDiv_file").style.display="none";
    document.getElementById("upBtn").style.display="block";
		document.getElementById("viewFileDiv").style.display="block";
		document.getElementById("bbsBtn").style.display="block";
}


function filePorc_Fun(result,str_or,str_sv){
		document.getElementById("fileDiv").innerHTML="<input type='file' name='upFile' id='upFileBtn' onChange='fileFun()' >";
		if(result=="OK"){
		    var f = document.bbsForm;
				var file_sv_list_val = f.file_sv_list.value;
				var file_or_list_val = f.file_or_list.value;
		
				var new_file_sv_list_val=file_sv_list_val+"|"+str_sv+"|";
				var new_file_or_list_val=file_or_list_val+"|"+str_or+"|";		
		
				f.file_sv_list.value = new_file_sv_list_val;
				f.file_or_list.value = new_file_or_list_val;
				
				insertFileTxt();	
				
				
		}else{
				alert("Missing or invalid your sending values.");
				resetDiv();
		}
}
								
								
								
function insertFileTxt(){
    var f = document.bbsForm;
		var file_sv_list_val = f.file_sv_list.value;
		var file_or_list_val = f.file_or_list.value;
		var file_sv_list_val_sp = file_sv_list_val.split("||");
		var file_or_list_val_sp = file_or_list_val.split("||");
		
		
		
		var insertTxt = "";
		for(var i=0;i<file_sv_list_val_sp.length;i++){
		    var re=/[|]/gi;
		    var each_file_sv = file_sv_list_val_sp[i].replace(re,'');
				var each_file_or = file_or_list_val_sp[i].replace(re,'');
				if(each_file_sv){
				   
    		    insertTxt += "<div style='padding:5px;'>";
    				//insertTxt += "  <div style='float:left;padding-right:20px;'><a href='/upload/board/"+each_file_sv+"' target='_blank' style='text-decoration:none;'>"+each_file_or+"</a></div>";
						insertTxt += "  <div style='float:left;padding-right:20px;'><a href='/upload/download.html?fn="+each_file_sv+"&fd=board&dd="+each_file_or+"' style='text-decoration:none;'>"+each_file_or+"</a></div>";
						insertTxt += "  <div style='float:left;background:#f7941d; text-align:center; font-weight:400; width:50px; height:20px; cursor:pointer; color:#fff; font-size:13px; line-height:20px; border-radius:3px' onClick=\"delFile('"+each_file_sv+"','"+each_file_or+"');\">Delete</div>";
    				insertTxt += "</div>";
    				insertTxt += "<div style='clear:both;'></div>";
				
				
			 
			 
				}		
		}
				
		document.getElementById("viewFileDiv").innerHTML=insertTxt;
			 
		setTimeout(function(){
		      resetDiv(); 
    },100)
										
}


function delFile(str_sv,str_or){
    var f = document.bbsForm    ;
		if(str_sv){
		    if(confirm("정말 삭제하시겠습니까 ?")){
				
    				document.getElementById("upBtn").style.display="none";
    				document.getElementById("viewFileDiv").style.display="none";
						document.getElementById("bbsBtn").style.display="none";
    				document.getElementById("lodingDiv").style.display="block";
    				document.getElementById("lodingDiv_file").style.display="block";
						
						var file_sv_list_val = f.file_sv_list.value;
						var file_or_list_val = f.file_or_list.value;
						var del_sv_list_val  = f.del_sv.value;
						
						
						f.file_sv_list.value = file_sv_list_val.replace("|"+str_sv+"|","");
						f.file_or_list.value = file_or_list_val.replace("|"+str_or+"|","");
						f.del_sv.value  = del_sv_list_val+"|"+str_sv+"|";						
						
				    insertFileTxt();
													
				}
		}
}













































function thum_fileFun(fn,ptype,btnId,id_01,id_02,id_03,id_04,id_05,id_06,sv_id,or_id,foldName,delC){
  		
			var f = document.forms[fn];
			var fileTypes;
      fileTypes=ptype.split("|");
			
  	  var source=eval("f."+id_01).value;
  		if(source.Trim()){
  				document.getElementById(id_02).style.display="none";
  				document.getElementById(id_03).style.display="none";
  				document.getElementById(btnId).style.display="none";
  				document.getElementById(id_04).style.display="block";
  				document.getElementById(id_05).style.display="block";
  		    
  				var ext=source.substring(source.lastIndexOf(".")+1,source.length).toLowerCase();
      		var chk="no"
      		for(var i=0;i<fileTypes.length;i++){
      		    if(fileTypes[i]==ext){
      				    chk="yes"
      				    break;
      				}		
      		}
  				if (chk=="no"){
                alert("Please check your file format.");
  							thum_resetDiv(btnId,id_01,id_02,id_03,id_04,id_05)
              	return;
      		}	
      		if(eval("f."+id_01).files[0].size>20000000){
      		    alert("Maximum upload capacity : 20,000,000 bytes");
  						thum_resetDiv(btnId,id_01,id_02,id_03,id_04,id_05)
      				return;
      		}
  				f.action="f_1_proc.asp?fn="+fn+"&ptype="+ptype+"&btnId="+btnId+"&id_01="+id_01+"&id_02="+id_02+"&id_03="+id_03+"&id_04="+id_04+"&id_05="+id_05+"&id_06="+id_06+"&sv_id="+sv_id+"&or_id="+or_id+"&foldName="+foldName+"&delC="+delC;
  				f.target="board_procFrame_file";
  		    f.submit();
      }		 
}

function thum_resetDiv(btnId,id_01,id_02,id_03,id_04,id_05){
      document.getElementById(id_04).style.display="none";
  		document.getElementById(id_05).style.display="none";
      document.getElementById(id_02).style.display="block";
  		document.getElementById(id_03).style.display="block";
  		document.getElementById(btnId).style.display="block";
}  



function thum_filePorc_Fun(result,str_or,str_sv,fn,ptype,btnId,id_01,id_02,id_03,id_04,id_05,id_06,sv_id,or_id,foldName,delC){
      
			
			var fileTypes
			var fileTxt="";
      fileTypes=ptype.split("|");
			for(var i=0;i<fileTypes.length;i++){
			    if(fileTxt==""){
					    fileTxt="."+fileTypes[i];					
					}else{
					    fileTxt=fileTxt+",."+fileTypes[i];
					}
			    
			}
			
			document.getElementById(id_06).innerHTML="<input type='file' name='"+id_01+"' id='"+id_01+"' onChange=\"thum_fileFun('"+fn+"','"+ptype+"','"+btnId+"','"+id_01+"','"+id_02+"','"+id_03+"','"+id_04+"','"+id_05+"','"+id_06+"','"+sv_id+"','"+or_id+"','"+foldName+"','"+delC+"')\" accept='image/*'>";
  		if(result=="OK"){
			    var f = document.forms[fn];
					
					var file_sv_list_val = document.getElementById(sv_id).value;
  				var file_or_list_val = document.getElementById(or_id).value;
  				var del_sv_list_val  = f.del_sv.value;
  		    if(file_sv_list_val){
  				    f.del_sv.value  = del_sv_list_val+"|"+file_sv_list_val+"|";
  				}
  				document.getElementById(sv_id).value = str_sv;
  				document.getElementById(or_id).value = str_or;
  				
  				thum_insertFileTxt(fn,ptype,btnId,id_01,id_02,id_03,id_04,id_05,id_06,sv_id,or_id,foldName,delC);	
  				
  		}else{
  				alert("Missing or invalid your sending values.");
  				thum_resetDiv(btnId,id_01,id_02,id_03,id_04,id_05);
  		}
}



function thum_insertFileTxt(fn,ptype,btnId,id_01,id_02,id_03,id_04,id_05,id_06,sv_id,or_id,foldName,delC){
      var f = document.forms[fn];
  		var file_sv_list_val = document.getElementById(sv_id).value;
  		var file_or_list_val = document.getElementById(or_id).value;
  		
  		var insertTxt = "";
  
      var re=/[|]/gi;
      var each_file_sv = file_sv_list_val.replace(re,'');
  		var each_file_or = file_or_list_val.replace(re,'');
  		if(each_file_sv){
  		    insertTxt += "<div style='padding:8px 5px;font-size:18px;'>";
  				insertTxt += "<div style='float:left;padding-right:20px;'><a href='/upload/"+foldName+"/"+each_file_sv+"' style='text-decoration:none;' target='_blank'>"+each_file_or+"</a></div>";
					if(delC=="Y"){
					    insertTxt += "<div style='float:left;background:#f7941d; text-align:center; font-weight:400; width:50px; height:20px; cursor:pointer; color:#fff; font-size:13px; line-height:20px; border-radius:3px' onClick=\"thum_delFile('"+each_file_sv+"','"+each_file_or+"','"+fn+"','"+ptype+"','"+btnId+"','"+id_01+"','"+id_02+"','"+id_03+"','"+id_04+"','"+id_05+"','"+id_06+"','"+sv_id+"','"+or_id+"','"+foldName+"','"+delC+"');\">Delete</div>";
					}
      		
  		}

  				
  		document.getElementById(id_03).innerHTML=insertTxt;
  			 
  		setTimeout(function(){
  		      thum_resetDiv(btnId,id_01,id_02,id_03,id_04,id_05); 
      },100)
  										
}


function thum_delFile(str_sv,str_or,fn,ptype,btnId,id_01,id_02,id_03,id_04,id_05,id_06,sv_id,or_id,foldName,delC){
      var f = document.forms[fn];
  		if(str_sv){
  		    if(confirm("정말 삭제하시겠습니까 ?")){
      				document.getElementById(id_02).style.display="none";
      				document.getElementById(id_03).style.display="none";
  						document.getElementById(btnId).style.display="none";
      				document.getElementById(id_04).style.display="block";
      				document.getElementById(id_05).style.display="block";
  						
  						var del_sv_list_val  = f.del_sv.value;
  						
  						f.del_sv.value  = del_sv_list_val+"|"+str_sv+"|";						
  						
  						document.getElementById(sv_id).value = "";
  						document.getElementById(or_id).value = "";
  						
  
  				    thum_insertFileTxt(fn,ptype,btnId,id_01,id_02,id_03,id_04,id_05,id_06,sv_id,or_id,foldName,delC);
  													
  				}
  		}
}
									 
//-->