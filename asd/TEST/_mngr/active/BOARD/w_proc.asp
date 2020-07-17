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

if isNumeric(adLevel) then
    adLevel = cint(adLevel)
else
    adLevel = 0
end if

if adLevel<1 then
		response.write "NOLEVEL"
		response.end
end if

Dim boardCate,b_mode,file_sv,file_or,file_sv_list,file_or_list,del_sv
Dim title,link_txt,sY,sM,sD,b_langCheck,content,m_idx
boardCate         = inSql(trim(request.form("boardCate")))
b_mode						= inSql(trim(request.form("b_mode")))
file_sv						= inSql(trim(request.form("file_sv")))
file_or						= inSql(trim(request.form("file_or")))
file_sv_list			= inSql(trim(request.form("file_sv_list")))
file_or_list			= inSql(trim(request.form("file_or_list")))
del_sv						= inSql(trim(request.form("del_sv")))
title							= inSql(trim(request.form("title")))
link_txt					= inSql(trim(request.form("link_txt")))
sY								= inSql(trim(request.form("sY")))
sM								= inSql(trim(request.form("sM")))
sD								= inSql(trim(request.form("sD")))
b_langCheck				= inSql(trim(request.form("b_langCheck")))
content						= inSql(trim(request.form("content")))
m_idx							= inSql(trim(request.form("m_idx")))
									 
									 
if isEmptyStr(boardCate) then
		response.write "NO_VALUE"
		response.end
end if

Dim view_date
view_date = sY&"-"&sM&"-"&sD
		


Dim b_regIp
b_regIp       = request.ServerVariables("REMOTE_ADDR")

Call dbConOpen()
if isEmptyStr(m_idx) then
     Call connOpenOnly()
        With conn     

            .ActiveConnection = dbCon
            .CommandText = "insert into TB_board(boardCate,title,content,view_date,file_or,file_sv,link_txt,b_langCheck,b_regIp,file_or_list,file_sv_list) values(?,?,?,?,?,?,?,?,?,?,?)"
            .CommandType = adCmdText
						
						.Parameters.Append .CreateParameter("@boardCate",	    adVarWChar, 	adParamInput, 50,	boardCate)
						.Parameters.Append .CreateParameter("@title",	        adVarWChar, 	adParamInput, 255,	title)
						.Parameters.Append .CreateParameter("@content",	      adLongVarWChar, 	adParamInput, len(content)*2+1,	content)
						
						
						.Parameters.Append .CreateParameter("@view_date",	    adVarWChar, 	adParamInput, 50,	view_date)
						.Parameters.Append .CreateParameter("@file_or",	      adVarWChar, 	adParamInput, 255,	file_or)
						.Parameters.Append .CreateParameter("@file_sv",	      adVarWChar, 	adParamInput, 50,	file_sv)
						
						
						.Parameters.Append .CreateParameter("@link_txt",	    adVarWChar, 	adParamInput, 4000,	link_txt)

						.Parameters.Append .CreateParameter("@b_langCheck",	  adVarWChar, 	adParamInput, 10,	b_langCheck)
						
						.Parameters.Append .CreateParameter("@b_regIp",	      adVarWChar, 	adParamInput, 50,	b_regIp)
        		.Parameters.Append .CreateParameter("@file_or_list",	adVarWChar, 	adParamInput, 4000,	file_or_list)
						.Parameters.Append .CreateParameter("@file_sv_list",	adVarWChar, 	adParamInput, 4000,	file_sv_list)
						
            .Execute, , adExecuteNoRecords
        		
        End With
    Call connClose()	
				
    
else
    
end if
Call dbConClose()


Dim del_sv_sp
if not isEmptyStr(del_sv) then
    del_sv_sp  = replace(del_sv,"||",",")
    del_sv_sp  = replace(del_sv_sp,"|","")
    del_sv_sp  = split(del_sv_sp,",")
		
		Dim fsObject
    Set fsObject = CreateObject("Scripting.FileSystemObject")
		
		Dim delUrl
		for i=0 to ubound(del_sv_sp)
		    delUrl = Request.ServerVariables("APPL_PHYSICAL_PATH")&"upload\board\"&del_sv_sp(i)
				
				response.write delUrl
		    if fsObject.FileExists(delUrl)=true then
            fsObject.DeleteFile(delUrl)
        end if		
		next
		
		Set fsObject = Nothing
end if


response.write "OK"
response.end 
%>