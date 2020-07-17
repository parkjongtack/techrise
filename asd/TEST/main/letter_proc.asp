<!-- #include virtual="/common/inc/site_config_inc.asp" -->
<!-- #include virtual="/common/inc/base64.asp" -->
<%
Response.CharSet = "utf-8"
'response.end
' 로그인 정보 ------------------------------------------------------------------

On Error Resume Next
Dim errCnt : errCnt = 0  

Dim s_email,cate,userip
s_email      = inSqlInjection(Trim(request.form("s_email")))
cate      = inSqlInjection(Trim(request.form("cate")))

userip      = request.ServerVariables("REMOTE_ADDR")
' ---------------------------------------

if isEmptyStr(s_email) or isEmptyStr(cate) then
    response.Clear
    response.write "NO_VALUE"
    response.end
end if 

Dim sCnt
Call connOpen()
    With conn     
        	.CommandText = "select count(idx) from wantNewsLetter where cate = ?  and email = ? and actStatus='Y'"
        	.CommandType = adCmdText
       	  .Parameters.Append .CreateParameter("@cate",	               adVarWChar, 	        adParamInput, 50,	cate)
      		.Parameters.Append .CreateParameter("@s_email",	             adVarWChar, 		 			adParamInput, 200,	s_email)
					 set rsExe = .Execute
        	 sCnt =	rsExe(0)
           set rsExe = Nothing
    End With
Call connClose()

if sCnt=0 then
    Call dbConOpen()
    Call connOpenOnly()
        With conn     
          .ActiveConnection = dbCon
        	.CommandText = "insert into wantNewsLetter(cate,email,regIp) values(?,?,?)"
    			.CommandType = adCmdText
    			    .Parameters.Append .CreateParameter("@cate",	               adVarWChar, 	        adParamInput, 50,	cate)
          		.Parameters.Append .CreateParameter("@s_email",	             adVarWChar, 		 			adParamInput, 200,	s_email)
    					.Parameters.Append .CreateParameter("@regIp",						     adVarWChar, 		      adParamInput, 50,	userip)					
    					.Execute, , adExecuteNoRecords
    					errCnt = errCnt + dbCon.Errors.Count
        End With
    Call connClose()
    Call dbConClose()
end if


if errCnt=0 then			
    response.write "OK"
else
    response.write "DBERROR"
end if
%>