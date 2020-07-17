<script language="JavaScript" type="text/javascript">
<!--
function openpay(str){
    var winWidth = 500;
    var winHeight = 520 ;
    var x = 0;
    var y = 0;
    var url = 'active/REG/paypop.asp?ridx='+str;
    var epostwindow = window.open(url,'e_pay','left='+ x +',top='+ y +',width='+ winWidth +', height='+ winHeight +', scrollbars=yes')
    epostwindow.focus();
}


function delRestroe(str,str1){
    var msg
		if(str=='Y'){
		    msg = confirm('Î≥µÍµ¨Ï†úÌïòÏãúÍ≤†ÏäµÎãàÍπå?')
		}else{
		    msg = confirm('ÏÇ≠Ï†úÌïòÏãúÍ≤†ÏäµÎãàÍπå?')
		}
		if(msg){
        document.getElementById("procFrame").src="/_mngr/active/REG/exe_delRestore.asp?targetIdx="+str+"&cate="+str1;
		}
}	
//-->
</script>


<%
Call dbConOpen()
rs.open basicSql,dbCon,1
Dim rsCount
rsCount = rs.recordcount
Dim listLoop ' «ˆ¿Á ∆‰¿Ã¡ˆø°º≠¿« ∞°¡Æø√ ∏Ò∑œ ºˆ
Dim idxTmpNum  ' ∞‘Ω√π∞ √‚∑¬ π¯»£
If pageNo=1 Then
    idxTmpNum = rsCount + 1
Else
    idxTmpNum = rsCount - ((pageNo-1)*listCount) + 1
End If

Dim colspanCount
if adLevel=5 then
    colspanCount = 19
else
    colspanCount = 18
end if

