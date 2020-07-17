<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %>
<%
Option Explicit
Response.CharSet = "utf-8"
%>
<object Runat="Server" Progid="ADODB.Connection" id="dbCon"></object>
<object Runat="Server" Progid="ADODB.RecordSet" id="rs"></object>
<!-- #include virtual="/common/inc/noCache.asp" -->
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<!-- #include virtual="/common/inc/base64.asp" -->
<!-- #include virtual="/common/inc/dbCon.asp" -->
<!-- #include virtual="/common/inc/country.asp" -->
<!-- #include virtual="/common/inc/countryCode.asp" -->
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<!-- #include virtual="/_mngr/active/GALLERY/gallery_config_inc.asp" -->
<%
Call isAdminChk(1)
%>
<script type="text/JavaScript">
<!--
function imgOnloadErr(str){

}

function adminFormProc() {
    var form = document.adminForm;

    /* if (!form.elements['cate'].value) {
        alert('카테고리를 선택하세요~');
        form.elements['cate'].focus(); return false;
    }   */  
    if (!form.elements['subject'].value) {
        alert('제목을 입력하세요');
        form.elements['subject'].focus(); return false;
    }
		
		var deposit_01 = form.sY.value;
    var deposit_02 = form.sM.value;
    var deposit_03 = form.sD.value; 
		
		if (!deposit_01.Trim()) {
          alert("작성 날짜를 확인해 주세요."); form.sY.focus();return;
    }

 		if (deposit_01.length<4) {
         alert("작성 날짜를 확인해 주세요."); form.sY.focus();return;
    }
      		
 		if (!deposit_02.Trim()) {
         alert("작성 날짜를 확인해 주세요."); form.sM.focus();	return;
    }

 		if (parseInt(deposit_02,10)==0||parseInt(deposit_02,10)>12) {
         alert("작성 날짜를 확인해 주세요."); form.sM.focus();return;
    }
      		
 		if (!deposit_03.Trim()) {
         alert("작성 날짜를 확인해 주세요."); form.sD.focus();return;
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
         alert("작성 날짜를 확인해 주세요."); form.sD.focus();return;
    } 
		
				
		
		if(!form.b_langCheck.value){
		    alert("보여질 언어를 선택해 주세요.");form.b_langCheck.focus();return;
		}
		
		
    if (!form.elements['userFile'].value) {
        alert('업로드할 파일을 선택하세요');
        form.elements['userFile'].focus(); return false;
    }
    document.getElementById("gButton").style.display="none";
		
    form.method = 'post'
    form.action = '/_mngr/active/GALLERY/gallery_proc.asp';
    form.submit();
}

function modifyCheck(){

    var form = document.forms['adminForm'];
    /* if (!form.elements['cate'].value) {
        alert('날짜를 선택하세요~');
        form.elements['cate'].focus(); return false;
    } */
    if (!form.elements['subject'].value) {
        alert('제목을 입력하세요');
        form.elements['subject'].focus(); return false;
    }
		/* if (!form.elements['subjectKr'].value) {
        alert('국문 제목을 입력하세요');
        form.elements['subjectKr'].focus(); return false;
    } */
    /* if (!form.elements['content'].value) {
        alert('내용을 입력하세요');
        form.elements['content'].focus(); return false;
    } */
		
		
		var deposit_01 = form.sY.value;
    var deposit_02 = form.sM.value;
    var deposit_03 = form.sD.value; 
		
		if (!deposit_01.Trim()) {
          alert("작성 날짜를 확인해 주세요."); form.sY.focus();return;
    }

 		if (deposit_01.length<4) {
         alert("작성 날짜를 확인해 주세요."); form.sY.focus();return;
    }
      		
 		if (!deposit_02.Trim()) {
         alert("작성 날짜를 확인해 주세요."); form.sM.focus();	return;
    }

 		if (parseInt(deposit_02,10)==0||parseInt(deposit_02,10)>12) {
         alert("작성 날짜를 확인해 주세요."); form.sM.focus();return;
    }
      		
 		if (!deposit_03.Trim()) {
         alert("작성 날짜를 확인해 주세요."); form.sD.focus();return;
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
         alert("작성 날짜를 확인해 주세요."); form.sD.focus();return;
    } 
		
				
		
		if(!form.b_langCheck.value){
		    alert("보여질 언어를 선택해 주세요.");form.b_langCheck.focus();return;
		}
		
		
		
		document.getElementById("gButton").style.display="none";
    
    form.method = 'post'
    form.action = '/_mngr/active/GALLERY/modify_proc.asp';
    form.submit();
}





function delsubfom(str){

		if(confirm('정말 삭제하시겠습니까??')){
        document.getElementById("procFrame").src="/_mngr/active/GALLERY/pop_upload_proc.asp?actionCate=DEL&idx="+str;
		}
}	

function ressubfom(str){
		if(confirm('정말 복구하시겠습니까??')){
        document.getElementById("procFrame").src="/_mngr/active/GALLERY/pop_upload_proc.asp?actionCate=RESTORE&idx="+str;
		}
}	

//-->
</script>


<div id="contentDiv" >
<!-- #include file="active/GALLERY/exe_inc_config.asp" -->
<!-- #include file="active/GALLERY/exe_inc_subMenu.asp" -->
<!-- include file="active/GALLERY/exe_inc_searchForm.asp"; �˻� �� -->
<!-- #include file="active/GALLERY/exe_inc_list.asp"; -->
</div>

<div style='text-align:center;padding-top:20px;'>
<center>
<%Call gotoPageHTML(pageNo, listBlock,rsPageCount,"menuIdx="&menuIdx&"&listViewCnt="&listViewCnt&"&sMenu="&sMenu&searchLinkString&"&bMenu="&bMenu&"&mCate="&mCate)%>
</center>
</div>


<form name="downloadQryForm" method="post">
<input type="hidden" name="downloadQry"  value="<%=downloadQry%>">
</form>
