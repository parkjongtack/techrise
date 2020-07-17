
<%
Call dbConOpen()

downloadQry = basicSql

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
                <td class="padding">
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
                            <td width="200">&nbsp;</td>
            								<!--<td >&nbsp;
                             <a href="/_mngr/active/AL/excel_download.asp"><span class="buttonGreen">&nbsp;&nbsp;EXCEL-Download&nbsp;&nbsp;</span></a>
                            </td>-->
                        	</tr>	
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td height="30"></td>
              </tr>
                <tr>
                <td>

											
											
											  <table width="100%" border="0" cellspacing="0" cellpadding="0">
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

    Dim idxNum, subject, fileName, fileSize, fileWidth, fileHeight, thumbNailImg, hit, download,subjectKr,nsubject,regDate,cate
  
		
    Dim p
		p = 0		
		
     for i=1 to listLoop
        ' Eof or Bof ¿Œ ∞ÊøÏ ø°∑Ø »£√‚ -----------------------------------------
        If rs.eof=true or rs.bof=true Then
            Call dbConClose()
            Call noEntryPage()
            response.end
        End If
				
			                               	idxNum       = rs(0)           ' ∞‘Ω√π∞ ∞Ì¿Ø π¯»£
                                      subject      = outSqlInjection(rs(1))           ' ¡¶∏Ò
																			subjectkR    = outSqlInjection(rs(2))          ' ¡¶∏Ò
                                      fileName     = rs(3)           ' ∆ƒ¿œ∏Ì
                                      fileSize     = rs(4)           ' ∆ƒ¿œøÎ∑Æ
                                      fileWidth    = rs(5)           ' ¿ÃπÃ¡ˆ width ∞™
                                      fileHeight   = rs(6)           ' ¿ÃπÃ¡ˆ height ∞™
                                      thumbNailImg = rs(7)
																			cate				 = rs(10)
																			regDate			 = left(rs(11),10)
																			if cint(fileHeight)>cint(fileWidth) then  ' ªÁ¡¯¿« ºº∑Œ∆¯¿Ã ≥Ù¿ª ∞ÊøÏ
                                          thumbNailImg = "<img src="""&thumbLocation&""&thumbNailImg&""" height="""&pvLiImgHeight&""" border=""0"" id=""thumbNailImg"" onerror=""imgOnloadErr("&i-1&")"">"
                                      else
                                          thumbNailImg = "<img src="""&thumbLocation&""&thumbNailImg&""" width="""&pvLiImgWidth&""" border=""0"" id=""thumbNailImg"" onerror=""imgOnloadErr("&i-1&")"">"
                                      end if
																			
																			nsubject = subject
																			
                                      if i=1 then
                                          response.write "<tr>"
                                      end if
																		 
																		  p=p+1 
																			
																			
																			response.write "<td width="""&pvLiImgWidth&""" align=""left"">" &_
                                                     "  <table width=""100%"" height=""107"" border=""0"" cellpadding=""0"" cellspacing=""0"" bgcolor='#FFFFFF'>" &_
                                                     "    <tr>" &_
                                                     "      <td align=""center"">" &_
                                                     "        <table width="""&pvLiImgWidth&""" height="""&pvLiImgHeight&""" border=""0"" cellpadding=""1"" cellspacing=""1"" bgcolor=""#CCCCCC"">" &_
                                                     "          <tr>" &_
                                                     "          <td bgcolor=""#FFFFFF"" align=""center"">"&thumbNailImg&"</td>" &_
                                                     "          </tr>" &_
                                                     "        </table>" &_
                                                     "      </td>" &_
                                                     "    </tr>" &_
                                                     "    <tr><td height=3></td></tr>" &_
																										 
																										 "    <tr><td height=3></td></tr>" &_
                                                     "    <tr>" &_
                                                     "      <td>" &_
                                                     "        <table width=""100%""  border=""0"" cellspacing=""0"" cellpadding=""0"">" &_
                                                     "          <tr>" &_
                                                     "            <td style=""word-wrap:break-word;font-size:11px;line-height:25px;"" align='center'><span class=""sub_text_gallery"">"&nsubject&"</span><br>"&_
																										 "            <a href='/_mngr/active/GALLERY/edit.asp?idx="&base64Encode(idxNum)&"' class='simple-ajax-popup-align-top'  style='text-decoration: none;'><span style='padding:5px 10px;cursor:pointer;border:0px solid #ccc; font-size:12px;color:#fff; background:#82c041; text-align:center;'><strong>ÏàòÏ†ï</strong></span></a>&nbsp;&nbsp;&nbsp;"
																										 
																										 
																										 'if sMenu="01" then
																	'response.write     "    				<span onclick=""ressubfom('"&base64Encode(idxNum)&"');"" style='padding:5px 10px;cursor:pointer;border:0px solid #ccc; font-size:12px;color:#fff; background:#c0c0c0; text-align:center;'><strong>Î≥µÍµ¨</strong></span>"
																	'else 									 
																	response.write     "            <span onclick=""delsubfom('"&base64Encode(idxNum)&"');""  style='padding:5px 10px;cursor:pointer;border:0px solid #ccc; font-size:12px;color:#fff; background:#c0c0c0; text-align:center;'><strong>ÏÇ≠Ï†ú</strong></span>"
																	'end if
																	
																										 
																										 
																	response.write     "            </td>" &_
                                                     "          </tr>" &_
                                                     "        </table>" &_
                                                     "      </td>" &_
                                                     "    </tr>" &_
                                                     "  </table>" &_
                                                     "</td>"
																		 
																		 
																		 
																		  if i>=listColCount then
                                          if i mod listColCount = 0 then  ' ¡ŸπŸ≤ﬁ
																					    p=0
                                              response.write "</tr>" &_
                                                             "<tr>" &_
                                                             "  <td colspan="""&listColCount+listColCount-1&""" height='40'>&nbsp;</td>" &_
                                                             "</tr>"    
																							if i < listLoop then
																							    response.write "<tr>" 
																							end if								               
                                          else
                                              if p < listColCount then
                                                response.write "<td width=""20"">&nbsp;</td>"  ' ¿ÃπÃ¡ˆøÕ ¿ÃπÃ¡ˆ ∞£ ∞£∞›
																							end if
                                          end if
                                      else
                                          if p < listColCount then
                                              response.write "<td width=""20"">&nbsp;</td>"  ' ¿ÃπÃ¡ˆøÕ ¿ÃπÃ¡ˆ ∞£ ∞£∞›
																					end if
                                      end if

																										 

		        rs.moveNext
    next
		
		
	                              	if p>0 then
                                       for j=p+1 to listColCount
																			     response.write "<td width="""&pvLiImgWidth&""">&nbsp;</td>"
																					 if j < listColCount then
    																					 response.write "<td width=""20"">&nbsp;</td>"
																					 end if
                                       next
																			 response.write "</tr>" 
                                  end if

End If
rsPageCount = rs.PageCount
Call dbConClose()    		



%>		            		

											  </table>
												

												
												
												
												
               </td>
             </tr>
             <tr><td height="10"></td></tr>
           </table>                        											