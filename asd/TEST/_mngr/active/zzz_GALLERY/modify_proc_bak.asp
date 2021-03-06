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


Upload.CodePage = 65001   ' UTF-8 유니코드 작성
Upload.start tmpSaveDir', False     ' 파일의 속성을 알기 위해 임시폴더에 업로드

Dim form : Set form = Upload.Form("userFile")

Dim bcate_F
bcate_F = trim(Upload.Form("bcate_F"))

if not form.isFile then   ' 폼에서 넘어온 값이 파일 or Text인지 체크
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
    

    mimeType  = Lcase(form.contentType)    ' 파일 형식
    fileType  = Lcase(form.fileType)       ' 파일의 확장명
    fileName  = form.fileName       ' 파일명
    fileSize  = form.fileSize       ' 파일 용량
    

    ' 허용 파일 체크 ---------------------------------------------------------------
    if not inArray(allowMimeType, mimeType) or not inArray(allowFileType, fileType) then
        Call Alert("File Type Error", -1)
        response.end
    end if
    
    if fileSize>maxImageSize then
        Call Alert("File Size Error. Maximum size to "&formatNumber(maxImageSize/1024)&"Kbyte.", -1)
        response.end
    end if
    ' ------------------------------------------------------------------------------
    
    
    
    ' 저장될 썸네일 이미지 크기 지정 -----------------------------------------------
    
    imgWidth  = form.imageWidth     ' 이미지 폭
    imgHeight = form.imageHeight    ' 이미지 높이
    
   
    if imgWidth>=pvLiImgWidth or imgHeight>=pvLiImgHeight then
        if imgWidth>=imgHeight then
            thumbWidth  = pvLiImgWidth
            thumbHeight = imgHeight / formatNumber((imgWidth/pvLiImgWidth),2)
            thumbHeight = Clng(thumbHeight)
            if thumbHeight>pvLiImgHeight then   ' 높이가 기본값보다 클 경우
                thumbHeight = pvLiImgHeight
            end if
        elseif imgWidth<imgHeight then
            thumbHeight = pvLiImgHeight
            thumbWidth  = imgWidth / formatNumber((imgHeight/pvLiImgHeight),2)
            thumbWidth = Clng(thumbWidth)
            if thumbWidth>pvLiImgWidth then   ' 폭이 기본값보다 클 경우
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
            if viewHeight>viewImgHeight then   ' 높이가 기본값보다 클 경우
                viewHeight = viewImgHeight
            end if
        elseif imgWidth<imgHeight then
            viewHeight = viewImgHeight
            viewWidth  = imgWidth / formatNumber((imgHeight/viewImgHeight),2)
            viewWidth = Clng(viewWidth)
            if viewWidth>viewImgWidth then   ' 폭이 기본값보다 클 경우
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



' 업로드 파일 저장 함수. -------------------------------------------------------
function FnSaveUserFile()
    '업로드된 파일을 저장
    Upload.Save saveFileDir & photoFolder, false  ' 중복시 파일명 자동 변경
    
    Dim fso, MyFile
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    ' FileSystem Object 를 이용 저장된 파일명을 변경.
    Dim saveFilePath, saveFileName, newFileName
    saveFilePath = saveFileDir & photoFolder & "\"
    saveFileName = form.shortSaveName

    newFileName  = Year(now)&Calc(Month(now),2)&Calc(Day(now),2)&Calc(Hour(now),2)&Calc(Minute(now),2)&Calc(Second(now),2)&"." & fileType

    if fso.FileExists(newFileName)=true then ' 중복 파일명 검사
        randomize
        newFileName = Year(now)&Calc(Month(now),2)&Calc(Day(now),2)&Calc(Hour(now),2)&Calc(Minute(now),2)&Calc(Second(now),2)&"_"&Calc(int(rnd*100),3)&"." & fileType
    end if
    ' 실제 저장될 파일명 : newFileName
    
    ' 저장된 파일명 교체
  '  echobr saveFilePath&saveFileName&"<br>"
'    echobr saveFilePath&newFileName
'    response.end
    
    fso.MoveFile saveFilePath&saveFileName, saveFilePath&newFileName
    set fso = nothing
    
    FnSaveUserFile = newFileName  ' DB에 저장될 파일명을 반환함.
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
        Response.Write "�씠誘몄�� �뙆�씪�쓣 �뿴 �닔 �뾾�뒿�땲�떎. �삤瑜� 肄붾뱶: " & Status
    End If
		
		CreateThumbNail = "sm_" &userFileName&"|vw_" &userFileName
End Function





' 파일 삭제 함수(pageMode가 delete 또는 modify 일때 이전 파일 삭제)
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


Sub errMsg()
    Response.Write "파일 업로드(삭제) 실패" & "<br>"
    Response.Write Err.Source & "<br>"
    Response.Write Err.Description & "<br>"
End Sub



   if Err.Number = 0 then
        if not (form.isfile) then   ' 폼에서 넘어온 값이 파일 or Text인지 체크
            saveSql = "update "&tableName&" " &_
                      " set subject='"&subject&"', subjectKr='"&subjectKr&"', content='"&content&"', cate='"&cate&"'" &_
                      " where idx=" & idx
        else
            saveFileName = FnSaveUserFile()  ' 파일 저장 및 변수에 새로운 파일명 지정.
            thumbNailFile = CreateThumbNail(saveFileName)  ' Thumbnail 생성 및 파일명 가져옴.
						
						thumbNailFile=split(thumbNailFile,"|")
						Dim fnm_01,fnm_02    
										if ubound(thumbNailFile)=1 then
										   fnm_01 = thumbNailFile(0)
										   fnm_02 = thumbNailFile(1)											 
										else
									     fnm_01 = ""
										   fnm_02 = ""			
										end if
										
            if not isEmptyStr(saveFileName) then  ' 업로드되는 파일이 있는 경우 기존 파일 삭제
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
