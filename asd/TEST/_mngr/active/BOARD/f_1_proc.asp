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
Function chkAllowFileType(fType, fTypeAr)
    Dim allowFileAr_T
		If not inArray(fTypeAr, LCase(fType))  Then
        Call proc_iframe_alert("í—ˆìš©ë˜ì§€ ì•ŠëŠ” íŒŒì¼íƒ€ìž…ìž…ë‹ˆë‹¤..","about:blank","")
		    response.end
    End If

End Function

Function chkAllowFileSize(fSize,allowFileSize)
    If fSize>allowFileSize then
				Call proc_iframe_alert("ERROR_0002.\n\n"&FormatNumber(fSize/1024/1024,2)&"MB > "&FormatNumber(allowFileSize/1024/1024,2)&"MB","about:blank","")
        response.end
    End If
End Function


Call isAdminChk_iframe(1)


Dim fn,ptype,btnId,id_01,id_02,id_03,id_04,id_05,id_06,sv_id,or_id,foldName,delC
fn			  = inSql(request("fn"))
ptype			= inSql(request("ptype"))
btnId			= inSql(request("btnId"))
id_01			= inSql(request("id_01"))
id_02			= inSql(request("id_02"))
id_03			= inSql(request("id_03"))
id_04			= inSql(request("id_04"))
id_05			= inSql(request("id_05"))
id_06			= inSql(request("id_06"))
sv_id			= inSql(request("sv_id"))
or_id			= inSql(request("or_id"))
foldName	= inSql(request("foldName"))
delC			= inSql(request("delC"))



Randomize  ' ³­¼ö ÃÊ±âÈ­
Dim file_key
file_key = Year(now) & calc(Month(now),2) & calc(Day(now),2) & calc(Hour(now),2) & calc(Minute(now),2) & calc(Second(now),2) 
file_key = file_key & "_" & calc(CLng(Rnd*100000) + 1 , 5)   ' 00001 ~ 99999±îÁö ³­¼ö ¹ß»ý
 
 

Dim cnfg_tmpSaveDir :  cnfg_tmpSaveDir      = "D:\TEMP"  ' ÀÓ½Ã ÀúÀå Æú´õ
Dim Upload
'¾÷·Îµå¸¦ Ã³¸®ÇÒ ¿ÀºêÁ§Æ®¸¦ »ý¼ºÇÕ´Ï´Ù.
Set Upload = Server.CreateObject("TABS.Upload")

Upload.CodePage = 65001   ' UTF-8 À¯´
Upload.Start cnfg_tmpSaveDir, true
Dim allowFileAr     

Dim cnfg_maxFileSize   : cnfg_maxFileSize = 20971520  '10MB
Dim cnfg_saveFileDir   
cnfg_saveFileDir   = Request.ServerVariables("APPL_PHYSICAL_PATH")&"upload\board\"


Dim form_file : Set form_file = Upload.Form("id_01")


allowFileAr      = array("jpg","gif","jpeg","png","bmp")

Dim fileUpChk
fileUpChk ="N"
		
Dim saveU
saveU=cnfg_saveFileDir




If not IsEmptyStr(form_file) Then
    if form_file.FileSize <> 0 then
        Dim fileSize, fileType, mimeType, saveName
    		Dim fileNmOr
    		fileNmOr = form_file.FileName
    		mimeType  = Lcase(form_file.contentType)
        fileSize = form_file.FileSize
        fileType = Lcase(form_file.FileType)
    				
    		Call chkAllowFileType(fileType,allowFileAr)
				
				Call chkAllowFileSize(fileSize,cnfg_maxFileSize)
    		saveName = file_key&"."&fileType
				
				form_file.saveAs  saveU&saveName, true
        fileUpChk="Y"  
    end if
End If	

Set form_file = nothing

if fileUpChk="Y"  then
    Call proc_Function("parent.thum_filePorc_Fun('OK','"&fileNmOr&"','"&saveName&"','"&fn&"','"&ptype&"','"&btnId&"','"&id_01&"','"&id_02&"','"&id_03&"','"&id_04&"','"&id_05&"','"&id_06&"','"&sv_id&"','"&or_id&"','"&foldName&"','"&delC&"')","")
else
    Call proc_Function("parent.thum_filePorc_Fun('NO','','','"&fn&"','"&ptype&"','"&btnId&"','"&id_01&"','"&id_02&"','"&id_03&"','"&id_04&"','"&id_05&"','"&id_06&"','"&sv_id&"','"&or_id&"','"&foldName&"','"&delC&"')","")
end if
%>