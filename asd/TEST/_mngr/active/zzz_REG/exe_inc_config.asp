<%


Dim searchLinkString,searchAttachStr,searchLinkJoinStr,searchString

Dim sch_fName,sch_country,sch_category,sch_lName,sch_email,sch_nameKr,sch_member,sch_reg

sch_fName		  = inSqlInjection(Trim(request("sch_fName")))
sch_lName		  = inSqlInjection(Trim(request("sch_lName")))
sch_email     = inSqlInjection(Trim(request("sch_email")))
sch_country   = inSqlInjection(Trim(request("sch_country")))
sch_category  = inSqlInjection(request("sch_category"))
sch_nameKr  = inSqlInjection(request("sch_nameKr"))
sch_member  = inSqlInjection(request("sch_member"))
sch_reg			= inSqlInjection(request("sch_reg"))

ReDim searchKeyAr(7)  ' °Ë»ö¾î¸¦ ¹è¿­¿¡ ´ãÀ½
searchKeyAr(0) = sch_fName
searchKeyAr(1) = sch_lName
searchKeyAr(2) = sch_email
searchKeyAr(3) = sch_country
searchKeyAr(4) = sch_category
searchKeyAr(5) = sch_nameKr
searchKeyAr(6) = sch_member
searchKeyAr(7) = sch_reg



For i=0 to  Ubound(searchKeyAr)
   
    If not isEmptyStr(searchKeyAr(i)) Then
        searchAttachStr = " and "    ' °Ë»ö¾î°¡ ÀÖÀ» °æ¿ì Äõ¸®¹®¿¡ and Ãß°¡
        searchLinkJoinStr = "&"    ' °Ë»ö¾î°¡ ÀÖÀ» °æ¿ì ÆäÀÌÁö¸µÅ©¿¡ ¿¬°á¹®ÀÚ Ãß°¡
        
        Select Case i
                     
            Case 0 : searchString = searchString & searchAttachStr & "fName like N'%"&searchKeyAr(i)&"%'"
                     searchLinkString = searchLinkString & searchLinkJoinStr & "sch_fName="&server.URLEncode(sch_fName)&""
                     
            Case 1 : searchString = searchString & searchAttachStr & "lName like N'%"&searchKeyAr(i)&"%'"
                     searchLinkString = searchLinkString & searchLinkJoinStr & "sch_lName="&server.URLEncode(sch_lName)&""
                     
            Case 2 : searchString = searchString & searchAttachStr & "email like N'%"&searchKeyAr(i)&"%'"
                     searchLinkString = searchLinkString & searchLinkJoinStr & "sch_email="&server.URLEncode(sch_email)&""
                     
            Case 3 : searchString = searchString & searchAttachStr & "country like N'%"&searchKeyAr(i)&"%'"
                     searchLinkString = searchLinkString & searchLinkJoinStr & "sch_country="&server.URLEncode(sch_country)&""
                     
            Case 4 :  searchString = searchString & searchAttachStr & "category = N'"&searchKeyAr(i)&"'"
                      searchLinkString = searchLinkString & searchLinkJoinStr & "sch_category="&server.URLEncode(sch_category)&""											   									
					 
           	Case 5 : searchString = searchString & searchAttachStr & "nameKr like N'%"&searchKeyAr(i)&"%'"
                     searchLinkString = searchLinkString & searchLinkJoinStr & "sch_nameKr="&server.URLEncode(sch_nameKr)&""		
										 
						
						Case 6 :  if sch_member="A" then
                          searchString = searchString & searchAttachStr & " memberCheck = 'KCA Member' "
											elseif sch_member="B" then
											    searchString = searchString & searchAttachStr & " memberCheck = 'AACR Member' "
											elseif sch_member="C" then
											    searchString = searchString & searchAttachStr & " memberCheck = 'Non-Member' "
                      end if
                      searchLinkString = searchLinkString & searchLinkJoinStr & "sch_member="&server.URLEncode(sch_member)&""				
						
						Case 7 :  if sch_reg="A" then
                          searchString = searchString & searchAttachStr & " reg_category <> 'KCA ì¶”ê³„ì‹¬í¬ì§€ì—„'  "
											elseif sch_reg="B" then
											    searchString = searchString & searchAttachStr & " reg_category = 'KCA ì¶”ê³„ì‹¬í¬ì§€ì—„'  "
                      end if
                      searchLinkString = searchLinkString & searchLinkJoinStr & "sch_reg="&server.URLEncode(sch_reg)&""				
																			 		 						 				 				 				 				 				
        End Select
    Else
        searchAttachStr = ""     ' ¿¬°á¹®ÀÚ Reset
        searchLinkJoinStr = ""
    End If
   

Next



Dim basicSql,orderTxt

basicSql = "select  *  from AAC_registration where "

if sMenu="00" then
    basicSql = basicSql&" actStatus='Y' "
		orderTxt = " order by r_idx desc "
elseif  sMenu="01" then
    basicSql = basicSql&" actStatus='Y' and pay_flag='Y'  "
		orderTxt = " order by r_idx desc "		
elseif  sMenu="02" then
    basicSql = basicSql&" actStatus='Y' and pay_flag<>'Y'  "
		orderTxt = " order by r_idx desc "
elseif  sMenu="03" then
    basicSql = basicSql&" actStatus='N' "
		orderTxt = " order by r_idx desc "		
end if		              
        
basicSql = basicSql & searchString&orderTxt






'response.write basicSql










downloadQry = basicSql
%>