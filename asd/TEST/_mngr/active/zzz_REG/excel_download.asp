<% @CodePage=65001 Language="VBScript" %>
<% Option Explicit %>
<%Response.CharSet = "utf-8"%>
<object Runat="Server" Progid="ADODB.Connection" id="dbCon"></object>
<object Runat="Server" Progid="ADODB.RecordSet" id="rs"></object>
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<!-- #include virtual="/_common/inc/base64.asp" -->
<!-- #include virtual="/_common/inc/dbCon.asp" -->
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<!-- #include virtual="/registration/reg_config_inc.asp" -->
<%

Call isAdminChk(2)

Server.ScriptTimeOut = 10000

Dim fileQry,fileQry_01
fileQry = request.form("downloadQry")

Dim  sql_columns
sql_columns = "select column_name from Information_Schema.columns where table_name='AAC_registration' order by ordinal_position"

call dbConOpen()
rs.open sql_columns,dbCon,1

Dim colCnt
colCnt = rs.RecordCount

reDim colName(colCnt-1)
for i=0 to colCnt-1
		colName(i) = rs(0)
		rs.moveNext
next
call dbConClose()


Dim nIdx,cateIdx,ftitle
ftitle="REGISTRATION"
nIdx=array(0,1,3,33,34,36,41,47,48,49,50,51,54,55,56,57)
'nIdx=array(0)

%>



<html>
<head>
<meta http-equiv='Content-Type' content='text/html;charset=utf-8'>
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book1.files/filelist.xml">
<link rel=Edit-Time-Data href="Book1.files/editdata.mso">
<link rel=OLE-Object-Data href="Book1.files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>seoul</o:Author>
  <o:LastAuthor>seoul</o:LastAuthor>
  <o:Created><%=now%></o:Created>
  <o:LastSaved><%=now%></o:LastSaved>
  <o:Company>seoul</o:Company>
  <o:Version>11.6568</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->

<style type="text/css">
<!--
td 	{font-size:10pt;}
.xl28	{mso-number-format:"\@";}
.xTxt {mso-number-format:"\@";}
-->
</style>
</head>
<body>
<table width="100%" border="1" cellspacing="0" cellpadding="0" style='border-collapse: collapse;'>
  
  <%
	
	

	
  Dim subi,sssidx_1
  for i=0 to colCnt-1
	    if not inArray(nIdx,i)  then
         'response.write "<td style=""padding:2 5 2 5;"" bgcolor=""#efefef""> <b>"&colName(i)&"...."&i&"</b></td>"
         if i=35 then
				     response.write "<td style=""padding:2 5 2 5;"" bgcolor=""#efefef"" align='center'> <b>File</b></td>"		 
				 else
				     response.write "<td style=""padding:2 5 2 5;"" bgcolor=""#efefef"" align='center'> <b>"&colName(i)&"</b></td>"
				 end if
      end if
  next  
  
	
	
	  call dbConOpen()
    rs.open fileQry,dbCon,1
		
		Dim rsCnt, inval, apCnt, unApCnt, subSql, sCode, subSqlExe, subIndex,sql_auInfo,bclr,objAu,n
		
    Dim ws_sp,fori
    Dim big_category_reg,category_reg,feeAr_reg,m_01,m_02
		rsCnt = rs.recordCount
		
		Dim tdbg
		for i=0 to rsCnt-1
    
                 
				response.write "<tr bgcolor=""#FFFFFF"" style='text-align:center;mso-height-source:userset;height:22.5pt'>"
				
				for j=0 to colCnt-1
           
					     
           inval=rs(j)
					 
					 if j=35 then
    			    if not isEmptyStr(inval) then
							    inval="<a href='http://work.aacr-kca.org/upload/student/"&inval&"' target='_blank'>Down</a>"
							end if
    			 end if
								
					 if not inArray(nIdx,j) then
					     
							  
    				    
    						if isEmptyStr(inval) or isNull(inval) then
    							  response.write "<td >&nbsp;</td>"
    						else
                       if isnumeric(inval)  then
                   			   response.write "<td bgcolor='"&tdbg&"' class=""x128"" style='mso-number-format:\@'>" & cstr(inval) & "</td>"
                       else
                           response.write "<td bgcolor='"&tdbg&"' >" & cstr(inval) &"</td>"    
                  		 end if
    						end if
						end if
				next
        
        
				rs.MoveNext
				response.write "</tr>"
		next
		
		
    call dbConClose()

  
%>
  
</table>  

 </table>
</body>
</html>  

<%
Dim fileName
fileName = ftitle&"_"&Year(now)&Calc(Month(now),2)&Calc(Day(now),2)&".xls"

with response
    .Buffer = True
    .Expires = 0
    .ContentType  = "application/x-msexcel"
    .CacheControl  = "public"
    .AddHeader "Content-Disposition" , "attachment; filename="&fileName
end with
%>
        
