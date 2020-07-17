<!--METADATA TYPE="typelib"  NAME="ADODB Type Library" File="C:\Program Files\Common Files\System\ado\msado15.dll" -->
<%
Response.CharSet = "utf-8"

Dim dbConString,conn,dbCon,rsExe
dbConString = "file name=D:\DB\account\tryeverything.udl"
Public Sub dbConOpen()
	Set dbCon = Server.CreateObject("ADODB.Connection")
	
	With dbCon
		.ConnectionTimeout	= 20			'연결 시도시 대기 시간
		.CommandTimeout		= 40			'명령 처리시 대기 시간
		.ConnectionString	= dbConString
		.Open
	End With
End Sub

' 페이지내 Global Connection 소멸  ***********************************
Public Sub dbConClose()
	If dbCon.State = adStateOpen Then
		 dbCon.Close()
	End If
	
	if IsObject(dbCon) Then
		Set dbCon = Nothing
	end if
End Sub



Public Sub connOpen()
	Set conn = Server.CreateObject("ADODB.Command")
	conn.ActiveConnection = dbConString
End sub


Public Sub connOpenOnly()
	Set conn = Server.CreateObject("ADODB.Command")
End Sub



Public Sub connClose()   
	If conn.State = adStateOpen Then
		 conn.Close()
	End If
End sub


Function GetRsArray(oRS)
	If (oRS.EOF And oRS.BOF) Then
		GetRsArray = null
	Else
		GetRsArray = oRS.getrows()
	End If
End Function

Function inSql(sql)
    if not isEmptyStr(sql) then
        sql = Replace(sql,";","&#59;")
        sql = Replace(sql,"--","&#45;&#45;")
        sql = Replace(sql,"'","&#39;")
        sql = Replace(sql,"exec(","")
    end if
    inSql = sql
End Function

Function outSql(sql)
    if not isEmptyStr(sql) then
        sql = Replace(sql,"&#59;",";")
        sql = Replace(sql,"&#45;&#45;","--")
        sql = Replace(sql,"&#39;","'")
        sql = Replace(sql,"&#40;","(")
    else
        sql = ""
    end if
    outSql = sql
End Function  



Function outSqlView(sql)
    if not isEmptyStr(sql) then
        sql = outSql(sql)
        sql = Replace(sql,"&", "&amp;" )
        sql = Replace(sql,">", "&gt;" )
        sql = Replace(sql, "<", "&lt;" )
        sql = Replace(sql,"""", "&quot;" )
        sql = Replace(sql,"'", "&#039;" )
    else
        sql = ""
    end if
    outSqlView = sql
End Function  

%>
