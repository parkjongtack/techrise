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
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->


<%
Response.CharSet = "utf-8"
call isAdminChk_iframe(5)

Dim sql,targetIdx,cate
targetIdx=base64Decode(request("targetIdx"))
cate = request("cate")
if cate<>"Y" and cate<>"N" then
response.write "<script language=""JavaScript"" type=""text/javascript"">" &_
               "alert('Error.'); parent.location.reload();document.location.href = 'about:blank';" &_
               "</script>"
response.end
end if
Call dbConOpen()

sql=" update AAC_registration  set actStatus=N'"&cate&"'  where r_idx = '"&targetIdx&"' "


dbCon.execute(sql)
Call dbConClose()
response.write "<script language=""JavaScript"" type=""text/javascript"">" &_
               "alert('completed.'); parent.location.reload();document.location.href = 'about:blank';" &_
               "</script>"
response.end
%>

