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

Dim bbs_idx
bbs_idx     = base64Decode(request.QueryString("bbs_idx"))

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
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>Cagegory</nobr></td>
                            <td style='padding:10px;' align="left"   bgcolor='#FFFFFF'>
														<select name="cate" id="cate" style='height:30px;border:solid 1px #cccccc;'>
														<option value="">=============================</option>
														<%
														Dim fi,optionTxt,selectTxt
														for fi=0 to ubound(photoCateAr)
														    if fi>=s_1st and fi<=e_1st then
																    optionTxt = b_photoCateAr(0)&" - "&photoCateAr(fi)
																elseif  fi>=s_2nd and fi<=e_2nd then
																    optionTxt = b_photoCateAr(1)&" - "&photoCateAr(fi)																
																else
																    optionTxt = photoCateAr(fi)																
																end if
																
																if cstr(schCate) = cstr(fi) then
																    selectTxt = "selected"
																else
																    selectTxt = ""																
																end if		
														%>		
														<option value="<%=fi%>" <%=selectTxt%>><%=optionTxt%></option>
														<%
														    if fi=e_1st then
														%>
														    <option value="" diabled>=============================</option>
														<%
														    end if
														
														next
														%>
														</select> 
														</td>
                          </tr>  
													<tr  height='40' align="center" class="table7" >
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>Image</nobr></td>
                            <td style='padding:10px;line-height:25px;' align="left"   bgcolor='#FFFFFF'>
														<input id="userFile" name="userFile" type="file" multiple accept="image/*" style="width:60%;height:25px;">
														<br>다중 선택 가능하나 용량이 많을지 일부 파일이 누락될 수 있습니다
														</td>
                          </tr>  
											
													
													<tr  height='40' align="center" class="table7" >
                            <td style='padding:10px;' width="20%"  bgcolor='#EAEBE2'><nobr>File List</nobr></td>
                            <td style='padding:10px;' align="left"   bgcolor='#FFFFFF'>
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