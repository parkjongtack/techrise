<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %>
<%
Option Explicit
Response.CharSet = "utf-8"
%>
<object Runat="Server" Progid="ADODB.Connection" id="dbCon"></object>
<object Runat="Server" Progid="ADODB.RecordSet" id="rs"></object>
<!-- #include virtual="/_common/inc/noCache.asp" -->
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<!-- #include virtual="/_common/inc/base64.asp" -->
<!-- #include virtual="/_common/inc/dbCon.asp" -->
<!-- #include virtual="/_common/inc/country.asp" -->
<!-- #include virtual="/_common/inc/countryCode.asp" -->
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<!-- #include virtual="/_mngr/active/GALLERY/gallery_config_inc.asp" -->
<!-- #include virtual="/gallery/gallery_cagegory_inc.asp" -->
<%
Call isAdminChk(1)
%>

<script type="text/JavaScript">
<!--
function imgOnloadErr(str){

}

function adminFormProc() {
    var form = document.adminForm;

    if (!form.elements['cate'].value) {
        alert('카테고리를 선택하세요~');
        form.elements['cate'].focus(); return false;
    }    
    /* if (!form.elements['subject'].value) {
        alert('제목을 입력하세요');
        form.elements['subject'].focus(); return false;
    } */
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
    if (!form.elements['cate'].value) {
        alert('날짜를 선택하세요~');
        form.elements['cate'].focus(); return false;
    }
    /* if (!form.elements['subject'].value) {
        alert('제목을 입력하세요');
        form.elements['subject'].focus(); return false;
    } */
		/* if (!form.elements['subjectKr'].value) {
        alert('국문 제목을 입력하세요');
        form.elements['subjectKr'].focus(); return false;
    } */
    /* if (!form.elements['content'].value) {
        alert('내용을 입력하세요');
        form.elements['content'].focus(); return false;
    } */
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
<!--
<span class='bigBmenu'>국민광장&nbsp;</span>
<span class='selectedMenu' >&nbsp;<%=menuAr_Info_sub(menuIdx)%></span>
<div style='height:13px;'></div>
-->

<!-- #include file="active/GALLERY/exe_inc_config.asp" -->
<!-- #include file="active/GALLERY/exe_inc_subMenu.asp" -->
<!-- #include file="active/GALLERY/exe_inc_searchForm.asp"; �˻� �� -->
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