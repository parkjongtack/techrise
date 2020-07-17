<% Option Explicit %>
<Object Runat="Server" Progid="ADODB.Connection" Id="dbCon"></Object>
<Object Runat="Server" Progid="ADODB.RecordSet" Id="rs"></Object>
<!-- #include virtual="/common/inc/headNoCache.asp" -->
<!-- #include virtual="/common/inc/func.asp" -->
<!-- #include virtual="/common/inc/dbCon.asp" -->
<!-- #include virtual="/common/inc/base64.asp" -->
<%
' ##############################################################################
' IIS 6.0에서는 ASP 에서 기본 다운로드 버퍼링 용량을 4MB로 제한.
' IIS 기본 설정은 C:\Windows\system32\inetsrv\MetaBase.xml 에 저장 되어 있으며, 
' 위의 메타베이스 XML파일에서 AspBufferingLimit 값을 원하는 사이즈만큼 늘려주면 해결이 가능.
'
' 다운로드제한 : AspBufferingLimit="4194304" - 4MB
' 업로드제한 : AspMaxRequestEntityAllowed="204800" - 200KB
' 서버 파일 수정후 재부팅 필요
'
' 수정일 : 2010. 9. 7
' ##############################################################################
Response.Expires = 0
Response.Buffer = True

Function existFile(fName)
    existFile = False
    Dim filePath
    filePath = fName
    
    Dim fso
    Set fso = CreateObject("Scripting.FileSystemObject")
    If fso.FileExists(filePath)=true Then '
        existFile = True
    End If
    
    Set fso = Nothing
End Function

'response.end
On Error Resume Next
Dim fileName, fileTxt, filePath, fileType,filefold
fileName = base64Decode(request.querystring("fn"))
filefold = request.querystring("fd")


'call getserverInfo()
'select case fileType
'    case 1 : filePath = Request.ServerVariables("APPL_PHYSICAL_PATH") & "\program\upload\textbox\" & fileName
'		case 2 : filePath = Request.ServerVariables("APPL_PHYSICAL_PATH") & "\program\upload\textbook\" & fileName
'    case 3 : filePath = Request.ServerVariables("APPL_PHYSICAL_PATH") & "\program\upload\ptfile\" & fileName
'    case else : filePath = Server.MapPath(".") &"\" & fileName
'end select

filePath = Server.MapPath(".") &"\"&filefold&"\"& fileName

if not existFile(filePath) then
    response.clear()
    'echobr filePath
		Response.write "Sorry, the file you requested was not found"
    resposne.end
else
    if fileName="ICAAP10_MR.mp3" then
		   Call dbConOpen()
			 dbCon.execute("update mp3Down set downNum=downNum+1")
			 Call dbConClose()
		
		end if
    Response.Clear
    Response.ContentType =  "application/unknown"
    Response.CacheControl = "public"
    'Response.AddHeader "Content-Disposition", "attachment;filename=" & fileTxt
		Response.AddHeader "Content-Disposition", "attachment;filename=" & fileName
    
    ' Stream 이용 ------------------------------------------------------------------
    Dim Stream
    set Stream=Server.CreateObject("ADODB.Stream")
    Stream.Open
    Stream.Type=1
    'echobr filepath
		'response.end
    Stream.LoadFromFile filepath
    Response.BinaryWrite Stream.Read
    Stream.close
    set Stream=nothing
    ' ------------------------------------------------------------------------------

end if
' 사이트갤럭시를 이용하여 다운로드하기 -----------------------------------------
'set fso = server.CreateObject("SiteGalaxyUpload.FileSystemObject")
'set file = fso.OpenBinaryFile (filepath,1,false) 
'Response.BinaryWrite file.ReadAll  
'    
'Set file = Nothing
'Set fso = Nothing
' ------------------------------------------------------------------------------
%>