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
Dim levelChk : levelChk = "Y"
Dim bIdx
bIdx     = base64Decode(request("bIdx"))


if isEmptyStr(base64Decode(request.Cookies("AD_userID"))) then levelChk = "N"
if cint(base64Decode(request.Cookies("AD_userLV")))<5 then levelChk = "N"


Dim idx,title,content,view_date,file_or,file_sv,link_txt,b_hit,b_langCheck,file_or_list,file_sv_list,boardCate
Dim file_or_sp,file_sv_sp,file_txt,file_cnt


if not isEmptyStr(bIdx) then
    
		
    Dim listSqlExe
		
    Call connOpen()
        With conn
        .CommandText =  "select idx,boardCate,title,content,view_date,file_or,file_sv,link_txt,b_hit,b_langCheck,file_or_list,file_sv_list  from TB_board where idx=? "
        .CommandType = adCmdText
    		.Parameters.Append .CreateParameter("@idx", adInteger, adParamInput, 4, bIdx)
    		set rsExe = .Execute
        listSqlExe =	GetRsArray(rsExe)
        set rsExe = Nothing
        End With
    Call connClose()	

		
		if isNull(listSqlExe) then
        levelChk = "N"
    else
        
				idx									= listSqlExe(0,0)         
				boardCate						= listSqlExe(1,0)         
				title								= outSql(listSqlExe(2,0))         
				content							= outSql(listSqlExe(3,0))         
				view_date						= listSqlExe(4,0)         
				file_or							= listSqlExe(5,0)         
				file_sv							= listSqlExe(6,0)         
				link_txt						= outSql(listSqlExe(7,0))         
				b_hit								= listSqlExe(8,0)         
				b_langCheck					= listSqlExe(9,0)         
				
				file_or_list				= outSql(listSqlExe(10,0))         
				file_sv_list				= listSqlExe(11,0)         
				
				
				file_txt = ""
    		file_cnt = 0
				
				if not isEmptyStr(file_sv_list) then
				  
				    file_or_sp=replace(file_or_list,"||",",")
        		file_or_sp=replace(file_or_sp,"|","")
        		file_or_sp=split(file_or_sp,",")
        		
        		file_sv_sp=replace(file_sv_list,"||",",")
        		file_sv_sp=replace(file_sv_sp,"|","")
        		file_sv_sp=split(file_sv_sp,",")
						
						Dim fsObject
    				Set fsObject = CreateObject("Scripting.FileSystemObject")
		
						for i=0 to ubound(file_sv_sp)
						    if fsObject.FileExists(Server.MapPath(".") &"upload\BOARD\"&file_sv_sp(I))=true then
        				    file_txt = file_txt&"<div><a href='/upload/download.asp?fn="&file_sv_sp(i)&"&fd=BOARD&dd="&file_or_sp(i)&"' style='text-decoration:none;font-size:15px;color:#666666:'><nobr >"&file_or_sp(i)&"</nobr></a></div>"
    						end if
        		next
						
						Set fsObject = Nothing
				
				end if
		
		
		end if
else
    levelChk = "N"
end if

%>

<div id="custom-content" class="white-popup-block" style="<%if levelChk="N" then%>display:none;<%end if%>max-width:778px; margin-top:20px; z-index:10000000000000000000000; background:#fff; margin: 50px auto;">
  <div style="text-align:right;"><span class="mfp-closehan" style='display:none;cursor:pointer;color:#000000; font-size:18px; font-weight:bold;font-size:18px;' id='xButton'>X</span></div>
	 <div style="text-align:right;"></div>
  <style>
  #custom-content img {max-width:100%;height: auto;margin-bottom: 10px;}
  /* pop_detail */
  #pop_detail{height:40px; line-height:60px; padding-top:20px; background:#315cd5; color:#fff;}
  #pop_detail ul li{float:left; height:20px;  line-height:20px;}
  #pop_detail ul li:first-child{padding-left:16px; padding-right:20px; font-size:18px;}
  #pop_detail ul li:nth-of-type(2){ border-right:1px solid #ccc;}
  #pop_detail ul li:nth-of-type(3){ font-size:14px; padding-left:20px;}
 
  </style>
  <script>
	function delBD(str){

			if(confirm('삭제하시겠습니까??')){
            document.getElementById("procFrame").src="/_mngr/active/BOARD/d_proc.asp?delIdx="+str;
      }
	}
	
	function goIframeM(str){
    $("#writeDiv").attr("src","/_mngr/active/BD/write.html?bCode="+str);
		$('#xButton').click();
  }
	
	</script>
  <!--
	<div id="pop_detail">
    <ul><li><i></i>&</li></ul>
  </div>
	-->
  
  <div id="pop_detail_cont">
	
	<center>  
                    <table width="90%" border="0" cellspacing="0" cellpadding="0">
											  <tr><td height="40">&nbsp;</td></tr>
												<tr align="center"   >
                          <td  align="left"   bgcolor='#FFFFFF' style='padding:10px 0px;font-weight:700;'><%=title%></td>
												</tr>
												<tr align="center"   >
                          <td bgcolor='#cccccc' height='1'></td>
												</tr>
												<%if not isEmptyStr(file_txt) then%>
												<tr align="center"   >
                          <td  align="left"   bgcolor='#FFFFFF' style='padding:10px 0px;'><%=file_txt%></td>
												</tr>
												<tr align="center"   >
                          <td bgcolor='#cccccc' height='1'></td>
												</tr>
												<%end if%>
												<tr align="center"  >
                          <td  align="left"   bgcolor='#FFFFFF' style='padding:10px 0px;'><%=content%></td>
												</tr>
												<tr align="center"   >
                          <td bgcolor='#cccccc' height='1'></td>
												</tr>
                      </table>
	
	</center>  				 
  </div>

  <div style="clear:both; width:600px; margin:0 auto; height:1px; border-bottom:1px solid #ffffff"></div>

  <div style="width:90%; margin:0 auto; padding:20px 0px;" id='gButton'>
		<div style="width:120px; background:#1cc700;  color:#fff; cursor:pointer; text-align:center; font-size:13px; line-height:40px; height:40px; float:left; margin-right:10px " onClick="goIframeM('<%=base64Encode(idx)%>');">수 정</div>
		<div style="width:120px; background:#ff6600; color:#fff; cursor:pointer; text-align:center; font-size:13px; line-height:40px; height:40px; float:left; " onClick="delBD('<%=base64Encode(idx)%>');">삭 제</div>
		<div style="width:120px; background:#ababab; color:#fff; cursor:pointer; text-align:center; font-size:13px; line-height:40px; height:40px; float:right; " onClick="$('#xButton').click();">닫 기</div>
  </div>

  <div style="clear:both; width:600px; margin:0 auto; height:20px; border-bottom:1px solid #ffffff"></div>
		 


<img src='/_images/1px.gif' border='0' onLoad="buttonMake();seChk('<?=$levelChk?>');">
</div>	 