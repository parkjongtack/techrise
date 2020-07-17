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


Dim schCate
schCate		 = request.QueryString("schCate")

if isEmptyStr(base64Decode(request.Cookies("AD_userID"))) then levelChk = "N"
if cint(base64Decode(request.Cookies("AD_userLV")))<5 then levelChk = "N"


%>
<div id="custom-content" class="white-popup-block" style="<%if levelChk="N" then%>display:none;<%end if%>max-width:900px; margin-top:20px;  padding:20px; background:#FFFFFF; margin: 4% auto;">
<div style="text-align:right;"><span class="mfp-closehan" style='cursor:pointer;color:#000000; font-size:18px; font-weight:bold;font-size:18px;' id='xButton'>X</span></div>
<img src='/_mngr/_img/1px.gif' border='0' onLoad="seChk('<%=levelChk%>')">

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr><td>&nbsp;</td></tr>
							<tr>
                <td class="padding">
								  
							    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
									  <tr>
										  <td>
											  <form name="adminForm" enctype="multipart/form-data" method="post"  target="procFrame">
												
												<table width="100%" border="0" cellspacing="1" cellpadding="3">
            						  
													<tr  height='40' align="center" class="table7" >
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>Title</nobr></td>
                            <td style='padding:10px;line-height:25px;' align="left"   bgcolor='#FFFFFF' colspan="3">
														<input type="text" name="subject" id="subject" value="" maxlength="500"  style="border:solid 1px #ccc;width:97%;height:25px;"></td>
                          </tr> 
													
													<tr  align="center" class="table7" >	
													  <td  bgcolor='#EAEBE2'><nobr>작성일</nobr></td>
                            <td bgcolor='#FFFFFF' style='padding:10px;text-align:left;'  width="400">
														<input type="text" name="sY" id="sY" value="<%=Year(now)%>" maxlength="4"  style="border:solid 1px #ccc;width:60px;height:25px;" onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'> /
														<input type="text" name="sM" id="sM" value="<%=calc(Month(now),2)%>" maxlength="2"  style="border:solid 1px #ccc;width:30px;height:25px;" onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'> /
														<input type="text" name="sD" id="sD" value="<%=calc(Day(now),2)%>" maxlength="2"  style="border:solid 1px #ccc;width:30px;height:25px;" onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'> &nbsp;&nbsp;YYYY/MM/DD
														
														</td>
														
														<td  bgcolor='#EAEBE2'><nobr>보여질 언어</nobr></td>
                            <td bgcolor='#FFFFFF' style='padding:10px;text-align:left;'>
														    <select name="b_langCheck" id="b_langCheck" style="border:solid 1px #ccc;height:25px;">
																<option value="">=========</option>
																<option value="ALL">ALL</option>
																<option value="KOR">Korean</option>
																<option value="ENG">English</option>
																</select>
														</td>	
													</tr>
													
													
													<tr  height='40' align="center" class="table7" >
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>Image</nobr></td>
                            <td style='padding:10px;line-height:25px;' align="left"   bgcolor='#FFFFFF' colspan="3">
														<input id="userFile" name="userFile" type="file" multiple accept="image/*" style="width:60%;height:25px;">
														<br>다중 선택 가능하나 용량이 많을지 일부 파일이 누락될 수 있습니다
														</td>
                          </tr>  
											
													
													<tr  height='40' align="center" class="table7" >
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>File List</nobr></td>
                            <td style='padding:10px;' align="left"   bgcolor='#FFFFFF' colspan="3">
														<ul id="file-list">  
                              <li class="no-items">noFile</li>  
                            </ul> 
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
							<tr><td align='center'><div onClick="adminFormProc()" id='gButton' style='width:100px;cursor:pointer;padding:5px; border:0px solid #ccc; font-size:15px;color:#fff; background:#82c041; text-align:center;'><strong>SAVE</strong></div></td></tr>
							<tr><td>&nbsp;</td></tr>
						</table>	
						
						<script> 
    var filesUpload = document.getElementById("userFile"), 
        fileList = document.getElementById("file-list"); 
     
    function traverseFiles (files) { 
      var li, 
          file, 
          fileInfo; 
      fileList.innerHTML = ""; 
         
      for (var i=0, il=files.length; i<il; i++) { 
        li = document.createElement("li"); 
        file = files[i]; 
        fileInfo = "<div><strong> "

                     + file.name + "</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;( "

                      + file.size + " bytes )</div>"; 
        li.innerHTML = fileInfo; 
        fileList.appendChild(li); 
      }; 
    }; 
     
    filesUpload.onchange = function () { 
      traverseFiles(this.files); 
    }; 
  </script> 		
</div>  