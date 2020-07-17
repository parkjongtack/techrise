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
'On Error Resume next


call isAdminChk_iframe(5)
Server.ScriptTimeOut = 10000


Dim Upload : Set Upload = Server.CreateObject("TABSUpload4.Upload")


Upload.CodePage = 65001   ' UTF-8 À¯´ÏÄÚµå ÀÛ¼º
Upload.start tmpSaveDir', False     ' ÆÄÀÏÀÇ ¼Ó¼ºÀ» ¾Ë±â À§ÇØ ÀÓ½ÃÆú´õ¿¡ ¾÷·Îµå

Dim form : Set form = Upload.Form("userFile")

Dim bcate_F
bcate_F = trim(Upload.Form("bcate_F"))

if not form.isFile then   ' Æû¿¡¼­ ³Ñ¾î¿Â °ªÀÌ ÆÄÀÏ or TextÀÎÁö Ã¼Å©
        echobr "no file"
        response.end
end if



Dim idx,cate
Dim writer, subject, content, userIp,rUrl,subjectKr
idx      = trim(Upload.Form("idx"))
writer   = "admin"
cate     = trim(Upload.Form("cate"))
subject  = inSqlInjection(trim(Upload.Form("subject")))
content  = inSqlInjection(trim(Upload.Form("content")))

Dim typeError,sizeError,typeChk,sizeChk
typeError = 0
sizeError = 0
Dim subForm,mimeType, fileType, fileName, fileSize
Dim saveFileName, thumbNailFile, saveSql, returnUrl,thumbViewFile
Dim imgWidth, imgHeight
Dim thumbWidth, thumbHeight
Dim viewWidth, viewHeight

if form.isFile then
    

    mimeType  = Lcase(form.contentType)    ' ÆÄÀÏ Çü½Ä
    fileType  = Lcase(form.fileType)       ' ÆÄÀÏÀÇ È®Àå¸í
    fileName  = form.fileName       ' ÆÄÀÏ¸í
    fileSize  = form.fileSize       ' ÆÄÀÏ ¿ë·®
    

    ' Çã¿ë ÆÄÀÏ Ã¼Å© ---------------------------------------------------------------
    if not inArray(allowMimeType, mimeType) or not inArray(allowFileType, fileType) then
        Call Alert("File Type Error", -1)
        response.end
    end if
    
    if fileSize>maxImageSize then
        Call Alert("File Size Error. Maximum size to "&formatNumber(maxImageSize/1024)&"Kbyte.", -1)
        response.end
    end if
    ' ------------------------------------------------------------------------------
    
    
    
    ' ÀúÀåµÉ ½æ³×ÀÏ ÀÌ¹ÌÁö Å©±â ÁöÁ¤ -----------------------------------------------
    
    imgWidth  = form.imageWidth     ' ÀÌ¹ÌÁö Æø
    imgHeight = form.imageHeight    ' ÀÌ¹ÌÁö ³ôÀÌ
    
   
    if imgWidth>=pvLiImgWidth or imgHeight>=pvLiImgHeight then
        if imgWidth>=imgHeight then
            thumbWidth  = pvLiImgWidth
            thumbHeight = imgHeight / formatNumber((imgWidth/pvLiImgWidth),2)
            thumbHeight = Clng(thumbHeight)
            if thumbHeight>pvLiImgHeight then   ' ³ôÀÌ°¡ ±âº»°ªº¸´Ù Å¬ °æ¿ì
                thumbHeight = pvLiImgHeight
            end if
        elseif imgWidth<imgHeight then
            thumbHeight = pvLiImgHeight
            thumbWidth  = imgWidth / formatNumber((imgHeight/pvLiImgHeight),2)
            thumbWidth = Clng(thumbWidth)
            if thumbWidth>pvLiImgWidth then   ' ÆøÀÌ ±âº»°ªº¸´Ù Å¬ °æ¿ì
                thumbWidth = pvLiImgWidth
            end if
        end if
    else
        thumbWidth = imgWidth
        thumbHeight = imgHeight
    end if
    ' ------------------------------------------------------------------------------
    
    
    
    
    
    
    if imgWidth>=viewImgWidth or imgHeight>=viewImgHeight then
        if imgWidth>=imgHeight then
            viewWidth  = viewImgWidth
            viewHeight = imgHeight / formatNumber((imgWidth/viewImgWidth),2)
            viewHeight = Clng(viewHeight)
            if viewHeight>viewImgHeight then   ' ³ôÀÌ°¡ ±âº»°ªº¸´Ù Å¬ °æ¿ì
                viewHeight = viewImgHeight
            end if
        elseif imgWidth<imgHeight then
            viewHeight = viewImgHeight
            viewWidth  = imgWidth / formatNumber((imgHeight/viewImgHeight),2)
            viewWidth = Clng(viewWidth)
            if viewWidth>viewImgWidth then   ' ÆøÀÌ ±âº»°ªº¸´Ù Å¬ °æ¿ì
                viewWidth = viewImgWidth
            end if
        end if
    else
        viewWidth = imgWidth
        viewHeight = imgHeight
    end if
    ' ------------------------------------------------------------------------------

    'echobr imgWidth
    'echobr imgHeight
    '
    'echobr thumbWidth
    'echobr thumbHeight
