<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %>
<% Option Explicit %>
<object Runat="Server" Progid="ADODB.Connection" id="dbCon"></object>
<object Runat="Server" Progid="ADODB.RecordSet" id="rs"></object>
<!-- #include virtual="/_common/inc/noCache.asp" -->
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<!-- #include virtual="/_common/inc/base64.asp" -->
<!-- #include virtual="/_common/inc/dbCon.asp" -->
<!-- include virtual="/registration/reg_config_inc.asp" -->
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<%
Call isAdminChk_pop(5)

Dim s_code, regIdx
s_code = inSqlInjection(base64Decode(request.form("s_code")))
regIdx = clng(request.form("regIdx"))

Dim fee_total,inserPay,rpay_flag,mailsend,pay_method_r,senderName,memo,fee_unit
fee_total			= clng(request.form("fee_total"))
inserPay 			= request.form("inserPay")
rpay_flag = inSqlInjection(request.form("pay_flag"))
mailsend				= inSqlInjection(request.form("mailsend"))
pay_method_r		= inSqlInjection(request.form("pay_method"))
senderName 		= inSqlInjection(request.form("senderName"))
memo			= inSqlInjection(request.form("memo"))	

fee_unit = inSqlInjection(request.form("fee_unit"))	

Dim userip
userip = Request.ServerVariables("REMOTE_ADDR")

if isEmptyStr(inserPay) then
    inserPay = 0
else
		inserPay = Clng(inserPay)
end if

if fee_unit="USD" then
    fee_total=fee_total*100
		inserPay = inserPay *100
end if


Dim sql,insertQry,insertQry_1,insertQry_2,insertQry_3


insertQry  = "insert into AAC_mngrPay_Log (" &_
     			 	 "s_code, pay_method, pay_amount, res_msg, senderName,regIp" &_
     				 ") values(" &_
     				 "'"&s_code&"', '"&pay_method_r&"', "&inserPay&",  N'"&memo&"', '"&senderName&"', '"&userip&"'" &_
     				 ") "
						 
insertQry_1 = "update AAC_registration set fee_total="&fee_total&", pay_amount="&inserPay&",in_amount="&inserPay&", pay_method='"&pay_method_r&"',memo='"&memo&"',pay_flag='"&rpay_flag&"'  where s_code='"&s_code&"' and r_idx= "&regIdx		


if rpay_flag="Y" then
    insertQry_2 = "update AAC_registration set pay_date=getDate()  where s_code='"&s_code&"' and (pay_date='' or pay_date is null) and  r_idx= "&regIdx
else
    insertQry_2 = "update AAC_registration set pay_date=null  where s_code='"&s_code&"'  and  r_idx= "&regIdx    
end if





Call dbConOpen()
On Error Resume Next
Dim errCnt : errCnt = 0
dbCon.BeginTrans()





dbCon.execute(insertQry)
errCnt = errCnt + dbCon.Errors.Count


    
dbCon.execute(insertQry_1)
errCnt = errCnt + dbCon.Errors.Count


dbCon.execute(insertQry_2)
errCnt = errCnt + dbCon.Errors.Count




If errCnt=0 Then
    dbCon.CommitTrans  ' DB 입력 성공
    Call dbConClose()  
		if mailsend="Y" then
        Server.Execute("/letter/Con_reg.asp")
		end if
		response.write "<script>alert('Completed');opener.location.reload();self.close();</script>"
    response.end
Else
    dbCon.RollBackTrans
    call dbConClose()
    response.clear()
    call Alert("DB Insert Error\n\nPlease try again.",-1)
 		response.end
End If						 
%>