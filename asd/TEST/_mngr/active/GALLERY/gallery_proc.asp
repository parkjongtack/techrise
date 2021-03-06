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


Upload.CodePage = 65001   ' UTF-8 유니코드 작성
Upload.start tmpSaveDir', False     ' 파일의 속성을 알기 위해 임시폴더에 업로드
'업로드된 파일을 디스크에 저장(Overwrite)
'Upload.Save , false'True




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
        mimeType  = Lcase(subForm.contentType)    ' 파일 형식
        fileType  = Lcase(subForm.fileType)       ' 파일의 확장명
        fileName  = subForm.fileName       ' 파일명
        fileSize  = subForm.fileSize       ' 파일 용량
        
        typeChk = "Y"
        sizeChk = "Y" 
       
			 
			  if subForm.isFile then
            
            
            ' 허용 파일 체크 ---------------------------------------------------------------
            if not inArray(allowMimeType, mimeType) or not inArray(allowFileType, fileType) then
                typeError=typeError+1
                typeChk="N"
            end if
            
            if fileSize>maxImageSize then
                sizeError=sizeError+1
                sizeChk="N"
            end if
            
            if typeChk="Y" and sizeChk="Y" then
            
            
                ' 저장될 썸네일 이미지 크기 지정 -----------------------------------------------
                
                
                imgWidth  = subForm.imageWidth     ' 이미지 폭
                imgHeight = subForm.imageHeight    ' 이미지 높이
                
                
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
                
                
                if Err.Number = 0 then
                    saveFileName = FnSaveUserFile()  ' 파일 저장 및 변수에 새로운 파일명 지정.
                    
                    
                    thumbNailFile = CreateThumbNail(saveFileName)  ' Thumbnail 생성 및 파일명 가져옴.
            				thumbViewFile = CreateViewNail(saveFileName)  ' Thumbnail 생성 및 파일명 가져옴.
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
    '업로드된 파일을 저장
    Upload.Save saveFileDir & photoFolder, false  ' 중복시 파일명 자동 변경
    
    Dim fso, MyFile
    Set fso = CreateObject("Scripting.FileSystemObject")
    
    ' FileSystem Object 를 이용 저장된 파일명을 변경.
    Dim saveFilePath, saveFileName, newFileName
    saveFilePath = saveFileDir & photoFolder & "\"
    saveFileName = subForm.shortSaveName

    newFileName  = Year(now)&Calc(Month(now),2)&Calc(Day(now),2)&Calc(Hour(now),2)&Calc(Minute(now),2)&Calc(Second(now),2)
    Randomize
    newFileName = newFileName&"_"&calc(CLng(Rnd*100000) + 1 , 5)
    newFileName  =newFileName &"." & fileType
    
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
    Dim thumbImg
    Set thumbImg = Server.CreateObject("Persits.Jpeg")
    thumbImg.Open(saveFileDir&photoFolder&"\"&userFileName)  ' 저장된 원본 이미지 위치
    thumbImg.Width = thumbWidth
    thumbImg.Height = thumbHeight
    
    thumbImg.Sharpen 1, 150  ' Must be > 100
    thumbImg.Quality = 100 ' (Low) 0 ~ 100 (Hight)
		
		'echobr saveFileDir & thumbFolder & "\sm_" &userFileName
    
    ' 썸네일 이미지 저장
    thumbImg.Save saveFileDir & thumbFolder & "\sm_" &userFileName
		
    
    Set thumbImg = Nothing
    CreateThumbNail = "sm_" &userFileName
End Function





Function CreateViewNail(userFileName)
    Dim viewImg
    Set viewImg = Server.CreateObject("Persits.Jpeg")
    viewImg.Open(saveFileDir&photoFolder&"\"&userFileName)  ' 저장된 원본 이미지 위치
    viewImg.Width = viewWidth
    viewImg.Height = viewHeight
    
    viewImg.Sharpen 1, 150  ' Must be > 100
    viewImg.Quality = 100 ' (Low) 0 ~ 100 (Hight)
		
    ' 본문 이미지 저장
    viewImg.Save saveFileDir & viewFolder & "\vw_" &userFileName
		
    
    Set viewImg = Nothing
    CreateViewNail = "vw_" &userFileName
End Function



Dim errorMsg
if typeError>0  then
   errorMsg="�뙆�씪 ����엯�삤瑜� : "&typeError&" 嫄�"
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