end if




idx      = trim(Upload.Form("idx"))
writer   = "admin"
cate     = trim(Upload.Form("cate"))
subject  = inSqlInjection(trim(Upload.Form("subject")))
content  = inSqlInjection(trim(Upload.Form("content")))
userIp   = request.serverVariables("REMOTE_ADDR") 
subjectKr= inSqlInjection(trim(Upload.Form("subjectKr")))



' ¾÷·Îµå ÆÄÀÏ ÀúÀå ÇÔ¼ö. -------------------------------------------------------
function FnSaveUserFile()
    '¾÷·ÎµåµÈ ÆÄÀÏÀ» ÀúÀå
    Upload.Save saveFileDir & photoFolder, false  ' Áßº¹½Ã ÆÄÀÏ¸í ÀÚµ¿ º¯°æ
    
    Dim fso, MyFile
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    ' FileSystem Object ¸¦ ÀÌ¿ë ÀúÀåµÈ ÆÄÀÏ¸íÀ» º¯°æ.
    Dim saveFilePath, saveFileName, newFileName
    saveFilePath = saveFileDir & photoFolder & "\"
    saveFileName = form.shortSaveName

    newFileName  = Year(now)&Calc(Month(now),2)&Calc(Day(now),2)&Calc(Hour(now),2)&Calc(Minute(now),2)&Calc(Second(now),2)&"." & fileType

    if fso.FileExists(newFileName)=true then ' Áßº¹ ÆÄÀÏ¸í °Ë»ç
        randomize
        newFileName = Year(now)&Calc(Month(now),2)&Calc(Day(now),2)&Calc(Hour(now),2)&Calc(Minute(now),2)&Calc(Second(now),2)&"_"&Calc(int(rnd*100),3)&"." & fileType
    end if
    ' ½ÇÁ¦ ÀúÀåµÉ ÆÄÀÏ¸í : newFileName
    
    ' ÀúÀåµÈ ÆÄÀÏ¸í ±³Ã¼
  '  echobr saveFilePath&saveFileName&"<br>"
'    echobr saveFilePath&newFileName
'    response.end
    
    fso.MoveFile saveFilePath&saveFileName, saveFilePath&newFileName
    set fso = nothing
    
    FnSaveUserFile = newFileName  ' DB¿¡ ÀúÀåµÉ ÆÄÀÏ¸íÀ» ¹İÈ¯ÇÔ.
End Function
' ------------------------------------------------------------------------------


