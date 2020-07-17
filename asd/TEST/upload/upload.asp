<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %>
<%
Option Explicit
Response.CharSet = "utf-8"
%>
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<%
Server.ScriptTimeout = 1200

Dim CKEditorFuncNum : CKEditorFuncNum =request("CKEditorFuncNum")



Const tmpSaveDir      = "D:\TEMP"  ' 임시 저장 폴더

Dim saveFileDir    
saveFileDir    = Request.ServerVariables("APPL_PHYSICAL_PATH")&"upload\editor_img\"   
    

Dim Upload
Set Upload = Server.CreateObject("TABS.Upload")
Upload.CodePage = 65001   ' UTF-8 유니코드 작성

'업로드를 시작합니다.
Upload.Start tmpSaveDir, False



Dim retrunTxt
Dim picFileName


Function changeFileName(fName, nfName)
    If isEmptyStr(fName) Then
        Exit Function
    End If
    Dim fso, newFileName, fileType,filePath
    Set fso = CreateObject("Scripting.FileSystemObject")
    If fso.FileExists(fName)=true Then ' 파일이 있으면
		    newFileName = nfName
				filePath = saveFileDir&newFileName
    		If fso.FileExists(filePath)=true Then 
            fso.DeleteFile(filePath)
        End If
    End If
    
    ' 저장된 원본 파일명을 새로운 파일명으로 교체
    fso.MoveFile fName, saveFileDir&newFileName
    Set fso = Nothing
    changeFileName = newFileName
End Function




Dim saveDir
If Not IsEmptyStr(Upload.Form("upload")) Then
    If Upload.Form("upload").FileSize <> 0 Then
      	
				Upload.Form("upload").Save saveDir, False ' 파일명 자동 변경
				
        Dim ps_picNmOr, ps_picNmSv, ps_picNmSvFile, ps_picSize, ps_picType
        ps_picNmOr = Upload.Form("upload").FileName
        ps_picNmSv = Upload.Form("upload").SaveName
        ps_picNmSvFile = Mid(ps_picNmSv,InStrRev(ps_picNmSv,"\")+1, Len(ps_picNmSv))
        ps_picSize = Upload.Form("upload").FileSize
        ps_picType = Upload.Form("upload").FileType
				if lcase(ps_picType)<>"jpg" and lcase(ps_picType)<>"gif" and lcase(ps_picType)<>"png" then
				    response.write  "<script type='text/javascript'>alert('file format : jpg,gif,png.');</script>"
				elseif  ps_picSize>10485760 then
						response.write = "<script type='text/javascript'>alert('Error: File size is too big. \n\n"&FormatNumber(ps_picSize/1024/1024,2)&"MB > "&FormatNumber(10485760/1024/1024,2)&" MB\n\n');</script>"
				else		
				    picFileName = changeFileName(ps_picNmSv,Year(now) & calc(Month(now),2) & calc(Day(now),2) & calc(Hour(now),2) & calc(Minute(now),2) & calc(Second(now),2) &"_"&ps_picNmOr)
						
						response.write  "<script type='text/javascript'>alert('Completed.');</script>"
        end if
    End If
Else
    response.write  "<script type='text/javascript'>alert('Error: File size is none');</script>"
End If
' ==============================================================================
Set Upload = Nothing
if request.ServerVariables("HTTPS")<>"on" then
response.write "<script type='text/javascript'> window.parent.CKEDITOR.tools.callFunction("&CKEditorFuncNum&", 'http://"&request.servervariables("HTTP_HOST")&"/upload/editor_img/"&picFileName&"');</script>"
else
response.write "<script type='text/javascript'> window.parent.CKEDITOR.tools.callFunction("&CKEditorFuncNum&", 'https://"&request.servervariables("HTTP_HOST")&"/upload/editor_img/"&picFileName&"');</script>"
end if
%>
