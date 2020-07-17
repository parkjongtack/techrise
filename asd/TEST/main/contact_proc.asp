<!-- #include virtual="/common/inc/site_config_inc.asp" -->
<!-- #include virtual="/common/inc/base64.asp" -->
<%
Response.CharSet = "utf-8"
'response.end
' ·Î±×ÀÎ Á¤º¸ ------------------------------------------------------------------

On Error Resume Next
Dim errCnt : errCnt = 0  

Dim s_email,cate,quesCate,s_name,s_title,s_content,userip
s_email      = inSqlInjection(Trim(request.form("s_email")))
cate      = inSqlInjection(Trim(request.form("cate")))
quesCate      = inSqlInjection(Trim(request.form("quesCate")))
s_name      = inSqlInjection(Trim(request.form("s_name")))
s_title      = inSqlInjection(Trim(request.form("s_title")))
s_content      = inSqlInjection(Trim(request.form("s_content")))

userip      = request.ServerVariables("REMOTE_ADDR")
' ---------------------------------------



if isEmptyStr(s_email) or isEmptyStr(cate) or isEmptyStr(quesCate) or isEmptyStr(s_name) or isEmptyStr(s_title) or isEmptyStr(s_content)  then
    response.Clear
    response.write "NO_VALUE"
    response.end
end if 




Dim s_message,send_mail
s_message = "êµ¬ë¶„: "&cate&"<br>ì§ˆë¬¸ ë¶„ì•¼: "&quesCate&"<br>ì´ë¦„ : "&s_name&"<br>ì´ë©”ì¼: <a href='mailto:"&s_email&"'>"&s_email&"</a><br><br><br>"&s_title&"</b><br><br>"&replace(s_content,chr(13),"<br>")



if quesCate="ê°•ì—°" then
    send_mail = "program@tryeverything.or.kr"
elseif quesCate="ê¸°ì—…ì°¸ì—¬" then
    send_mail = "meetup@tryeverything.or.kr"
else
    send_mail = "secretariat@tryeverything.or.kr"
end if

Dim fromName, fromMail, subject, withMail
        
fromName = "Try Everything"
fromMail = send_mail
subject  = "[Try Everything] Contact Us"
	
Dim mailCnt
mailCnt=0		

if sendMailFree(fromName, fromMail, send_mail, subject, s_message, 1) then  ' ¸ŞÀÏ¹ß¼Û ¼º°ø
    mailCnt=1
end if


			
Call dbConOpen()
Call connOpenOnly()
    With conn     
      .ActiveConnection = dbCon
    	.CommandText = "insert into contactUs(cate,quesCate,s_name,s_email,s_title,s_content,regIp,mailCnt) values(?,?,?,?,?,?,?,?)"
			.CommandType = adCmdText
			    .Parameters.Append .CreateParameter("@cate",	               adVarWChar, 	        adParamInput, 50,	cate)
   				.Parameters.Append .CreateParameter("@quesCate",						 adVarWChar, 		 			adParamInput, 50,	quesCate)
					.Parameters.Append .CreateParameter("@s_name",							 adVarWChar, 		 			adParamInput, 200,	s_name)
      		.Parameters.Append .CreateParameter("@s_email",	             adVarWChar, 		 			adParamInput, 200,	s_email)
					.Parameters.Append .CreateParameter("@s_title",							 adVarWChar, 		 			adParamInput, 255,	s_title)
      		.Parameters.Append .CreateParameter("@s_content",	           adLongVarWChar ,  		adParamInput, len(s_content)*2+1,	s_content)
					.Parameters.Append .CreateParameter("@regIp",						     adVarWChar, 		      adParamInput, 50,	userip)
      		.Parameters.Append .CreateParameter("@mailCnt",							 adUnsignedTinyInt , 	adParamInput, 1,	mailCnt)		
					.Execute, , adExecuteNoRecords
					errCnt = errCnt + dbCon.Errors.Count
    End With
Call connClose()

Call dbConClose()


if mailCnt=1 then			
    response.write "OK"
else
    response.write "Fail"
end if
%>