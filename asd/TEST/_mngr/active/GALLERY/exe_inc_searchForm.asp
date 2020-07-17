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
									<table  border="0" cellpadding="0" cellspacing="5" >
									  <tr>
										  <td>
      				         <form name="searchForm" >
          						 <input type="hidden" name="menuIdx" value="<%=menuIdx%>">
          						 <input type="hidden" name="sMenu" value="<%=sMenu%>">
          						 <input type="hidden" name="mode" value="search">
          						 <input type="hidden" name="listCount" value="<%=listCount%>">
          						 <input type="hidden" name="bMenu" value="<%=bMenu%>">
          						 <input type="hidden" name="mCate" value="<%=mCate%>">
											  
											  <select name='schCate'  id='schCate' onChange="goSearch();" <%if isEmptyStr(schCate) then%>class="input"<%else%>class="inputins"<%end if%> style="width:500px;height:30px;">
												<option value="">ALL</option>	
												<%
												Dim selectS,selectE,si
												if sMenu="00" then
												    selectS = s_1st
														selectE = e_1st
												elseif  sMenu="01" then
												    selectS = s_2nd
														selectE =	e_2nd											
												end if
												for si=selectS to selectE
												   if cstr(schCate)=cstr(si) then
													     response.write "<option value='"&si&"' selected>"&photoCateAr(si)&"</option>"
													 else
													     response.write "<option value='"&si&"'>"&photoCateAr(si)&"</option>"													 
													 end if
												
												next
												%>
											  </select> 
											</td>
										<tr><td colspan='5' height='10'></td></tr>
									</table>