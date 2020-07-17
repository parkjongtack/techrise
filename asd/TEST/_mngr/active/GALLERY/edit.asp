<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %>
<% Option Explicit %>
<%Response.CharSet = "utf-8"%>
<object Runat="Server" Progid="ADODB.Connection" id="dbCon"></object>
<object Runat="Server" Progid="ADODB.RecordSet" id="rs"></object>
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<!-- #include virtual="/common/inc/base64.asp" -->
<!-- #include virtual="/common/inc/dbCon.asp" -->
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<%

Dim levelChk
levelChk = "Y"



Dim idx,actionCate
idx     = base64Decode(request.QueryString("idx"))



if isEmptyStr(base64Decode(request.Cookies("AD_userID"))) then levelChk = "N"
if cint(base64Decode(request.Cookies("AD_userLV")))<5 then levelChk = "N"
if isEmptyStr(idx) then levelChk = "N"


Dim strQuery
strQuery = "select idx, subject,subjectKr,content, fileName, fileSize, fileWidth, fileHeight, cate,view_date,b_langCheck from TB_gallery where idx=" & idx

call dbConOpen()
rs.open strQuery,dbCon,1

if rs.EOF then
    call noEntryPage()
end if

Dim idxNum, subject, content, fileName, fileSize, fileWidth, fileHeight, hit, download,subjectKr,cate,view_date,b_langCheck
idxNum     = rs(0)
subject    = rs(1)
subjectKr  = rs(2)
content    = rs(3)
fileName   = rs(4)
fileSize   = rs(5)
fileWidth  = rs(6)
fileHeight = rs(7)
cate       = rs(8)
view_date   = rs(9)
b_langCheck   = rs(10)

Dim sY,sM,sD

sY = split(view_date,"-")(0)
sM = split(view_date,"-")(1)
sD = split(view_date,"-")(2)


Dim fileLocation
fileLocation = "/upload/photos/" & fileName

Dim fileLocation_01
fileLocation_01 = "/upload/photos/sm/sm_" & fileName

call dbConClose()
%>


<div id="custom-content" class="white-popup-block" style="<%if levelChk="N" then%>display:none;<%end if%>max-width:900px; margin-top:20px;  padding:20px; background:#FFFFFF; margin: 4% auto;">
<div style="text-align:right;"><span class="mfp-closehan" style='cursor:pointer;color:#000000; font-size:15px; font-weight:bold;' id='xButton'>X</span></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr><td>&nbsp;</td></tr>
							<tr>
                <td class="padding">
								  
							    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
									  <tr>
										  <td>
											
											  <form name="adminForm" ENCTYPE="multipart/form-data" target="procFrame">
                    		<input type="hidden" name="pageMode" value="modify">
                    		<input type="hidden" name="idx" value="<%=idx%>">
												
										
											  
												
												<table width="100%" border="0" cellspacing="1" cellpadding="3">
            						  <tr  height='40' align="center" class="table7" >
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>Title</nobr></td>
                            <td style='padding:10px;line-height:25px;' align="left"   bgcolor='#FFFFFF' colspan="3">
														<input type="text" name="subject" id="subject"  maxlength="500"  value="<%=subject%>" style="border:solid 1px #ccc;width:97%;height:25px;"></td>
                          </tr> 
													
													<tr  align="center" class="table7" >	
													  <td  bgcolor='#EAEBE2'><nobr>작성일</nobr></td>
                            <td bgcolor='#FFFFFF' style='padding:10px;text-align:left;'  width="400">
														<input type="text" name="sY" id="sY" maxlength="4" value="<%=sY%>"  style="border:solid 1px #ccc;width:60px;height:25px;" onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'> /
														<input type="text" name="sM" id="sM" maxlength="2" value="<%=sM%>"   style="border:solid 1px #ccc;width:30px;height:25px;" onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'> /
														<input type="text" name="sD" id="sD" maxlength="2" value="<%=sD%>"   style="border:solid 1px #ccc;width:30px;height:25px;" onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'> &nbsp;&nbsp;YYYY/MM/DD
														
														</td>
														
														<td  bgcolor='#EAEBE2'><nobr>보여질 언어</nobr></td>
                            <td bgcolor='#FFFFFF' style='padding:10px;text-align:left;'>
														    <select name="b_langCheck" id="b_langCheck" style="border:solid 1px #ccc;height:25px;">
																<option value="">=========</option>
																<option value="ALL" <%if b_langCheck="ALL" then%>selected<%end if%>>ALL</option>
																<option value="KOR" <%if b_langCheck="KOR" then%>selected<%end if%>>Korean</option>
																<option value="ENG" <%if b_langCheck="ENG" then%>selected<%end if%>>English</option>
																</select>
														</td>	
													</tr>
													
													
													<tr  height='40' align="center" class="table7" >
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>Image</nobr></td>
                            <td style='padding:10px;line-height:25px;' align="left"   bgcolor='#FFFFFF' colspan="3">
														<input type="file" name="userFile" style="width:60%;height:25px;" maxlength="30">
														</td>
                          </tr>  
											
													
													<tr  height='40' align="center" class="table7" >
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>File List</nobr></td>
                            <td style='padding:10px;' align="left"   bgcolor='#FFFFFF' colspan="3"><img src="<%=fileLocation_01%>" galleryimg="no" >
														</td>
                          </tr>  
											
                        
													
												</table>
												</form>
																					</td>
										</tr>
										
									</table>
									
								</td>
							</tr>
							<tr><td>&nbsp;</td></tr>
							<tr><td align='center'><div onClick="modifyCheck()" id='gButton' style='width:100px;cursor:pointer;padding:5px; border:0px solid #ccc; font-size:15px;color:#fff; background:#82c041; text-align:center;'><strong>SAVE</strong></div></td></tr>
							<tr><td>&nbsp;</td></tr>
						</table>	


<img src='/_mngr/_img/1px.gif' border='0' onLoad="seChk('<%=levelChk%>');">
</div>  