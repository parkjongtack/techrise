
<table  border="0" cellpadding="0" cellspacing="0" >
<tr>
  <td>
	
                	<table  border="0" cellpadding="0" cellspacing="5" >
									  <tr>
										  <td>
                       <div onClick="location.href='?mCate=<%=mCate%>&bMenu=<%=bMenu%>&menuIdx=<%=menuIdx%>&sMenu=00';"  style='width:140px;cursor:pointer;padding:5px; border:0px solid #ccc; font-size:13px;color:#fff; background:#<%if sMenu="00" then%>ff6600<%else%>c0c0c0<%end if%>; text-align:center;' "><strong>게시 중  항목</strong></div>
                      </td>
                  		<td width="20">&nbsp;</td>
                      <td>
                       <div onClick="location.href='?mCate=<%=mCate%>&bMenu=<%=bMenu%>&menuIdx=<%=menuIdx%>&sMenu=01';" style='width:140px;cursor:pointer;padding:5px; border:0px solid #ccc; font-size:13px;color:#fff; background:#<%if sMenu="01" then%>ff6600<%else%>c0c0c0<%end if%>; text-align:center;' "><strong>삭제 된 항목</strong></div>
                      </td>
                      <td width="50">&nbsp;</td>
											<td>
                        <a href='/_mngr/active/GALLERY/write.asp?menuIdx=<%=menuIdx%>&sMenu=<%=sMenu%>&schCate=<%=schCate%>' class='simple-ajax-popup-align-top'  style='text-decoration: none;'><div style='width:100px;cursor:pointer;padding:5px; border:0px solid #ccc; font-size:13px;color:#fff; background:#3399ff; text-align:center;' "><strong>새로 업로드</strong></div></a>
											</td>
										</tr>
										<tr><td colspan='5' height='10'></td></tr>
									</table>
									
									
 </td>
	
	<td width="200"><img src="/_images/1px.gif" width="100" height="1"></td>
	<td >								
<script language="JavaScript" type="text/javascript">
<!--


function enter(e){  
      if (e.which == 13){goSearch()}  
} 

function goSearch() {
    var form = document.searchForm;
		/* if(form.sch_field.value.Trim()||form.sch_value.value.Trim()){
    		if(!form.sch_field.value.Trim()){
    		    alert("검색할 항목을 선택해 주세요");
    				form.sch_field.focus();
    				return;
    		}
    		
    		if(!form.sch_value.value.Trim()){
    		    alert("검색어를 입력해 주세요");
    				form.sch_value.focus();
    				return;
    		}
		} */
		form.method = 'get';
    form.submit();
		
		
		
		
}

//-->
</script>		


<br>

<form name="searchForm" >
          <input type="hidden" name="menuIdx" value="<%=menuIdx%>">
          <input type="hidden" name="sMenu" value="<%=sMenu%>">
          <input type="hidden" name="mode" value="search">
          <input type="hidden" name="listCount" value="<%=listCount%>">
          <input type="hidden" name="bMenu" value="<%=bMenu%>">
          <input type="hidden" name="mCate" value="<%=mCate%>">    
      <table  border="0" cellspacing="1" cellpadding="3" >
			  <tr>
          <td width="55" class="bold_txt" valign="top" style='padding:5px 10px 0px 20px;'><nobr><strong>Search :</strong></nobr></td>
				  <td valign="top">
          
          
          
          <table border="0" cellspacing="1" cellpadding="3" class="table_3">
              
              <tr>
                 
                <th style="padding:5px 20px;">Subject</th>
                <td bgcolor="#FFFFFF" style="padding:5px 20px;" >
                <input name="sch_value" type="text" onkeypress = "enter(event)" <%if isEmptyStr(sch_value) then%>class="input"<%else%>class="inputins"<%end if%>   size="12" style="width:200px;height:23px;font-size:13px;" value="<%=sch_value%>">
                </td>
              </tr>
              
             
          </table>    
          
          
          
          
          
          </td>
         
          <td width="100" align='center' valign="top" style='padding:5px 20px 0px 15px;'><a href="javascript:goSearch();"><span class="buttonGreen">&nbsp;&nbsp;Search&nbsp;&nbsp;</span></a></td>
         
			  </tr>
			</table>
      </form>
      
      
			
			
	</td>
</table>											