<% Option Explicit %>
<Object Runat="Server" Progid="ADODB.Connection" Id="dbCon"></Object>
<Object Runat="Server" Progid="ADODB.RecordSet" Id="rs"></Object>
<!-- #include virtual="/common/inc/headNoCache.asp" -->
<!-- #include virtual="/common/inc/func.asp" -->
<!-- #include virtual="/common/inc/dbCon.asp" -->
<!-- #include virtual="/common/inc/base64.asp" -->
<%
' ##############################################################################
' IIS 6.0������ ASP ���� �⺻ �ٿ�ε� ���۸� �뷮�� 4MB�� ����.
' IIS �⺻ ������ C:\Windows\system32\inetsrv\MetaBase.xml �� ���� �Ǿ� ������, 
' ���� ��Ÿ���̽� XML���Ͽ��� AspBufferingLimit ���� ���ϴ� �����ŭ �÷��ָ� �ذ��� ����.
'
' �ٿ�ε����� : AspBufferingLimit="4194304" - 4MB
' ���ε����� : AspMaxRequestEntityAllowed="204800" - 200KB
' ���� ���� ������ ����� �ʿ�
'
' ������ : 2010. 9. 7
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
    
    ' Stream �̿� ------------------------------------------------------------------
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
' ����Ʈ�����ø� �̿��Ͽ� �ٿ�ε��ϱ� -----------------------------------------
'set fso = server.CreateObject("SiteGalaxyUpload.FileSystemObject")
'set file = fso.OpenBinaryFile (filepath,1,false) 
'Response.BinaryWrite file.ReadAll  
'    
'Set file = Nothing
'Set fso = Nothing
' ------------------------------------------------------------------------------
%>