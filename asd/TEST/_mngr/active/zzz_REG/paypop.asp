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
Dim ridx
ridx=base64Decode(request("ridx"))





' ==============================================================================
' ��� ���� üũ ---------------------------------------------------------------
Dim sql_info, obj_info
sql_info = "select memberCheck,fee_unit,pay_method,fee_total,pay_amount,memo, s_code, fName, nameKr,lName,country,senderName " &_
    "from AAC_registration where r_idx="&ridx
    
    
    
    
    

Call dbConOpen()
rs.open sql_info, dbCon, 1

If rs.BOF or rs.EOF Then
    response.clear()
		Response.write "no Data"
    response.end
End If



Dim fee_total,pay_amount,fee_unit,memo,pay_method,pay_support,s_code
Dim country,memberCheck,senderName,nameKr,fName,lName,feeTotalView,pay_amountView

fee_unit   = rs("fee_unit")
fee_total  = rs("fee_total")
pay_amount = rs("pay_amount")
memo			 = outSql(rs("memo"))
pay_method = rs("pay_method")
s_code     = rs("s_code")
senderName = outSqlView(rs("senderName"))
country  = outSqlView(rs("country"))
memberCheck				= outSqlView(rs("memberCheck"))


feeTotalView    = ""
pay_amountView  = ""
				
if fee_unit="KRW" then
    feeTotalView = fee_total
		pay_amountView = pay_amount
else
		feeTotalView = fee_total/100
		pay_amountView = pay_amount/100
end if
				

fName    = outSql(rs("fName"))
lName	 = outSql(rs("lName"))
nameKr	 = outSql(rs("nameKr"))

Call dbConClose()		

IF fee_unit = "KRW" THEN
		if isEmptyStr(senderName) then
		    senderName = senderName
		    if not isEmptyStr(nameKr) then
		        senderName = nameKr
    		else
    		    senderName = fName&" "&lName
    		end if
		end if		
ELSE
		
		if isEmptyStr(senderName) then
		    senderName = fName&" "&lName
		end if
END IF

Dim regNo
regNo=Calc(ridx,4)
	
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="ImageToolbar" content="No">
<link href="/_mngr/_css/style_pop.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript" src="/_common/js/availableChk.js"></script>
<script language="JavaScript" type="text/javascript" src="/_common/js/registrationChk.js?ver=121212"></script>
<script type="text/JavaScript">
<!--

function goNext() {
    var f = document.forms['payInsertForm'];
    
		//if(f.inserPay.value!=0){
		
          		if(f.pay_method[0].checked==false&&f.pay_method[1].checked==false){
            		    alert("입금 수단을 선택해 주세요");
            				f.pay_method[0].focus();				
            		    return false;
            	}
		//}
		
		if(f.pay_flag[0].checked==false&&f.pay_flag[1].checked==false){
            		    alert("결제완료 여부를 선택해 주세요");
            				f.pay_flag[0].focus();				
            		    return false;
     }
		
		if(f.mailsend[0].checked==false&&f.mailsend[1].checked==false){
            		    alert("컨펌메일 발송 여부를 선택해 주세요");
            				f.mailsend[0].focus();				
            		    return false;
     }

		
    f.method = 'post';
    f.action = 'pop_pay_proc.asp';
}

