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
<!-- #include virtual="/registration/reg_config_inc.asp" -->
<%
Call isAdminChk(1)
%>
<script type="text/JavaScript">
<!--


//-->
</script>


<div id="contentDiv" >
<!--
<span class='bigBmenu'>Îì±Î°ù&nbsp;</span>
<span class='selectedMenu' >&nbsp;<%=menuAr_Info_sub(menuIdx)%></span>
<div style='height:13px;'></div>
-->

<!-- #include file="active/REG/exe_inc_config.asp" -->
<!-- #include file="active/REG/exe_inc_subMenu.asp" -->
<!-- #include file="active/REG/exe_inc_searchForm.asp"; ∞Àªˆ ∆˚ -->
<!-- #include file="active/REG/exe_inc_list.asp"; -->
</div>

<div style='text-align:center;padding-top:20px;'>
<center>
<%Call gotoPageHTML(pageNo, listBlock,rsPageCount,"menuIdx="&menuIdx&"&listViewCnt="&listViewCnt&"&sMenu="&sMenu&searchLinkString&"&bMenu="&bMenu&"&mCate="&mCate)%>
</center>
</div>


<form name="downloadQryForm" method="post">
<input type="hidden" name="downloadQry"  value="<%=downloadQry%>">
</form>