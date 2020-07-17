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
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<%
Call isAdminChk(1)



Dim boardCate : boardCate="VIDEO"
%>
<script src="/common/js/jquery-2.1.3.min.js"></script>
<!-- #include virtual="/common/inc/modal.asp" -->
<div id="contentDiv" >
<!-- #include file="active/BOARD/exe_inc_config.asp" -->
<!-- #include file="active/BOARD/exe_inc_searchForm.asp"; -->
<!-- #include file="active/BOARD/exe_inc_list_video.asp"; -->
</div>

<div style='text-align:center;padding-top:20px;'>
<center>
<%Call gotoPageHTML(pageNo, listBlock,rsPageCount,"menuIdx="&menuIdx&"&listViewCnt="&listViewCnt&"&sMenu="&sMenu&searchLinkString&"&bMenu="&bMenu&"&mCate="&mCate)%>
</center>
</div>


<form name="downloadQryForm" method="post">
<input type="hidden" name="downloadQry"  value="<%=downloadQry%>">
</form>