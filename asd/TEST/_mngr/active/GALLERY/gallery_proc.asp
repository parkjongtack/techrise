<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %>
<% Option Explicit %>
<%Response.CharSet = "utf-8"%>
<object Runat="Server" Progid="ADODB.Connection" id="dbCon"></object>
<object Runat="Server" Progid="ADODB.RecordSet" id="rs"></object>
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<!-- #include virtual="/common/inc/base64.asp" -->
<!-- #include virtual="/common/inc/dbCon.asp" -->
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<!-- #include virtual="/_mngr/active/GALLERY/gallery_config_inc.asp" -->
<%
'On Error Resume next

call isAdminChk_iframe(5)
Server.ScriptTimeOut = 10000


Dim Upload : Set Upload = Server.CreateObject("TABS.Upload")

Upload.ProgressID = Request.QueryString("progressid")


Upload.CodePage = 65001   ' UTF-8 À¯´ÏÄÚµå ÀÛ¼º
Upload.start tmpSaveDir', False     ' ÆÄÀÏÀÇ ¼Ó¼ºÀ» ¾Ë±â À§ÇØ ÀÓ½ÃÆú´õ¿¡ ¾÷·Îµå
'¾÷·ÎµåµÈ ÆÄÀÏÀ» µğ½ºÅ©¿¡ ÀúÀå(Overwrite)
'Upload.Save , false'True




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


Dim sY,sM,sD,view_date,b_langCheck
sY								= inSql(trim(Upload.form("sY")))
sM								= inSql(trim(Upload.form("sM")))
sD								= inSql(trim(Upload.form("sD")))
b_langCheck				= inSql(trim(Upload.form("b_langCheck")))
		
view_date = sY&"-"&sM&"-"&sD



Dim typeError,sizeError,typeChk,sizeChk
typeError = 0
sizeError = 0
Dim subForm,mimeType, fileType, fileName, fileSize
Dim saveFileName, thumbNailFile, saveSql, returnUrl,thumbViewFile
Dim imgWidth, imgHeight
Dim thumbWidth, thumbHeight
Dim viewWidth, viewHeight


for i=1 to Upload.Form("userFile").count

    set subForm = Upload.Form("userFile")(i)
        mimeType  = Lcase(subForm.contentType)    ' ÆÄÀÏ Çü½Ä
        fileType  = Lcase(subForm.fileType)       ' ÆÄÀÏÀÇ È®Àå¸í
        fileName  = subForm.fileName       ' ÆÄÀÏ¸í
        fileSize  = subForm.fileSize       ' ÆÄÀÏ ¿ë·®
        
        typeChk = "Y"
        sizeChk = "Y" 
       
			 
			  if subForm.isFile then
            
            
            ' Çã¿ë ÆÄÀÏ Ã¼Å© ---------------------------------------------------------------
            if not inArray(allowMimeType, mimeType) or not inArray(allowFileType, fileType) then
                typeError=typeError+1
                typeChk="N"
            end if
            
            if fileSize>maxImageSize then
                sizeError=sizeError+1
                sizeChk="N"
            end if
            
            if typeChk="Y" and sizeChk="Y" then
            
            
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
                ' ------------------------------------------------------------------------------
                
                
                if Err.Number = 0 then
                    saveFileName = FnSaveUserFile()  ' ÆÄÀÏ ÀúÀå ¹× º¯¼ö¿¡ »õ·Î¿î ÆÄÀÏ¸í ÁöÁ¤.
                    
                    
                    thumbNailFile = CreateThumbNail(saveFileName)  ' Thumbnail »ı¼º ¹× ÆÄÀÏ¸í °¡Á®¿È.
            				thumbViewFile = CreateViewNail(saveFileName)  ' Thumbnail »ı¼º ¹× ÆÄÀÏ¸í °¡Á®¿È.
                    saveSql = "insert into TB_gallery " &_
                              "(writer, subject,subjectKr, content, fileName, fileSize, fileWidth, fileHeight, thumbNail, viewNail, regDate, regIp, cate, view_date, b_langCheck)" &_
                              " values (N'"&writer&"', N'"&subject&"',N'"&subjectKr&"', N'"&content&"', '"&saveFileName&"', '"&fileSize&"', '"&imgWidth&"', '"&imgHeight&"', '"&thumbNailFile&"','"&thumbViewFile&"', getDate(),'"&userIp&"', '"&cate&"', '"&view_date&"', '"&b_langCheck&"')"
            				
									
										 'returnUrl = "?pageMode=write&cate="&cate&"&bcate="&bcate_F
                     returnUrl = "?pageMode=list&cate="&cate&"&bcate="&bcate_F
            				
                    
                    
                    call dbConOpen()
                    dbCon.execute(saveSql)
                    call dbConClose()

                else
                    call errMsg()
                end if
            
            end if
            
            ' ------------------------------------------------------------------------------
        
        end if
    set subForm = nothing

next   






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
    Dim thumbImg
    Set thumbImg = Server.CreateObject("Persits.Jpeg")
    thumbImg.Open(saveFileDir&photoFolder&"\"&userFileName)  ' ÀúÀåµÈ ¿øº» ÀÌ¹ÌÁö À§Ä¡
    thumbImg.Width = thumbWidth
    thumbImg.Height = thumbHeight
    
    thumbImg.Sharpen 1, 150  ' Must be > 100
    thumbImg.Quality = 100 ' (Low) 0 ~ 100 (Hight)
		
		'echobr saveFileDir & thumbFolder & "\sm_" &userFileName
    
    ' ½æ³×ÀÏ ÀÌ¹ÌÁö ÀúÀå
    thumbImg.Save saveFileDir & thumbFolder & "\sm_" &userFileName
		
    
    Set thumbImg = Nothing
    CreateThumbNail = "sm_" &userFileName
End Function





Function CreateViewNail(userFileName)
    Dim viewImg
    Set viewImg = Server.CreateObject("Persits.Jpeg")
    viewImg.Open(saveFileDir&photoFolder&"\"&userFileName)  ' ÀúÀåµÈ ¿øº» ÀÌ¹ÌÁö À§Ä¡
    viewImg.Width = viewWidth
    viewImg.Height = viewHeight
    
    viewImg.Sharpen 1, 150  ' Must be > 100
    viewImg.Quality = 100 ' (Low) 0 ~ 100 (Hight)
		
    ' º»¹® ÀÌ¹ÌÁö ÀúÀå
    viewImg.Save saveFileDir & viewFolder & "\vw_" &userFileName
		
    
    Set viewImg = Nothing
    CreateViewNail = "vw_" &userFileName
End Function



Dim errorMsg
if typeError>0  then
   errorMsg="íŒŒì¼ íƒ€ì…ì˜¤ë¥˜ : "&typeError&" ê±´"
end if

response.write "<script language=""JavaScript"" type=""text/javascript"">" &_
               "alert('completed.'); parent.location.reload();document.location.href = 'about:blank';" &_
               "</script>"

Dim gosMenu
gosMenu = "00"

response.write "<script language=""JavaScript"" type=""text/javascript"">" &_
               "alert('completed.'); parent.location.href='/_mngr/?menuIdx=1&sMenu="&gosMenu&"&schCate="&cate&"';document.location.href = 'about:blank';" &_
               "</script>"							 
 							 
							 
response.end

%>