<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %>
<% Option Explicit %>
<%Response.CharSet = "utf-8"%>
<object Runat="Server" Progid="ADODB.Connection" id="dbCon"></object>
<object Runat="Server" Progid="ADODB.RecordSet" id="rs"></object>
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<!-- #include virtual="/_common/inc/base64.asp" -->
<!-- #include virtual="/_common/inc/dbCon.asp" -->
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<!-- #include virtual="/gallery/gallery_cagegory_inc.asp" -->
<%

Dim levelChk
levelChk = "Y"



Dim idx,actionCate
idx     = base64Decode(request.QueryString("idx"))
if isEmptyStr(base64Decode(request.Cookies("AD_userID"))) then levelChk = "N"
if cint(base64Decode(request.Cookies("AD_userLV")))<5 then levelChk = "N"
if isEmptyStr(idx) then levelChk = "N"


Dim strQuery
strQuery = "select idx, subject,subjectKr,content, fileName, fileSize, fileWidth, fileHeight, cate from AAC_gallery where idx=" & idx

call dbConOpen()
rs.open strQuery,dbCon,1

if rs.EOF then
    call noEntryPage()
end if


Dim idxNum, subject, content, fileName, fileSize, fileWidth, fileHeight, hit, download,subjectKr,cate
idxNum     = rs(0)
subject    = rs(1)
subjectKr  = rs(2)
content    = rs(3)
fileName   = rs(4)
fileSize   = rs(5)
fileWidth  = rs(6)
fileHeight = rs(7)
cate       = rs(8)

Dim fileLocation
fileLocation = "/gallery/photos/" & fileName

Dim fileLocation_01
fileLocation_01 = "/gallery/photos/sm/sm_" & fileName

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
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>Cagegory</nobr></td>
                            <td style='padding:10px;' align="left"   bgcolor='#FFFFFF'>
														<select name="cate" id="cate" style='height:30px;border:solid 1px #cccccc;'>
														<option value="">=============================</option>
														<%
														Dim fi,optionTxt
														for fi=0 to ubound(photoCateAr)
														    if fi>=s_1st and fi<=e_1st then
																    optionTxt = b_photoCateAr(0)&" - "&photoCateAr(fi)
																elseif  fi>=s_2nd and fi<=e_2nd then
																    optionTxt = b_photoCateAr(1)&" - "&photoCateAr(fi)																
																else
																    optionTxt = photoCateAr(fi)																
																end if
														if cstr(cate)=cstr(fi) then
														%>		
														<option value="<%=fi%>" selected><%=optionTxt%></option>
														<%														
														else		
														%>		
														<option value="<%=fi%>"><%=optionTxt%></option>
														<%
														end if
														    if fi=e_1st then
														%>
														    <option value="" diabled>=============================</option>
														<%
														    end if
														
														next
														%>
														</select> 
													<tr  height='40' align="center" class="table7" >
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>Image</nobr></td>
                            <td style='padding:10px;line-height:25px;' align="left"   bgcolor='#FFFFFF'>
														<input type="file" name="userFile" style="width:60%;height:25px;" maxlength="30">
														</td>
                          </tr>  
											
													
													<tr  height='40' align="center" class="table7" >
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>File List</nobr></td>
                            <td style='padding:10px;' align="left"   bgcolor='#FFFFFF'><img src="<%=fileLocation_01%>" galleryimg="no">
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