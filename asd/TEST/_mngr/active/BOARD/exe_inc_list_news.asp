<%
Call dbConOpen()

rs.open basicSql,dbCon,1
rsCount = rs.recordcount

If pageNo=1 Then
    idxTmpNum = rsCount + 1
Else
    idxTmpNum = rsCount - ((pageNo-1)*listCount) + 1
End If

%>

            <table width="100%" border="0" cellspacing="0" cellpadding="0" >
              <tr>
                <td class="padding" colspan="2">
                  <table border="0" cellspacing="0" cellpadding="0">
                    <tr class="bold_txt">
                      <td height="28">
                        <table width="100%" border="0" cellpadding="5" cellspacing="0">
                          <tr class="bold_txt">
                            <td width="90" height="28">Total : <span class="red_txt"><%=formatNumber(rsCount,0)%></span></td>
                            <td width="26"  ><img src="images/menu_line01.gif" width="21" height="12"></td>
                            <td width="100"  >Page : <span class="red_txt"><%=pageNo%></span><span class="green_txt"> / <%=getRound(rsCount/listCount)%></span></td>
                            <td width="26"  ><img src="/a_admin/images/menu_line01.gif" width="21" height="12"></td>
                            <td >
                              <select name="listViewCnt" class="input" onChange="goListUp(this.value,'menuIdx=<%=menuIdx%>&sMenu=<%=sMenu%>&bMenu=<%=bMenu%>&mCate=<%=mCate%><%=searchLinkString%>');">
                                <option value="">Î™©Î°ùÏàò</option>
            										<option value="5"<% if listCount=5 then %> selected<% end if %>>5</option>
                                <option value="10"<% if listCount=10 then %> selected<% end if %>>10</option>
                                <option value="20"<% if listCount=20 then %> selected<% end if %>>20</option>
                                <option value="30"<% if listCount=30 then %> selected<% end if %>>30</option>
                                <option value="50"<% if listCount=50 then %> selected<% end if %>>50</option>
                                <option value="100"<% if listCount=100 then %> selected<% end if %>>100</option>
                              </select>
                              List<font style="font-weight:normal; font-size:8pt;"> / Page</font>
                            </td>
                        	</tr>	
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td height="5" colspan="2"></td>
              </tr>
							<tr>  
								<td valign="top">
								
								  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
                    
                    <tr>
                      <td>
								
                        <table width="100%" border="0" cellspacing="1" cellpadding="3">
                          
                          <tr  height='25' align="center" class="table7" bgcolor='#EAEBE2'>
                            <td style='padding:3px;' width="50"><nobr>No.</nobr></td>
														<td style='padding:3px;'><nobr>Subject</nobr></td>
														<td style='padding:3px;'><nobr>Date</nobr></td>
                          </tr> 
<%
If rsCount>0 Then  ' ∞‘Ω√π∞¿Ã ¿÷¥¬ ∞ÊøÏ...
    rs.pageSize     = listCount  ' ∆‰¿Ã¡ˆ¥Á ∞‘Ω√π∞ ºˆ (listCount = 10)
    rs.AbsolutePage = pageNo     ' «ˆ¿Á ∆‰¿Ã¡ˆ π¯»£

    ' ∑πƒ⁄µÂº¬¿« ∆‰¿Ã¡ˆ ºˆøÕ «ˆ¿Á ∆‰¿Ã¡ˆ π¯»£∞° ∞∞¿∏∏È
    if rs.PageCount = pageNo then
       ' «ˆ¿Á∆‰¿Ã¡ˆ¿« ∞‘Ω√π∞ ºˆ = ¿¸√º ∞‘Ω√π∞ ºˆ∏¶ ∆‰¿Ã¡ˆ¥Á ∞‘Ω√π∞ ºˆ∑Œ ≥™¥Æ
        listLoop = rsCount mod rs.PageSize
        if listLoop=0 then listLoop = rs.PageSize end if
    else
        listLoop  = rs.PageSize  ' π¯»£∞° ¥Ÿ∏•∞ÊøÏ 
    end if

    Dim idx,title,content,view_date,file_or,file_sv,link_txt,b_hit,b_langCheck,file_or_list,file_sv_list
		
		for i=1 to listLoop
        ' Eof or Bof ¿Œ ∞ÊøÏ ø°∑Ø »£√‚ -----------------------------------------
        If rs.eof=true or rs.bof=true Then
            Call dbConClose()
            Call noEntryPage()
            response.end
        End If
        
        idxTmpNum           = idxTmpNum - 1 
        
				idx									=  rs("idx")
				boardCate						=  rs("boardCate")
				title								=  outSql(rs("title"))
				content							=  rs("content")
				view_date						=  rs("view_date")
				file_or							=  rs("file_or")
				file_sv							=  rs("file_sv")
				link_txt						=  rs("link_txt")
				b_hit								=  rs("b_hit")
				b_langCheck					=  rs("b_langCheck")
				
				file_or_list				=  rs("file_or_list")
				file_sv_list				=  rs("file_sv_list")
				
				if i mod 2=0 then
            trbg = " style='background:#f7f7f7' "
        else
            trbg = " style='background:#FFFFFF'  "
        end if

				%>
        
                          <tr  height='25' align="center" class="table7" <%=trbg%>>
                            <td style='padding:3px;' ><nobr><%=idxTmpNum%></nobr></td>
                  					<td style='padding:3px 20pc 3px 20px;' align='left' ><a href='/_mngr/active/BOARD/view.asp?bIdx=<%=base64Encode(idx)%>' class='simple-ajax-popup-align-top'  style='text-decoration: none;'><%=title%></a></td>
                  					<td style='padding:3px;' width="100"><nobr><%=view_date%></nobr></td>
                  				</tr>	
        <%
        rs.moveNext
    next
    



End If

%>													
								        </table>
											</td>	
									  </tr>
									</table>			
												
								</td>
								<td style='padding-left:20px;' valign='top' width="700">
								<iframe src="about:blank" id="writeDiv" width="95%" height="630" frameborder="0"></iframe>   			
								</td>
              </tr>
              <tr><td height="10" colspan="2"></td></tr>

<%
rsPageCount = rs.PageCount
Call dbConClose()    
%>		 
            </table> 