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


Upload.CodePage = 65001   ' UTF-8 �����ڵ� �ۼ�
Upload.start tmpSaveDir', False     ' ������ �Ӽ��� �˱� ���� �ӽ������� ���ε�

Dim form : Set form = Upload.Form("userFile")

Dim bcate_F
bcate_F = trim(Upload.Form("bcate_F"))

if not form.isFile then   ' ������ �Ѿ�� ���� ���� or Text���� üũ
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
    

    mimeType  = Lcase(form.contentType)    ' ���� ����
    fileType  = Lcase(form.fileType)       ' ������ Ȯ���
    fileName  = form.fileName       ' ���ϸ�
    fileSize  = form.fileSize       ' ���� �뷮
    

    ' ��� ���� üũ ---------------------------------------------------------------
    if not inArray(allowMimeType, mimeType) or not inArray(allowFileType, fileType) then
        Call Alert("File Type Error", -1)
        response.end
    end if
    
    if fileSize>maxImageSize then
        Call Alert("File Size Error. Maximum size to "&formatNumber(maxImageSize/1024)&"Kbyte.", -1)
        response.end
    end if
    ' ------------------------------------------------------------------------------
    
    
    
    ' ����� ����� �̹��� ũ�� ���� -----------------------------------------------
    
    imgWidth  = form.imageWidth     ' �̹��� ��
    imgHeight = form.imageHeight    ' �̹��� ����
    
   
    if imgWidth>=pvLiImgWidth or imgHeight>=pvLiImgHeight then
        if imgWidth>=imgHeight then
            thumbWidth  = pvLiImgWidth
            thumbHeight = imgHeight / formatNumber((imgWidth/pvLiImgWidth),2)
            thumbHeight = Clng(thumbHeight)
            if thumbHeight>pvLiImgHeight then   ' ���̰� �⺻������ Ŭ ���
                thumbHeight = pvLiImgHeight
            end if
        elseif imgWidth<imgHeight then
            thumbHeight = pvLiImgHeight
            thumbWidth  = imgWidth / formatNumber((imgHeight/pvLiImgHeight),2)
            thumbWidth = Clng(thumbWidth)
            if thumbWidth>pvLiImgWidth then   ' ���� �⺻������ Ŭ ���
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
            if viewHeight>viewImgHeight then   ' ���̰� �⺻������ Ŭ ���
                viewHeight = viewImgHeight
            end if
        elseif imgWidth<imgHeight then
            viewHeight = viewImgHeight
            viewWidth  = imgWidth / formatNumber((imgHeight/viewImgHeight),2)
            viewWidth = Clng(viewWidth)
            if viewWidth>viewImgWidth then   ' ���� �⺻������ Ŭ ���
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



' ���ε� ���� ���� �Լ�. -------------------------------------------------------
function FnSaveUserFile()
    '���ε�� ������ ����
    Upload.Save saveFileDir & photoFolder, false  ' �ߺ��� ���ϸ� �ڵ� ����
    
    Dim fso, MyFile
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    ' FileSystem Object �� �̿� ����� ���ϸ��� ����.
    Dim saveFilePath, saveFileName, newFileName
    saveFilePath = saveFileDir & photoFolder & "\"
    saveFileName = form.shortSaveName

    newFileName  = Year(now)&Calc(Month(now),2)&Calc(Day(now),2)&Calc(Hour(now),2)&Calc(Minute(now),2)&Calc(Second(now),2)&"." & fileType

    if fso.FileExists(newFileName)=true then ' �ߺ� ���ϸ� �˻�
        randomize
        newFileName = Year(now)&Calc(Month(now),2)&Calc(Day(now),2)&Calc(Hour(now),2)&Calc(Minute(now),2)&Calc(Second(now),2)&"_"&Calc(int(rnd*100),3)&"." & fileType
    end if
    ' ���� ����� ���ϸ� : newFileName
    
    ' ����� ���ϸ� ��ü
  '  echobr saveFilePath&saveFileName&"<br>"
'    echobr saveFilePath&newFileName
'    response.end
    
    fso.MoveFile saveFilePath&saveFileName, saveFilePath&newFileName
    set fso = nothing
    
    FnSaveUserFile = newFileName  ' DB�� ����� ���ϸ��� ��ȯ��.
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
        Response.Write "이미지 파일을 열 수 없습니다. 오류 코드: " & Status
    End If
		
		CreateThumbNail = "sm_" &userFileName&"|vw_" &userFileName
End Function





' ���� ���� �Լ�(pageMode�� delete �Ǵ� modify �϶� ���� ���� ����)
Sub delUserFile(dbFileName,dbThuFileName,dbThuviewFileName)
    Dim fsObject
    Set fsObject = CreateObject("Scripting.FileSystemObject")
   
    Dim dbFile, dbThuFile, dbThuViewFile
    dbFile    = saveFileDir & photoFolder & "\" & dbFileName
    dbThuFile = saveFileDir & thumbFolder & "\" & dbThuFileName 
		dbThuViewFile= saveFileDir & viewFolder & "\" & dbThuviewFileName
    
    ' ���� �̹��� ����
    if fsObject.FileExists(dbFile)=true then
        fsObject.DeleteFile(dbFile)
    end if
    ' ����� �̹��� ����
    if fsObject.FileExists(dbThuFile)=true then
        fsObject.DeleteFile(dbThuFile)
    end if
		
		if fsObject.FileExists(dbThuViewFile)=true then
        fsObject.DeleteFile(dbThuViewFile)
    end if
    
    Set fsObject = Nothing
End Sub


Sub errMsg()
    Response.Write "���� ���ε�(����) ����" & "<br>"
    Response.Write Err.Source & "<br>"
    Response.Write Err.Description & "<br>"
End Sub



   if Err.Number = 0 then
        if not (form.isfile) then   ' ������ �Ѿ�� ���� ���� or Text���� üũ
            saveSql = "update "&tableName&" " &_
                      " set subject='"&subject&"', subjectKr='"&subjectKr&"', content='"&content&"', cate='"&cate&"'" &_
                      " where idx=" & idx
        else
            saveFileName = FnSaveUserFile()  ' ���� ���� �� ������ ���ο� ���ϸ� ����.
            thumbNailFile = CreateThumbNail(saveFileName)  ' Thumbnail ���� �� ���ϸ� ������.
						
						thumbNailFile=split(thumbNailFile,"|")
						Dim fnm_01,fnm_02    
										if ubound(thumbNailFile)=1 then
										   fnm_01 = thumbNailFile(0)
										   fnm_02 = thumbNailFile(1)											 
										else
									     fnm_01 = ""
										   fnm_02 = ""			
										end if
										
            if not isEmptyStr(saveFileName) then  ' ���ε�Ǵ� ������ �ִ� ��� ���� ���� ����
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
