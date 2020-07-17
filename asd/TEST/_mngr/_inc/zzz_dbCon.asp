<%

'On Error Resume Next
Dim dbCon, strConnect
Set dbCon = Server.CreateObject("ADODB.Connection")
strConnect = "file name=D:\DB\account\istu.udl"

' ------------------------------------------------------------------------------
' dbConOpen(), dbConClose() ' DB Connection �� ���� �ݴ´�.
' ------------------------------------------------------------------------------
Sub dbConOpen()
  	if dbcon.State = 0 then     ' Connection�� ���������� ����.
  		  dbcon.Open strConnect
  	end if
End Sub

Sub dbConClose()
  	if rs.State = 1 then        ' RecordSet�� ���������� �ݴ´�.
  	  	rs.Close
  	end if
  	if dbCon.State = 1 then     ' Connection�� ���������� �ݴ´�.
  		  dbCon.Close
  	end if
End Sub


' ------------------------------------------------------------------------------
' Sql Injection
' inSqlInjection(sql) : inPut
' outSqlInjection(sql) : outPut
' ------------------------------------------------------------------------------
Function inSqlInjection(sql)
    if not isEmptyStr(sql) then
        sql = Replace(sql,";","&#59;")
        sql = Replace(sql,"--","&#45;&#45;")
        sql = Replace(sql,"'","&#39;")
        sql = Replace(sql,"exec(","")
    else
        sql = ""
    end if
    inSqlInjection = sql
End Function

Function outSqlInjection(sql)
    if not isEmptyStr(sql) then
        sql = Replace(sql,"&#59;",";")
        sql = Replace(sql,"&#45;&#45;","--")
        sql = Replace(sql,"&#39;","'")
    else
        sql = ""
    end if
    outSqlInjection = sql
End Function


' ------------------------------------------------------------------------------
' �⺻ ���� ����(record set ����)
' ------------------------------------------------------------------------------
Function query(sqlStr)
  	'On Error Resume Next
  	if dbcon.state = 0 then      ' Connection ���������� ����.
  		  dbcon.open strConnect
  	end if
    if rs.state = 1 then
        rs.close
    end if
    
    rs.cursorType = 1
    rs.open sqlStr,dbCon
    
    if rs.eof then
        query = ""
    else
         query = rs(0)
    end if
    rs.close
End Function




%>
