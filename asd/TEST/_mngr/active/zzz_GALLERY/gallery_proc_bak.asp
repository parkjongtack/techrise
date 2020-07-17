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
On Error Resume next

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

Dim fnm_01,fnm_02                
FOR i=1 to Upload.Form("userFile").count
    set subForm = Upload.Form("userFile")(i)
        mimeType  = Lcase(subForm.contentType)    ' ÆÄÀÏ Çü½Ä
        fileType  = Lcase(subForm.fileType)       ' ÆÄÀÏÀÇ È®Àå¸í
        fileName  = subForm.fileName       ' ÆÄÀÏ¸í
        fileSize  = subForm.fileSize       ' ÆÄÀÏ ¿ë·®
        
        typeChk = "Y"
        sizeChk = "Y" 
				
				IF subForm.isFile THEN
				
				    ' Çã¿ë ÆÄÀÏ Ã¼Å© ---------------------------------------------------------------
            if not inArray(allowMimeType, mimeType) or not inArray(allowFileType, fileType) then
                typeError=typeError+1
                typeChk="N"
            end if
            
            if fileSize>maxImageSize then
                sizeError=sizeError+1
                sizeChk="N"
            end if
						
						If typeChk="Y" and sizeChk="Y" Then
						    
								
                ' ÀúÀåµÉ ½æ³×ÀÏ ÀÌ¹ÌÁö Å©±â ÁöÁ¤ -----------------------------------------------
                
                
                imgWidth  = subForm.imageWidth     ' ÀÌ¹ÌÁö Æø
                imgHeight = subForm.imageHeight    ' ÀÌ¹ÌÁö ³ôÀÌ
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
								
								
								if Err.Number = 0 then
                    saveFileName = FnSaveUserFile()  ' ÆÄÀÏ ÀúÀå ¹× º¯¼ö¿¡ »õ·Î¿î ÆÄÀÏ¸í ÁöÁ¤.
                    
                    
                    
										thumbNailFile = CreateThumbNail(saveFileName)  ' Thumbnail »ı¼º ¹× ÆÄÀÏ¸í °¡Á®¿È.
										
										 
										thumbNailFile=split(thumbNailFile,"|")
										if ubound(thumbNailFile)=1 then
										   fnm_01 = thumbNailFile(0)
										   fnm_02 = thumbNailFile(1)											 
										else
									     fnm_01 = ""
										   fnm_02 = ""			
										end if
										
									
            				saveSql = "insert into "&tableName&" " &_
                              "(writer, subject,subjectKr, content, fileName, fileSize, fileWidth, fileHeight, thumbNail, viewNail, regDate, regIp, cate)" &_
                              " values (N'"&writer&"', N'"&subject&"',N'"&subjectKr&"', N'"&content&"', '"&saveFileName&"', '"&fileSize&"', '"&imgWidth&"', '"&imgHeight&"', '"&fnm_01&"','"&fnm_02&"', getDate(),'"&userIp&"', '"&cate&"')"
            				call dbConOpen()
                    dbCon.execute(saveSql)
                    call dbConClose()
                    


                else
                    call errMsg()
                end if
						
						End If
				
				END IF
				
    set subForm = nothing
NEXT    




Sub errMsg()
    Response.Write "Error" & "<br>"
    Response.Write Err.Source & "<br>"
    Response.Write Err.Description & "<br>"
End Sub


function FnSaveUserFile()
    '¾÷·ÎµåµÈ ÆÄÀÏÀ» ÀúÀå
    Upload.Save saveFileDir & photoFolder, false  ' Áßº¹½Ã ÆÄÀÏ¸í ÀÚµ¿ º¯°æ
    
    Dim fso, MyFile
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    ' FileSystem Object ¸¦ ÀÌ¿ë ÀúÀåµÈ ÆÄÀÏ¸íÀ» º¯°æ.
    Dim saveFilePath, saveFileName, newFileName
    saveFilePath = saveFileDir & photoFolder & "\"
		

		
    saveFileName = subForm.shortSaveName

    newFileName  = Year(now)&Calc(Month(now),2)&Calc(Day(now),2)&Calc(Hour(now),2)&Calc(Minute(now),2)&Calc(Second(now),2)
    Randomize
    newFileName = newFileName&"_"&calc(CLng(Rnd*100000) + 1 , 5)
    newFileName  =newFileName &"." & fileType
    
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






Dim errorMsg
if typeError>0  then
   errorMsg="íŒŒì¼ íƒ€ì…ì˜¤ë¥˜ : "&typeError&" ê±´"
end if

response.write "<script language=""JavaScript"" type=""text/javascript"">" &_
               "alert('completed.'); parent.location.reload();document.location.href = 'about:blank';" &_
               "</script>"
response.end	
%>