function onOffSender(str){
    var f = document.forms['payInsertForm'];
    if(f.pay_method[0].checked==true){
		   sendTr
			 document.getElementById("sendTr").style.display = 'none';
		}else{
			 document.getElementById("sendTr").style.display = 'table-row';		
		}
}
//-->
</script> 
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="90%" border="0" cellspacing="0" cellpadding="0" align='center'>
  <tr><td>&nbsp;</td></tr>
  <tr>
    <td>
	    
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align='center'>
			  
				<tr><td height="30" colspan="2" style="size:15px"><b><%=regNo%></b></td></tr>
				 <tr><td height="5" colspan="2"></td></tr>
      	<tr><td  colspan="2" height="1" background="/_images/line_icon.gif"></td></tr>
			  <tr><td height="5" colspan="2"></td></tr>
			  <tr>
				  <td width="24%">총 금액 :</td>
					<td width="76%" align='right'><%=fee_unit%>&nbsp;<%=formatnumber(feeTotalView,0)%></td>
				</tr>
				<!-- <tr>
				  <td>지원 금액 :</td>
					<td align='right'><%=formatnumber(pay_support,0)%></td>
				</tr> -->
				<tr><td height="5" colspan="2"></td></tr>
				<tr><td  colspan="2" height="1" background="/_images/line_icon.gif"></td></tr>
				<tr><td height="5" colspan="2"></td></tr>
				<tr>
				  <td>입금할 총금액 :</td>
					<td align='right'><%=fee_unit%>&nbsp;<%=formatnumber(feeTotalView,0)%></td>
				</tr>
				<tr>
				  <td>입금된 금액 :</td>
					<td align='right'><%=fee_unit%>&nbsp;<%=formatnumber(pay_amountView,0)%></td>
				</tr>
				<tr><td height="5" colspan="2"></td></tr>
				<tr><td  colspan="2" height="1" background="/_images/line_icon.gif"></td></tr>
				<tr><td height="5" colspan="2"></td></tr>
				<tr>
				  <td>차액 :</td>
					<td align='right'><%=fee_unit%>&nbsp;<%=formatnumber(feeTotalView-pay_amountView,0)%></td>
				</tr>
				<tr><td height="5" colspan="2"></td></tr>
      	<tr><td  colspan="2" height="1" background="/_images/line_icon.gif"></td></tr>
				<tr><td height="20" colspan="2"></td></tr>
				<form name="payInsertForm" onSubmit="return goNext()">
				<input type="hidden" name="s_code" value="<%=base64Encode(s_code)%>">
				<input type="hidden" name="regIdx" value="<%=ridx%>">
        <input type="hidden" name="sMenu" value="<%=sMenu%>">
				<input type="hidden" name="fee_unit" value="<%=fee_unit%>">
				<tr>
          <td ><strong>수정할 총금액</strong></td>
          <td >
					<%=fee_unit%>&nbsp;<input name="fee_total" type="text" class="abs_input" value="<%=feeTotalView%>" size="12" style="width:100;text-align:right;padding-right:20px;" maxlength="40"  onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'><br>
					* <!-- 지원금액 별도 / --> 상단 총 금액 변함
					</td>
        </tr>
				<tr><td height="10" colspan="2"></td></tr>
      	<tr><td  colspan="2" height="1" background="/_images/line_icon.gif"></td></tr>
				<tr><td height="10" colspan="2"></td></tr>
				
	      <tr>
          <td ><strong>결제 금액</strong></td>
          <td >
					<!-- <input type="radio" name='fee_unit' value="USD" <%if fee_unit="USD" then response.write "checked" end if%>>USD&nbsp;&nbsp;&nbsp;<input type="radio"  name='fee_unit' value="KRW" <%if fee_unit="KRW" then response.write "checked" end if%>>KRW<br> -->
					<%=fee_unit%>&nbsp;<input name="inserPay" type="text" class="abs_input" size="12" value="<%=pay_amountView%>"  style="width:100;text-align:right;padding-right:20px;" maxlength="8" value="0" onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'>
					</td>
        </tr>
       
			 <tr><td height="10" colspan="2"></td></tr>
				<tr>
          <td ><strong>결제 완료 처리</strong></td>
          <td >
					<input type="radio" name='pay_flag' value="Y" >완료&nbsp;&nbsp;&nbsp;<input type="radio"  name='pay_flag' value="N" >미완료<br>
					</td>
        </tr>
				
				
				<tr>
          <td ><strong>컨펌 메일 발송</strong></td>
          <td >
					<input type="radio" name='mailsend' value="Y" >발송&nbsp;&nbsp;&nbsp;<input type="radio"  name='mailsend' value="N" >보류<br>
					</td>
        </tr>
       
				
				<tr><td height="10" colspan="2"></td></tr>
      	<tr><td  colspan="2" height="1" background="/_images/line_icon.gif"></td></tr>
				<tr><td height="10" colspan="2"></td></tr>
				<tr>
          <td ><strong>입금 구분</strong></td>
          <td ><input name="pay_method" type="radio" value="C" <%if pay_method="C" then %>checked<%end if%> onclick="onOffSender()">신용카드 &nbsp;&nbsp;&nbsp;&nbsp;<input name="pay_method" type="radio" value="B" <%if pay_method="B" then %>checked<%end if%> onclick="onOffSender()">은행 송금</td>
        </tr>
				<tr id='sendTr' <%if pay_method<>"B" then %>style="display:none;"<%end if%>>
          <td style='padding-top:2px;'><strong>송금인</strong></td>
          <td style='padding-top:2px;'><input name="senderName" type="text" class="abs_input" value="<%=senderName%>" size="12" style="width:200" maxlength="40"></td>
        </tr>
				<tr><td height="10" colspan="2"></td></tr>
      	<tr><td  colspan="2" height="1" background="/_images/line_icon.gif"></td></tr>
				<tr><td height="10" colspan="2"></td></tr>
				
				<tr>
          <td ><strong>특이사항</strong></td>
          <td ><textarea name="memo"  class="abs_input" cols='40' rows='4'><%=memo%></textarea></td>
        </tr>
				<tr><td height="10" colspan="2"></td></tr>
      	<tr><td  colspan="2" height="1" background="/_images/line_icon.gif"></td></tr>
				<tr><td height="10" colspan="2"></td></tr>
				<tr><td align="center" colspan="2"><input type="submit" class="input01" value="  Save  "  ></td></tr>
				</form>
		  </table>
		
		</td>
	</tr>
</table>
</body>
</html>