Function CreateThumbNail(userFileName)

		Dim Image, Status
    Set Image = Server.CreateObject("TABSUpload4.Image")
    Status = Image.Load(saveFileDir&photoFolder&"\"&userFileName)
		
		
    If Status = 0 Then
        Image.SaveThumbnail saveFileDir & thumbFolder & "\sm_" &userFileName, thumbWidth, 0, 90
        Image.SaveThumbnail saveFileDir & viewFolder & "\vw_" &userFileName, viewWidth, 0, 90
        Image.Close
    Else
        Response.Write "ì´ë¯¸ì§€ íŒŒì¼ì„ ì—´ ìˆ˜ ì—†ìŠµë‹ˆë‹¤. ì˜¤ë¥˜ ì½”ë“œ: " & Status
    End If
		
		CreateThumbNail = "sm_" &userFileName&"|vw_" &userFileName
End Function





' ÆÄÀÏ »èÁ¦ ÇÔ¼ö(pageMode°¡ delete ¶Ç´Â modify ÀÏ¶§ ÀÌÀü ÆÄÀÏ »èÁ¦)
Sub delUserFile(dbFileName,dbThuFileName,dbThuviewFileName)
    Dim fsObject
    Set fsObject = CreateObject("Scripting.FileSystemObject")
   
    Dim dbFile, dbThuFile, dbThuViewFile
    dbFile    = saveFileDir & photoFolder & "\" & dbFileName
    dbThuFile = saveFileDir & thumbFolder & "\" & dbThuFileName 
		dbThuViewFile= saveFileDir & viewFolder & "\" & dbThuviewFileName
    
    ' ¿øº» ÀÌ¹ÌÁö »èÁ¦
    if fsObject.FileExists(dbFile)=true then
        fsObject.DeleteFile(dbFile)
    end if
    ' ½æ³×ÀÏ ÀÌ¹ÌÁö »èÁ¦
    if fsObject.FileExists(dbThuFile)=true then
        fsObject.DeleteFile(dbThuFile)
    end if
		
		if fsObject.FileExists(dbThuViewFile)=true then
        fsObject.DeleteFile(dbThuViewFile)
    end if
    
    Set fsObject = Nothing
End Sub


Sub errMsg()
    Response.Write "ÆÄÀÏ ¾÷·Îµå(»èÁ¦) ½ÇÆĞ" & "<br>"
    Response.Write Err.Source & "<br>"
    Response.Write Err.Description & "<br>"
End Sub



   if Err.Number = 0 then
        if not (form.isfile) then   ' Æû¿¡¼­ ³Ñ¾î¿Â °ªÀÌ ÆÄÀÏ or TextÀÎÁö Ã¼Å©
            saveSql = "update "&tableName&" " &_
                      " set subject='"&subject&"', subjectKr='"&subjectKr&"', content='"&content&"', cate='"&cate&"'" &_
                      " where idx=" & idx
        else
            saveFileName = FnSaveUserFile()  ' ÆÄÀÏ ÀúÀå ¹× º¯¼ö¿¡ »õ·Î¿î ÆÄÀÏ¸í ÁöÁ¤.
            thumbNailFile = CreateThumbNail(saveFileName)  ' Thumbnail »ı¼º ¹× ÆÄÀÏ¸í °¡Á®¿È.
						
						thumbNailFile=split(thumbNailFile,"|")
						Dim fnm_01,fnm_02    
										if ubound(thumbNailFile)=1 then
										   fnm_01 = thumbNailFile(0)
										   fnm_02 = thumbNailFile(1)											 
										else
									     fnm_01 = ""
										   fnm_02 = ""			
										end if
										
            if not isEmptyStr(saveFileName) then  ' ¾÷·ÎµåµÇ´Â ÆÄÀÏÀÌ ÀÖ´Â °æ¿ì ±âÁ¸ ÆÄÀÏ »èÁ¦
                Dim getFileName, preGetFile, thumGetFile, thumGetviewFile
                call dbConOpen()
                getFileName = dbCon.Execute("select fileName, thumbNail,viewNail from "&tableName&" where idx="&idx)
                preGetFile  = getFileName(0)
                thumGetFile = getFileName(1)
								thumGetviewFile = getFileName(2)
                call dbConClose()
                call delUserFile(preGetFile,thumGetFile,thumGetviewFile)
            end if

            saveSql = "update "&tableName&" " &_
                      " set subject='"&subject&"',subjectKr=N'"&subjectKr&"', content='"&content&"'," &_
                      " fileName='"&saveFileName&"', fileSize='"&fileSize&"', fileWidth='"&imgWidth&"', fileHeight='"&imgHeight&"', thumbNail='"&fnm_01&"', viewNail='"&fnm_02&"'," &_
                      " modiDate=getDate(), modiIp='"&userIp&"', modiCount=modiCount+1, cate='"&cate&"'" &_
                      " where idx=" & idx
        end if
    else
        call errMsg()
    end if
		
set form = nothing
set upload = nothing

call dbConOpen()
dbCon.execute(saveSql)
call dbConClose()

response.write "<script language=""JavaScript"" type=""text/javascript"">" &_
               "alert('completed.'); parent.location.reload();document.location.href = 'about:blank';" &_
               "</script>"
response.end	
%>
