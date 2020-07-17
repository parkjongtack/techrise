<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %>
<% Option Explicit %>
<%Response.CharSet = "utf-8"%>
<object Runat="Server" Progid="ADODB.Connection" id="dbCon"></object>
<object Runat="Server" Progid="ADODB.RecordSet" id="rs"></object>
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<!-- #include virtual="/_common/inc/base64.asp" -->
<!-- #include virtual="/_common/inc/dbCon.asp" -->
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<!-- #include virtual="/_mngr/active/GALLERY/gallery_config_inc.asp" -->
<%

call isAdminChk_iframe(5)

Dim actionCate

Dim idx

actionCate = inSqlInjection(request("actionCate"))
Dim sql

if actionCate="DEL" or actionCate="RESTORE" then
    idx             = base64Decode(request.QueryString("idx"))
		
		if actionCate="DEL" then
		    Dim strQuery
				strQuery = "select fileName, thumbNail, viewNail from AAC_gallery where idx=" & idx
				call dbConOpen()
				rs.open strQuery,dbCon,1
				Dim fileName, thumbNail, viewNail
				if not rs.EOF then
				    fileName     = rs(0)
						thumbNail    = rs(1)
						viewNail  = rs(2)
						Call delUserFile(fileName,thumbNail,viewNail)
				end if
				call dbConClose()




		
        sql="update AAC_gallery  set actResult=1  where idx = '"&idx&"' "

				
				
    else
        sql="update AAC_gallery  set actResult=0  where idx = '"&idx&"' "		
    end if
end if


Sub delUserFile(dbFileName,dbThuFileName,dbThuviewFileName)
    Dim fsObject
    Set fsObject = CreateObject("Scripting.FileSystemObject")
   
    Dim dbFile, dbThuFile, dbThuViewFile
    dbFile    = saveFileDir & photoFolder & "\" & dbFileName
    dbThuFile = saveFileDir & thumbFolder & "\" & dbThuFileName 
		dbThuViewFile= saveFileDir & viewFolder & "\" & dbThuviewFileName
    
    ' 원본 이미지 삭제
    if fsObject.FileExists(dbFile)=true then
        fsObject.DeleteFile(dbFile)
    end if
    ' 썸네일 이미지 삭제
    if fsObject.FileExists(dbThuFile)=true then
        fsObject.DeleteFile(dbThuFile)
    end if
		
		if fsObject.FileExists(dbThuViewFile)=true then
        fsObject.DeleteFile(dbThuViewFile)
    end if
    
    Set fsObject = Nothing
End Sub


Call dbConOpen()
dbCon.execute(sql)
Call dbConClose()
response.write "<script language=""JavaScript"" type=""text/javascript"">" &_
               "alert('completed.'); parent.location.reload();document.location.href = 'about:blank';" &_
               "</script>"
response.end
%>