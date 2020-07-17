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

Call isAdminChk_iframe(5)


Dim delIdx
delIdx   = base64Decode(request("delIdx"))

Dim b_modiIp
b_modiIp       = request.ServerVariables("REMOTE_ADDR")

Call dbConOpen()
if isEmptyStr(delIdx) then
     Call connOpenOnly()
        With conn     

            .ActiveConnection = dbCon
            .CommandText = " update TB_board set b_actStatus='N', b_modiDate = getDate(), b_modiIp =?   where idx = ? "
            .CommandType = adCmdText
        		.Parameters.Append .CreateParameter("@idx",	            adInteger, 	adParamInput, 4,	delIdx)
						.Parameters.Append .CreateParameter("@b_modiIp",	      adVarWChar, 	adParamInput, 50,	b_modiIp)
            .Execute, , adExecuteNoRecords
        		
        End With
    Call connClose()	
end if
Call dbConClose()

response.write " update TB_board set b_actStatus='N', b_modiDate = getDate(), b_modiIp ='"&b_modiIp&"'   where idx = "&delIdx
'Call proc_Function("parent.location.reload();","")
%>