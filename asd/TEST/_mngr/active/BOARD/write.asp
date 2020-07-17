<% @LANGUAGE='VBSCRIPT' CODEPAGE='65001' %>
<%
Option Explicit
Response.CharSet = "utf-8"
%>
<object Runat="Server" Progid="ADODB.Connection" id="dbCon"></object>
<object Runat="Server" Progid="ADODB.RecordSet" id="rs"></object>
<!-- #include virtual="/common/inc/noCache.asp" -->
<!-- #include virtual="/_mngr/_inc/func.asp" -->
<!-- #include virtual="/common/inc/base64.asp" -->
<!-- #include virtual="/common/inc/dbCon.asp" -->
<!-- #include virtual="/_mngr/_inc/ad_config_inc.asp" -->
<%
Call isAdminChk_iframe(5)

Dim boardCate,idx
boardCate   = request("boardCate")
idx					= request("idx")

Dim file_txt,file_txt_01

%>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/_mngr/_css/style_pop.css" rel="stylesheet" type="text/css">
<link href="/_mngr/_css/buttonStyle.css" rel="stylesheet" type="text/css">
<script src="/common/js/jquery-2.1.3.min.js"></script>
<script src="/common/js/availableChk.js"></script>
<script src="/_mngr/_js/bd.js"></script>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/_mngr/_css/style_pop.css" rel="stylesheet" type="text/css">
<link href="/_mngr/_css/buttonStyle.css" rel="stylesheet" type="text/css">
<script src="/_includes/js/jquery-2.1.3.min.js"></script>
<script src="/_mngr/_js/availableChk.js"></script>
<script src="/_mngr/_js/bd.js"></script>
<script type="text/javascript" src="/editor/ckeditor.js"></script>


									 <script>
									 $(function(){
                        CKEDITOR.replace('content', {"width":"97%","height":"200px"});
                   });
									 
									 
									 </script>
									 <form name="bbsForm"  id="bbsForm" enctype="multipart/form-data" method="post" >
									 <input type='hidden' name="boardCate" value="<%=boardCate%>">
									 <input type='hidden' name="b_mode" >
									 <input type='hidden' name="m_idx" >
									 
  								 <input type="hidden" name="file_sv"  id="file_sv" >
		    					 <input type="hidden" name="file_or"  id="file_or" >
									 
									 
									 <input type="hidden" name="file_sv_list"  id="file_sv_list" >
		    					 <input type="hidden" name="file_or_list"  id="file_or_list" >
									 
									 <input type="hidden" name="del_sv"  id="del_sv">
									 
									 <body style="margin:0;padding:0;">
									 <table border="0" width="100%"  cellpadding="0" cellspacing="1" bgcolor="#999999">
                    <tr>
                      <td>
											
                        <table width="100%"  border="0" cellspacing="1" cellpadding="3">
                          <tr  align="center" class="table7" >
                            <td width="120" bgcolor='#EAEBE2'><nobr>제목</nobr></td>
                            <td bgcolor='#FFFFFF' style='padding:10px;text-align:left;'  colspan="3"><input type="text" name="title" id="title" value="" maxlength="500"  style="border:solid 1px #ccc;width:97%;height:25px;"></td>
													</tr>
													
													
													
													<tr  align="center" class="table7" <%IF boardCate="NEWS" THEN%>style='display:none;'<%END IF%>>	
													  <td  bgcolor='#EAEBE2'><nobr>섬네일 이미지</nobr></td>
                            <td bgcolor='#FFFFFF' style='padding:10px;text-align:left;' colspan="3">
														  
															<table border="0" cellspacing="0" cellpadding="0" >
                              <tr>
                                <td valign="top" style='border:0px solid #FFFFFF;padding:0px;'>
                        				<div style='border:1px solid #cccccc;font-size:13px;width:400px;height:30px;text-align:left;overflow:auto;' >
                                  	  <div id="id_05" align='center' style='display:none;'>
                                    		  <div style='text-align:center;' ><img src='/_images/smallLoading.gif'></div>
                               				</div>
                               				<div id='id_03' <%if isEmptyStr(file_txt_01) then%>style='display:none;'<%end if%>><%=file_txt_01%></div>
                             				</div>
                        				
                        				</td>
              									
                                <td width="200" style='line-height:50px;border:0px solid #FFFFFF;' align="cetner">
                        				<div style='display:none;' id="id_06">
																		<input type="file" name="id_01" id="id_01" onChange="thum_fileFun('bbsForm','jpg|gif|jpeg|png|bmp','bbsBtn','id_01','id_02','id_03','id_04','id_05','id_06','file_sv','file_or','board','Y')" accept="image/*" >
																		</div>
                              			<div id="id_02" >
                                			<div id="upFileBtn1" style='width:80px; margin:0 auto; height:20px; cursor:pointer;  line-height:20px; background:#3399ff; color:#fff; font-weight:500;  padding:1px; text-align:center;'  onclick="if($('#id_01')){$('#id_01').click();}">Upload</div>
                               			</div>
                               			<div id="id_04" style='display:none;'>
                               			  
                               			</div>
                        				
                        				</td>
                              </tr>
                        		 </table>
														 
														 
																		
														</td>
													</tr>
													
													<tr  align="center" class="table7" <%IF boardCate="NEWS" THEN%>style='display:none;'<%END IF%> >	
													  <td  bgcolor='#EAEBE2'><nobr><%if boardCate="MEDIA" then%>URL<%else%>유투브 URL<%end if%></nobr></td>
                            <td bgcolor='#FFFFFF' style='padding:10px;text-align:left;' colspan="3"><input type="text" name="link_txt" id="link_txt"  style="border:solid 1px #ccc;width:97%;height:25px;"></td>
													</tr>
													
													<tr  align="center" class="table7" >	
													  <td  bgcolor='#EAEBE2'><nobr><%if boardCate="MEDIA" then%>보도 날짜<%else%>작성일<%end if%></nobr></td>
                            <td bgcolor='#FFFFFF' style='padding:10px;text-align:left;'  >
														<input type="text" name="sY" id="sY" value="" maxlength="4"  style="border:solid 1px #ccc;width:60px;height:25px;" onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'> /
														<input type="text" name="sM" id="sM" value="" maxlength="2"  style="border:solid 1px #ccc;width:30px;height:25px;" onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'> /
														<input type="text" name="sD" id="sD" value="" maxlength="2"  style="border:solid 1px #ccc;width:30px;height:25px;" onkeydown='onlynumberic(this);' onkeyup='onlynumberic(this);' onblur='onlynumberic(this);'> &nbsp;&nbsp;YYYY/MM/DD
														
														</td>
														
														<td  bgcolor='#EAEBE2'><nobr> 언어</nobr></td>
                            <td bgcolor='#FFFFFF' style='padding:10px;text-align:left; width="150"'>
														    <select name="b_langCheck" id="b_langCheck" style="border:solid 1px #ccc;height:25px;">
																<option value="">=========</option>
																<option value="ALL">ALL</option>
																<option value="KOR">Korean</option>
																<option value="ENG">English</option>
																</select>
														</td>	
													</tr>
													
													
													<tr  align="center" class="table7" <%IF boardCate="VIDEO" THEN%>style='display:none;'<%END IF%>>	
													  <td  bgcolor='#EAEBE2'><nobr><%if boardCate="MEDIA" then%>요약<%else%>내용<%end if%></nobr></td>
                            <td bgcolor='#FFFFFF'  colspan="3"><textarea name="content"  id="content" style='display:none;'></textarea></td>
													</tr>	
													
													
													<tr height='25' align="center" class="table7" style='//display:none;'>	
													  <td bgcolor='#EAEBE2'><nobr>File</nobr></td>
                            <td bgcolor='#FFFFFF' style='padding:10px;text-align:left;' colspan="3">
															 <table border="0" cellspacing="0" cellpadding="0" >
                              <tr>
                                <td valign="top" style='border:0px solid #FFFFFF;padding:0px;'>
                        				<div style='border:1px solid #cccccc;font-size:13px;width:400px;height:80px;text-align:left;overflow:auto;' >
                          				<div id="lodingDiv_file" align='center' style='display:none;'>
                          				 
                                    <div style='text-align:center;' ><img src='/_images/smallLoading.gif' ></div>
                                  
                          				</div>
                          				<div id='viewFileDiv' <%if isEmptyStr(file_txt) then%>style='display:none;'<%end if%>><%=file_txt%></div>
                        				</div>
                        				
                        				</td>
              									
                                <td width="200" style='line-height:50px;padding:30px 0px 30px 0px;border:0px solid #FFFFFF;' align="cetner">
                        				<div style='display:none;' id="fileDiv"><input type="file" name="upFile" id="upFileBtn" onChange="fileFun()" ></div>
                        				<div id="upBtn" >
                        				<div  style='width:80px; margin:0 auto; height:20px; cursor:pointer;  line-height:20px; background:#3399ff; color:#fff; font-weight:500;  padding:1px; text-align:center;' onclick="if($('#upFileBtn')){$('#upFileBtn').click();}">Upload</div>
                        				</div>
                        				
                        				<div id="lodingDiv" align='center' style='display:none;'>
                        				 
                                  <div style='text-align:center;' ><img src='/_images/smallLoading.gif' ></div>
                                 
                        				</div>
                        				
                        				</td>
                              </tr>
                        		 </table>
              							 
									
														
														</td>
													</tr>	
													
												</table>	
											
											</td>
										</tr>
									 </table>	
									 </form>
									<div>&nbsp;</div>
									<div id="bbsBtn" style='margin:0 auto; width:100px;cursor:pointer;padding:5px; border:0px solid #ccc; font-size:13px;color:#fff; background:#3399ff; text-align:center;' onclick="goBD()"><strong>SAVE</strong></div>
									
									<iframe name="board_procFrame_file" id="board_procFrame_file" style="display:none;width:0px;" ></iframe> 

									