Dim fori,htmlSignUpList
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
            								<td >&nbsp;
                             <a href="javascript:goDownLoad('/_mngr/active/REG/excel_download.asp');"><span class="buttonGreen">&nbsp;&nbsp;Í≤∞Í≥ºÎ¨º-Download&nbsp;&nbsp;</span></a>
                            </td>
                        	</tr>	
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td height="5"></td>
              </tr>
                <tr>
                <td>
                  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#999999">
                    
                    <tr>
                      <td>
                        
                        
                        <table width="100%" border="0" cellspacing="1" cellpadding="3">
                          
                          <tr  height='25' align="center" class="table7" bgcolor='#EAEBE2'>
                            <td style='padding:3px;' width="50"><nobr>No.</nobr></td>
														<td style='padding:3px;'><nobr>regCate</nobr></td>
														<td style='padding:3px;'><nobr>Email / ID</nobr></td>
														<td style='padding:3px;'><nobr>country</nobr></td>
														<td style='padding:3px;'><nobr>full Name</nobr></td>
														<td style='padding:3px;'><nobr>title</nobr></td>
														<td style='padding:3px;'><nobr>memger</nobr></td>
														<td style='padding:3px;'><nobr>category</nobr></td>
														<td style='padding:3px;'><nobr>licenceNo</nobr></td>
														<td style='padding:3px;'><nobr>affiliation</nobr></td>
														
														<td style='padding:3px;'><nobr>researchDepartment</nobr></td>
														<td style='padding:3px;'><nobr>Contact</nobr></td>
														<td style='padding:3px;'><nobr>Fee unit</nobr></td>
														<td style='padding:3px;'><nobr>Total</nobr></td>
														<td style='padding:3px;'><nobr>Paid</nobr></td>
														<td style='padding:3px;'><nobr>Method</nobr></td>
														<td style='padding:3px;'><nobr>ÏÜ°Í∏àÏù∏</nobr></td>
														<td style='padding:3px;'><nobr>Statue</nobr></td>
														<td style='padding:3px;'><nobr>C.Mail</nobr></td>
														<%if adLevel=5 then%>
														<td style='padding:3px;'>				
														<%if sMenu="03" then%>
                  					<nobr>Î≥µÍµ¨</nobr>
                  					<%else%>
														<nobr>ÏÇ≠Ï†ú</nobr>
                  					<%end if%>
														</td>
														<%end if%>
														
														

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

    Dim trbg
    Dim r_idx,s_code,email,pwd,memberCheck,memberNo,nameKr,fName,lName,title,titleOthers,category,licenceNo
		Dim affiliationKr,affiliation,researchDepartment,researchDepartmentOthers,department,country
		Dim postal,address,address_01,address_02,address_03,cityState,phone_01,phone,mobile_01,mobile
		Dim absNo,file_or,file_sv,file_up,fee_total,fee_unit,pay_method,pay_amount,in_amount,pay_flag
		Dim senderName,pay_date,actStatus,regDate,regIp,modiDate,modiIp,mailAck,mailConf,memo
    Dim pay_methodTxt,regTxt,phoneTxt,mobileTxt,senderNameTxt,id,reg_category,researchDepartmentSub
		Dim feeTotalView,pay_amountView
		Dim memberText,researchDepartmentTxt
		Dim big_category_reg,category_reg,feeAr_reg,m_01,m_02,over_65
		Dim loginTxt

    for i=1 to listLoop
        ' Eof or Bof ¿Œ ∞ÊøÏ ø°∑Ø »£√‚ -----------------------------------------
        If rs.eof=true or rs.bof=true Then
            Call dbConClose()
            Call noEntryPage()
            response.end
        End If
        
        idxTmpNum           = idxTmpNum - 1 
        
				
				r_idx                                 =  rs("r_idx")
    		s_code																=  rs("s_code")
    		email																	=  outSqlView(rs("email"))
    		pwd																		=  rs("pwd")
    		memberCheck														=  rs("memberCheck")
    		memberNo															=  outSqlView(rs("memberNo"))
				over_65 															=  outSqlView(rs("over_65"))
    		nameKr																=  outSqlView(rs("nameKr"))
    		fName																	=  outSqlView(rs("fName"))
    		lName																	=  outSqlView(rs("lName"))
				title																	=  rs("title")
    		titleOthers														=  outSqlView(rs("titleOthers"))
    		category															=  rs("category")
    		licenceNo															=  outSqlView(rs("licenceNo"))
    		affiliationKr													=  outSqlView(rs("affiliationKr"))
    		affiliation														=  outSqlView(rs("affiliation"))
    		researchDepartment										=  outSqlView(rs("researchDepartment"))
    		researchDepartmentOthers							=  outSqlView(rs("researchDepartmentOthers"))
    		department														=  outSqlView(rs("department"))
    		country																=  outSqlView(rs("country"))
    		postal																=  outSqlView(rs("postal"))
    		address																=  outSqlView(rs("address"))
    		address_01														=  outSqlView(rs("address_01"))
    		address_02														=  outSqlView(rs("address_02"))
    		address_03														=  outSqlView(rs("address_03"))
    		cityState															=  outSqlView(rs("cityState"))
    		phone_01															=  rs("phone_01")
    		phone																	=  outSqlView(rs("phone"))
    		mobile_01															=  rs("mobile_01")
    		mobile																=  outSqlView(rs("mobile"))	
    		absNo																	=  outSqlView(rs("absNo"))
    		file_or																=  outSqlView(rs("file_or"))
    		file_sv																=  rs("file_sv")
    		file_up																=  rs("file_up")
    		fee_unit															=  rs("fee_unit")
				fee_total															=  rs("fee_total")
    		pay_method														=  rs("pay_method")
    		pay_amount														=  rs("pay_amount")
    		in_amount															=  rs("in_amount")
    		pay_flag															=  rs("pay_flag")
    		senderName														=  outSqlView(rs("senderName"))
    		pay_date															=  rs("pay_date")
    		actStatus															=  rs("actStatus")
    		regDate																=  rs("regDate")
    		regIp																	=  rs("regIp")
    		modiDate															=  rs("modiDate")
    		modiIp																=  rs("modiIp")
    		mailAck																=  rs("mailAck")
    		mailConf															=  rs("mailConf")
    		memo																	=  outSqlView(rs("memo"))
				
				id																		=  outSqlView(rs("id"))
				reg_category													=  outSqlView(rs("reg_category"))
				researchDepartmentSub									=  outSqlView(rs("researchDepartmentSub"))
				
				
				
				feeTotalView    = ""
				pay_amountView  = ""
				
				if fee_unit="KRW" then
				    feeTotalView = fee_total
						pay_amountView = pay_amount
						
						big_category_reg = big_category_Kr
						category_reg		 = category_Kr
						feeAr_reg				 = feeAr_Kr
										 
				else
						feeTotalView = fee_total/100
						pay_amountView = pay_amount/100
						
						big_category_reg = big_category_En
						category_reg		 = category_En
						feeAr_reg				 = feeAr_En				
				end if
						
						
				
				
				memberText = memberCheck
				if not isEmptyStr(memberNo) then
				memberText = memberText&"<br>( "&memberNo&" )"
				end if
				if over_65="Y" then
				memberText = memberText&"<br>(<span style='color:blue;'>65ÏÑ∏ Ïù¥ÏÉÅ</span>)"
				end if
				
				if i mod 2=0 then
            trbg = " style='background:#f7f7f7' "
        else
            trbg = " style='background:#FFFFFF'  "
        end if
				
				
				if adLevel=5 then
            loginTxt = "    <table border=""0"" width='100%' cellpadding=""0"" cellspacing=""0"" style='border:solid 0px #FFF;padding:0px;'>" &_
                       "      <tr><td height='15' colspan='2'><nobr>"&email&"</nobr></td></tr>"&_
											 "      <tr><td>"&id&"</td><td align='right' style='padding-top:2px;'><img src=""_img/btn_login.gif"" alt=""Log-in"" style=""cursor:pointer;"" width=""43"" height=""15"" align=""absmiddle"" onClick=""userLogin('"&id&"','');""></td></tr>"&_
											 "    </table>" 
        else
            loginTxt = email
        end if
				
				senderNameTxt = ""
				if pay_method="B" then
    		    pay_methodTxt="Bank"
						senderNameTxt = senderName 
    		else
    		    pay_methodTxt="Card"			
				end if
				
				
				if pay_flag="Y" then
    			    regTxt = "<font color='blue'>Completed</font>"
				else
					    regTxt ="<font color='red'>ongoing</font>"
    		end if
				
				if adLevel=5 then
              regTxt = "<a href=""javascript:openpay('"&base64Encode(r_idx)&"')"">"&regTxt&"</a>"
        end if  
					
				
				
				phoneTxt   =""
				mobileTxt	 =""
				researchDepartmentTxt = ""
				
				if not isEmptyStr(phone) then
				    if fee_unit="KRW" then
						    phoneTxt = phone
						else
						    phoneTxt = phone_01&" "&phone
						end if
				end if
				
				
				
				if not isEmptyStr(mobile) then
				    if fee_unit="KRW" then
						    mobileTxt = mobile
						else
						    mobileTxt = mobile_01&" "&mobile
						end if
				end if
				
				if fee_unit="KRW" then
					  if researchDepartment="-ÏßÅÏ†ëÏûÖÎ†•-" then
				        researchDepartmentTxt =  researchDepartmentOthers
				    else
				        researchDepartmentTxt = researchDepartment
						    if researchDepartment="ÎÇ¥Í≥º" or researchDepartment="Ïô∏Í≥º" then
                    if not isEmptyStr(researchDepartmentSub) then
								        researchDepartmentTxt = researchDepartmentTxt&"<br>(&nbsp;"&replace(researchDepartmentSub,"ÏßÅÏ†ëÏûÖÎ†•",researchDepartmentOthers)&"&nbsp;)"
								    end if						 
						    end if
				    end if
				
				else
						    researchDepartmentTxt = replace(researchDepartment,"-Others-",researchDepartmentOthers)
				end if
						
				%>
        
        <tr  height='25' align="center" class="table7" <%=trbg%>>
          <td style='padding:3px;' ><nobr><%=idxTmpNum%></nobr></td>
					<td style='padding:3px;line-height:18px;' ><%=replace(reg_category,"+","+<br>")%></td>
					<td style='padding:3px;' ><nobr><%=loginTxt%></nobr></td>
					<td style='padding:3px;' ><nobr><%=country%></nobr></td>
					<td style='padding:3px;line-height:18px;' ><%if not isEmptyStr(nameKr) then%><nobr><%=nameKr%></nobr><br><%end if%><nobr><%=fName%> <%=lName%></nobr></td>
					<td style='padding:3px;' ><nobr><%=replace(title,"Other",titleOthers)%></nobr></td>
					<td style='padding:3px;' ><nobr><%=memberText%></nobr></td>
					<td style='padding:3px;' ><nobr><%=category%></nobr></td>
					
					
					
					<td style='padding:3px;' ><nobr><%=licenceNo%></nobr></td>
					<td style='padding:3px;line-height:18px;' ><nobr><%=affiliationKr%></nobr><br><nobr><%=affiliation%></nobr></td>
					<td style='padding:3px;' ><nobr><%=researchDepartmentTxt%></nobr></td>
					<td style='padding:3px;line-height:18px;' ><nobr><%=phoneTxt%></nobr><br><nobr><%=mobileTxt%></nobr></td>
					<td style='padding:3px;' ><nobr><%=fee_unit%></nobr></td>
					<td style='padding:3px;' ><nobr><%=formatnumber(feeTotalView,0)%></nobr></td>
					<td style='padding:3px;' ><nobr><%=formatnumber(pay_amountView,0)%></nobr></td>
					<td style='padding:3px;' ><nobr><%=pay_methodTxt%></nobr></td>
					<td style='padding:3px;' ><nobr><%=senderNameTxt%></nobr></td>
					<td style='padding:3px;' ><nobr><%=regTxt%></nobr></td>
					<td style='padding:3px;' ><nobr><%=mailConf%></nobr></td>
					
					<%if adLevel=5 then%>
					<td style='padding:3px;' ><nobr>
					<%if sMenu="03" then%>
          <nobr><a href="javascript:delRestroe('<%=base64Encode(r_idx)%>','Y')" style='color:#8b8b8b;'>Restore</a></nobr>
          <%else%>
					<nobr><a href="javascript:delRestroe('<%=base64Encode(r_idx)%>','N')" style='color:#8b8b8b;'>Del</a></nobr>
          <%end if%>
					</nobr></td>
					<%end if%>
														
        <%
        rs.moveNext
    next



Else
    Dim strErrMsg
    if mode="search" then
        strErrMsg = strNotFound
    else
        strErrMsg = strNoList
    end if
    htmlSignUpList = "<tr align=""center"" bgcolor='#FFFFFF'>" &_
                       "  <td style=""height:50px;"" colspan="""&colspanCount&""" align=""center"" ><font color=""#993366""><b>"&strErrMsg&"</b></font></td>" & vbcrLf &_
                       "</tr>"
		
		response.write 	htmlSignUpList								  
                      
End If

Dim rsPageCount : rsPageCount = rs.PageCount
%>


<%
Call dbConClose()    
%>


            						</table>
                      </td>
                    </tr>
                    
                  </table>
                </td>
              </tr>
              <tr><td height="10"></td></tr>
            </table>