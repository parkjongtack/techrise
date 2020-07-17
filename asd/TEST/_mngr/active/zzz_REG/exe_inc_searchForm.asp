<%
' ##############################################################################
' ÃÊ·Ï ¸®½ºÆ® Ãâ·Â½Ã Æ÷ÇÔÇÏ´Â ÃÊ·Ï »ó¼¼ °Ë»öÆû
' ÆÄÀÏ¸í : exe_AL_inc_searchForm.asp
' ¼öÁ¤ÀÏ : 2007.03.28
' ##############################################################################
%>
<script language="JavaScript" type="text/javascript">
<!--
function enter(e){  
      if (e.which == 13){goSearch()}  
} 

function goSearch() {
    var form = document.searchForm;
		var tmpCnt = 0;
		
    /* if (!form.sch_userID.value && !form.sch_fullName.value && !form.sch_smallName.value && !form.sch_email.value && !form.sch_country.value && !form.sch_regDateSt.value && !form.sch_pName.value&& !form.sch_pemail.value) {
				 form.sch_userID.focus(); return false;
    } */
		
		/* if (form.sch_regDateSt.value && form.sch_regDateEn.value) {
		    if (calcDate(form.sch_regDateSt.value,form.sch_regDateEn.value) < 0) {
            alert('error Reg.Date.'); form.sch_regDateSt.focus(); return false;
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
          <td width="55" class="bold_txt" valign="top" style='padding-top:5px;'><nobr><strong>Search :</strong></nobr></td>
				  <td valign="top">
          
          
          
          <table border="0" cellspacing="1" cellpadding="3" class="table_3">
              
              <tr>
                <th width="120" >ì°¸ê°€ êµ¬ë¶„</th>
                <td bgcolor="#FFFFFF" style="padding:3px 20px 3px 7px;" width="200">
                <select name="sch_reg" onkeypress = "enter(event)" <%if isEmptyStr(sch_reg) then%>class="input"<%else%>class="inputins"<%end if%> style="width:150px;height:20px;">
                     <option value="">====================</option>
										 <option value="A" <%if sch_reg="A" then %>selected<%end if%>> AACR-KCA Joint Workshop + KCA ì¶”ê³„ì‹¬í¬ì§€ì—„</option>
										 <option value="B" <%if sch_reg="B" then %>selected<%end if%>> KCA ì¶”ê³„ì‹¬í¬ì§€ì—„ </option>
                </select>
								</td>
              
                <th width="120" >First Name</th>
                <td bgcolor="#FFFFFF" style="padding:3px 20px 3px 7px;" width="200">
                <input name="sch_fName" type="text" onkeypress = "enter(event)" <%if isEmptyStr(sch_fName) then%>class="input"<%else%>class="inputins"<%end if%>  size="12" style="width:150px" value="<%=sch_fName%>">
                </td>
								
								<th width="120">Country</th>
                <td bgcolor="#FFFFFF" style="padding:3px 20px 3px 7px;"  width="200" >
                <select name="sch_country" <%if isEmptyStr(sch_country) then%>class="input"<%else%>class="inputins"<%end if%> style="width:220px;height:20px;">
                    <% if not isEmptyStr(sch_country) then %>
                    <option value="<%=sch_country%>" selected><%=sch_country%></option>
                    <% end if %>
                    <% call countryListView() %>
                  </select>
                </td>
								
								
								<th width="120" >Member</th>
                <td bgcolor="#FFFFFF" style="padding:3px 20px 3px 7px;"  width="200" >
                 
                 <select name="sch_member" onkeypress = "enter(event)" <%if isEmptyStr(sch_member) then%>class="input"<%else%>class="inputins"<%end if%> style="width:150px;height:20px;">
                     <option value="">====================</option>
										 <option value="A" <%if sch_member="A" then %>selected<%end if%>> ëŒ€í•œì•”í•™íšŒ íšŒì› </option>
										 <option value="B" <%if sch_member="B" then %>selected<%end if%>> AACR íšŒì› </option>
										 <option value="C" <%if sch_member="C" then %>selected<%end if%>> ë¹„íšŒì› </option>
                  </select>

                </td>

                
              </tr>
							
							
							<tr>
             
                
                
              <th width="120">êµ­ë¬¸ëª…</th>
                <td bgcolor="#FFFFFF" style="padding:3px 20px 3px 7px;">
                 <input name="sch_nameKr" type="text" onkeypress = "enter(event)" <%if isEmptyStr(sch_nameKr) then%>class="input"<%else%>class="inputins"<%end if%> style="width:150px" value="<%=sch_nameKr%>"> 
                </td>
              
                <th width="120">Last Name</th>
                <td bgcolor="#FFFFFF" style="padding:3px 20px 3px 7px;">
                <input name="sch_lName" type="text" onkeypress = "enter(event)" <%if isEmptyStr(sch_lName) then%>class="input"<%else%>class="inputins"<%end if%> size="12" style="width:150px" value="<%=sch_lName%>">
                </td>
              
                <th width="120">Email</th>
                <td bgcolor="#FFFFFF" style="padding:3px 20px 3px 7px;">
                 <input name="sch_email" type="text" onkeypress = "enter(event)" <%if isEmptyStr(sch_email) then%>class="input"<%else%>class="inputins"<%end if%> style="width:220px" value="<%=sch_email%>"> 
                </td>
                
								<th width="120" >Category</th>
                <td bgcolor="#FFFFFF" style="padding:3px 20px 3px 7px;"  width="200" >
                 
                 <select name="sch_category" onkeypress = "enter(event)" <%if isEmptyStr(sch_category) then%>class="input"<%else%>class="inputins"<%end if%> style="width:150px;height:20px;">
                     <option value="">====================</option>
										 <%
          					for i=0 to ubound(categroy_Ar)
										    if sch_category = categroy_Ar(i) then
												    response.write "<option value='"&categroy_Ar(i)&"' selected>"&categroy_Ar(i)&"</option>"
												else
												    response.write "<option value='"&categroy_Ar(i)&"'>"&categroy_Ar(i)&"</option>"
												end if
          					    		
          							
          					next
          					%>
										<%
          					for i=0 to ubound(categroy_En)
          					    if sch_category = categroy_En(i) then
												    response.write "<option value='"&categroy_En(i)&"' selected>"&categroy_En(i)&"</option>"
												else
												    response.write "<option value='"&categroy_En(i)&"'>"&categroy_En(i)&"</option>"
												end if		
          							
          					next
          					%>
                  </select>

                </td>
								
								
              </tr>
              
             
          </table>    
          
          
          
          
          
          </td>
         
          <td width="100" align='center' valign="top" style='padding-top:5px;'><a href="javascript:goSearch();"><span class="buttonGreen">&nbsp;&nbsp;Search&nbsp;&nbsp;</span></a></td>
         
			  </tr>
			</table>
      </form>
      