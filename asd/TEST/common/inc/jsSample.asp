<script language="JavaScript" type="text/javascript">
<!--



var sampleAuthor  =  "<table border='0' cellspacing='0' cellpadding='0' class='table_aus' width='100%' style='margin-bottom:5px;'>";
		sampleAuthor +=  "        <tr>";
    sampleAuthor +=  "          <th width='16%' align='center' style='text-align:center;line-height:30px;' rowspan='5' bgcolor='#FAFAFA'>";
		sampleAuthor +=  "          <div id='p_txt_<$$$autNo$$$>' style='color:#ff6600;border:1px solid #ff6600;padding:5px;width:80px;margin: 0 auto;display:none;'>Presenter</div>";
		sampleAuthor +=  "          <div id='p_txt_temp_<$$$autNo$$$>' style='height:5px;display:none;'></div>";
		sampleAuthor +=  "          Authors  # <span id='p_authorNo_<$$$autNo$$$>' style='color:#124e87;font-size:16px;font-weight:500;'></span>";
		sampleAuthor +=  "					<div style='margin:0 auto;width:70px;'>";
		sampleAuthor +=  "					<div class='list_btn_on' style='height:20px;line-height:20px;width:20px;float:left;margin-right:5px;'  id='p_authorUp_<$$$autNo$$$>' onclick=\"moveAuthor(this,'up')\">▲</div>";
		sampleAuthor +=  "					<div class='list_btn_on' style='height:20px;line-height:20px;width:20px;float:left;'  id='p_authorDown_<$$$autNo$$$>' onclick=\"moveAuthor(this,'down')\">▼</div>";
		sampleAuthor +=  "					<div class='list_btn_on' style='height:20px;line-height:20px;width:20px;float:left;margin-left:5px;' id='p_authorDel_<$$$autNo$$$>' onclick='deleteAuthor(this)'>X</div>";
		sampleAuthor +=  "					</div>";
		sampleAuthor +=  "			    </td>";
    sampleAuthor +=  "          <th width='15%'  align='center' bgcolor='#F5F7FA'>Prefix</th>";
		sampleAuthor +=  "					<td width='27%' style='padding-left:10px;'><input type='text' name='au_prefix' id='au_prefix_<$$$autNo$$$>'  class='input_abs' style='width:90%;' maxlength='40' ></td>";
    sampleAuthor +=  "          <th width='15%' align='center' bgcolor='#F5F7FA'>Degree</th>";
		sampleAuthor +=  "					<td width='27%' style='padding-left:10px;'><input type='text' name='au_degree' id='au_degree_<$$$autNo$$$>'  class='input_abs' style='width:90%;' maxlength='40' ></td>";
    sampleAuthor +=  "        </tr>";
		
		sampleAuthor +=  "        <tr>";
    sampleAuthor +=  "          <th align='center' bgcolor='#F5F7FA'>First Name</th>";
		sampleAuthor +=  "					<td style='padding-left:10px;'><input type='text' name='au_fName' id='au_fName_<$$$autNo$$$>'  class='input_abs' style='width:90%;' maxlength='40' ></td>";
    sampleAuthor +=  "          <th align='center' bgcolor='#F5F7FA'>Last Name</th>";
		sampleAuthor +=  "					<td style='padding-left:10px;'><input type='text' name='au_lName' id='au_lName_<$$$autNo$$$>'  class='input_abs' style='width:90%;' maxlength='40' ></td>";
    sampleAuthor +=  "        </tr>";
				
											
		sampleAuthor +=  "				<tr>";
		sampleAuthor +=  "				  <th align='center' bgcolor='#F5F7FA'>Department</th>";
		sampleAuthor +=  "					<td style='padding-left:10px;' colspan='3'>";
		
		sampleAuthor +=  "        		<table cellspacing='0' cellpadding='0'  width='90%' border='0'>";
		sampleAuthor +=  "       				<tr>";
		sampleAuthor +=  "        			  <td style='border:0px;padding:0px;width:60%;'><input type='text' name='au_department' id='au_department_<$$$autNo$$$>' class='input_abs' onblur='makeSelect()'  style='width:100%;ime-mode:disabled;' onKeyUp='//noHanGle(this);' maxlength='100'></td>";
		sampleAuthor +=  "        				<td style='border:0px;padding:0px 0px 0px 7%;'>";
    sampleAuthor +=  "        				<select name='au_department_tmp' id='au_department_tmp_<$$$autNo$$$>'  onChange='au_department_insert(<$$$autNo$$$>);'  style='width:23px;padding:0px;border:0px;' class='input_abs'>";
    sampleAuthor +=  "        		    <option value=''>== select ==</option>";
    sampleAuthor +=  "        				</select>";
		sampleAuthor +=  "        			  </td>";
		sampleAuthor +=  "        			</tr>";
		sampleAuthor +=  "        		</table>";	
		
		sampleAuthor +=  "          </td>";
		sampleAuthor +=  "        </tr>";
											
		sampleAuthor +=  "				<tr>";
		sampleAuthor +=  "					<th align='center' bgcolor='#F5F7FA'>Affiliation</th>";
		sampleAuthor +=  "					<td style='padding-left:10px;' colspan='3'>";
		
		
		
		sampleAuthor +=  "        		<table cellspacing='0' cellpadding='0'  width='90%' border='0'>";
		sampleAuthor +=  "       				<tr>";
		sampleAuthor +=  "        			  <td style='border:0px;padding:0px;width:60%;'><input type='text' name='au_organization' id='au_organization_<$$$autNo$$$>'  class='input_abs' onblur='makeSelect()' size='8' style='width:100%;ime-mode:disabled;' onKeyUp='//noHanGle(this);' maxlength='100'></td>";
		sampleAuthor +=  "        				<td style='border:0px;padding:0px 0px 0px 7%;'>";
    sampleAuthor +=  "        				<select name='au_organization_tmp' id='au_organization_tmp_<$$$autNo$$$>'  onChange='au_organization_insert(<$$$autNo$$$>);'  style='width:23px;padding:0px;border:0px;' class='input_abs'>";
    sampleAuthor +=  "        		    <option value=''>== select ==</option>";
    sampleAuthor +=  "        				</select>";
		sampleAuthor +=  "        			  </td>";
		sampleAuthor +=  "        			</tr>";
		sampleAuthor +=  "        		</table>";	
		
		
		
		sampleAuthor +=  "        	</td>";
		sampleAuthor +=  "				</tr>";
						
		sampleAuthor +=  "				<tr>	";
    sampleAuthor +=  "  				<th align='center' bgcolor='#F5F7FA'>Country</th>";
		sampleAuthor +=  "					<td style='padding-left:10px;'>";
		
		sampleAuthor +=  "					<input type='text' name='au_country_temp' id='au_country_temp_<$$$autNo$$$>' value='<%=outSql(country)%>'  style='width:90%;padding-right:0px;display:none;' readOnly class='noneInput' >";
		
		sampleAuthor +=  "					<select name='au_country' id='au_country_<$$$autNo$$$>'  style='width:90%;padding-right:0px;' class='input_abs'>";
		sampleAuthor +=  "					<%abs_countryListSelect(country)%>";
    sampleAuthor +=  "      	  </select>";
		sampleAuthor +=  "					</td>";
    sampleAuthor +=  "  				<th width='130' align='center' bgcolor='#F5F7FA'>Email</th>";
		sampleAuthor +=  "					<td style='padding-left:10px;'><input type='text' name='au_email'  id='au_email_<$$$autNo$$$>'  class='input_abs'  style='width:90%;ime-mode:disabled;' maxlength='80' onFocusOut='//chk_isMailChars(this);'></td>";
		sampleAuthor +=  "				</tr>";
		sampleAuthor +=  "				<tr style='display:none;'>";
		sampleAuthor +=  "					<td colspan='4' style='padding-left:15%;'>&nbsp;&nbsp;&nbsp;";
		sampleAuthor +=  "					<input type='radio' name='p_preChk' id='p_preChk_<$$$autNo$$$>' >&nbsp;Presenting Author&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		sampleAuthor +=  "					<input type='radio' name='p_corChk' id='p_corChk_<$$$autNo$$$>' >&nbsp;Corresponding Author";
		sampleAuthor +=  "					</td>";
    sampleAuthor +=  "  			</tr>";
		sampleAuthor +=  "		  </table>";
		
//-->
</script>