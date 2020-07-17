<%
' ##############################################################################
Dim i, j, k  ' °¢ ÆäÀÌÁö¿¡¼­ »ç¿ëµÉ ·çÇÁ º¯¼ö


Public Function getUrl()
    Dim requestUrl, requestQueryStr
    requestUrl = request.ServerVariables("URL")
    requestQueryStr = request.ServerVariables("QUERY_STRING")
    if not isEmptyStr(requestQueryStr) then
        getUrl = requestUrl & "?" & requestQueryStr
    else
        getUrl = requestUrl
    end if
End Function


' ------------------------------------------------------------------------------
' SSL º¸¾È ÆäÀÌÁö·Î URL º¯°æ (2007. 07. 03)
' ------------------------------------------------------------------------------
'Function setSslPage()
'    'if request.ServerVariables("HTTPS")<>"on" then
''        Dim SecurityUrl, chGetUrl
''        if not isEmptyStr(getUrl) then
''            chGetUrl = getUrl
''            ' ¼Ò¹®ÀÚ º¯È¯½Ã ¾ÏÈ£È­ÄÚµå ¿À·ù¹ß»ıµÇ¹Ç·Î LCase ÇØÁ¦(2008. 7. 16) 
''            'chGetUrl = Replace(LCase(chGetUrl),"/index.html","/")
''            chGetUrl = Replace(chGetUrl,"/index.html","/")
''            chGetUrl = Replace(chGetUrl,"/index.html","/")
''        end if
''        'if LCase(chGetUrl) = "/index.html" then chGetUrl = "/" end if
''        SecurityUrl = "https://"&request.ServerVariables("HTTP_HOST") & chGetUrl
''        response.clear()
''        'call AlertReplace("",SecurityUrl)
''        response.redirect SecurityUrl
''    end if
'End Function

Function setSslPage()
    
		'Dim SecurityUrl, chGetUrl, returnChk
'		    returnChk = "Y"
'        if not isEmptyStr(getUrl) then
'            chGetUrl = getUrl
'            ' ¼Ò¹®ÀÚ º¯È¯½Ã ¾ÏÈ£È­ÄÚµå ¿À·ù¹ß»ıµÇ¹Ç·Î LCase ÇØÁ¦(2008. 7. 16) 
'            'chGetUrl = Replace(LCase(chGetUrl),"/index.html","/")
'            chGetUrl = Replace(chGetUrl,"/index.html","/")
'            chGetUrl = Replace(chGetUrl,"/index.html","/")
'        end if
'
'        SecurityUrl = request.ServerVariables("SERVER_NAME") & chGetUrl
'				
'				
'				if Left(SecurityUrl,4) <> "www." then
'				    SecurityUrl="www."&SecurityUrl
'						returnChk = "N"
'				end if
'				
'				
'				if request.ServerVariables("HTTPS")<>"on" then  ' º¸¾È¼­¹ö Àû¿ë½Ã returnChk = "N" Á¶Àı ¹× ¼öÁ¤
'				    SecurityUrl = "http://"&SecurityUrl
'				else
'				    SecurityUrl = "https://"&SecurityUrl
'				end if
'			  
'				
'				
'				if returnChk = "N" then
'    			  response.clear()
'    		    response.redirect SecurityUrl
'				end if

End Function


' ------------------------------------------------------------------------------
' SSL ÇØÁö ÆäÀÌÁö·Î URL º¯°æ (2007. 07. 03)
' ------------------------------------------------------------------------------
Function unSetSslPage()
    'if request.ServerVariables("HTTPS")<>"off" then
'        Dim inSecurityUrl, chGetUrl
'        if not isEmptyStr(getUrl) then
'            chGetUrl = getUrl
'            ' ¼Ò¹®ÀÚ º¯È¯½Ã ¾ÏÈ£È­ÄÚµå ¿À·ù¹ß»ıµÇ¹Ç·Î LCase ÇØÁ¦(2008. 7. 16) 
'            'chGetUrl = Replace(LCase(chGetUrl),"/index.html","/")
'            chGetUrl = Replace(chGetUrl,"/index.html","/")
'        end if
'        'if LCase(chGetUrl) = "/index.html" then chGetUrl = "/" end if
'        inSecurityUrl = "http://"&request.ServerVariables("SERVER_NAME") & chGetUrl
'        response.clear()
'        response.redirect inSecurityUrl
'    end if
End Function

Function chDateEn(strDate, opt) 
    if isDate(strDate) then  ' À¯È¿ ³¯ÀÚ °Ë»ç
        Dim userDate
        userDate = cDate(strDate)
    else
        chDateEn = ""
        exit function
    end if
    
    Dim dateMonthAr, dateMonAr
    dateMonthAr = Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
    dateMonAr   = Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
    
    Dim dateM, dateD, dateY
    dateM = month(userDate)
    dateD = day(userDate)
    dateY = year(userDate)
    
    if isNumeric(opt) then
        if opt=0 then
            chDateEn = ""
        elseif opt=1 then
            chDateEn = dateMonthAr(dateM-1) & " " & dateD & ", " & dateY
        elseif opt=2 then
            chDateEn = dateMonAr(dateM-1) & " " & dateD & ", " & dateY
        elseif opt=3 then
            chDateEn = chDateEn = dateMonAr(dateM-1) & " " & dateD
        else
            chDateen = ""
        end if
    else
        select case opt
            case "MdY" : chDateEn = dateMonthAr(dateM-1) & " " & dateD & ", " & dateY
            case "mdY" : chDateEn = dateMonAr(dateM-1) & " " & dateD & ", " & dateY
            case "m.dY" : chDateEn = dateMonAr(dateM-1) & ". " & dateD & ", " & dateY
            case "Md"  : chDateEn = dateMonthAr(dateM-1) & " " & dateD
            case "md"  : chDateEn = dateMonAr(dateM-1) & ". " & dateD
            case "M"   : chDateEn = dateMonthAr(dateM-1)
            case "m"   : chDateEn = dateMonAr(dateM-1)
						case "dMY" : chDateEn = calc(dateD,2) & " " & dateMonthAr(dateM-1) & " " & dateY
						case "YMD" : chDateEn = dateY& "-" & calc(dateM,2) & "-" & calc(dateD,2)
            case else  : chDateEn = ""
        end select
    end if
    
End Function



' ------------------------------------------------------------------------------
' 2011. 3. 9
' ÆÄÀÏ ÀĞ±â
' ADODB.Stream
' UTF-8À» Áö¿øÇÏÁö ¾Ê´Â FileSystemObject¸¦ ´ëÃ¼ÇÔ.
' ------------------------------------------------------------------------------
Function ReadTextFile(FileName, CharSet)
    Const adTypeText = 2
    
    'Create Stream object
    Dim BinaryStream
    Set BinaryStream = CreateObject("ADODB.Stream")
    
    'Specify stream type - we want To get binary data.
    BinaryStream.Type = adTypeText
    
    'Specify charset For the source text (unicode) data.
    If Len(CharSet) > 0 Then
        BinaryStream.CharSet = CharSet
    End If
    
    'Open the stream
    BinaryStream.Open
    
    'Load the file data from disk To stream object
    BinaryStream.LoadFromFile FileName
    
    'Open the stream And get binary data from the object
    ReadTextFile = BinaryStream.ReadText
End Function



Public Function stripTags(str)
    If IsNull(str) Then ' ³Î°ªÀÌ µé¾î¿Ô´Ù¸é ÇÔ¼ö Á¾·á
    		Exit Function
  	End If
    
    Dim rex
    Set rex = new RegExp
    rex.Pattern = "<[^>]+>"
    rex.Global = true
    stripTags = rex.Replace(str,"")
    Set rex = Nothing
End Function

' ------------------------------------------------------------------------------
' ¹İ¿Ã¸² ÇÔ¼ö getRound
' ------------------------------------------------------------------------------
Function getRound(varInt) 
    if not isNumeric(varInt) then
        exit Function
    end if
    
    if Fix(varInt) < varInt then 
        getRound = Fix(varInt) + 1 
    else 
        getRound = Fix(varInt) 
    end if 
End Function 

function returnNum(str)
  Dim rVal
	if not isNumeric(str) then str=0
 
	    if clng(str)=0 then
			    rVal="<font color='#cccccc'>"&formatnumber(str,0)&"</font>"
			else
			    rVal=formatnumber(str,0)
			end if
			
			
	returnNum = rVal
end function



function returnNum_noColor(str)
  Dim rVal
	if not isNumeric(str) then str=0
 
	rVal=formatnumber(str,0)
			
	returnNum_noColor = rVal
end function




' ------------------------------------------------------------------------------
' ¹è¿­°ª Á¸Àç °Ë»ç
' inArray(array,string)
' ------------------------------------------------------------------------------
Public Function inArray(arrayStr, str)
    Dim tmpInt, i
    inArray = false
    
    if not isArray(arrayStr) then exit Function end if
    
    for i=0 to Ubound(arrayStr)
        if str=arrayStr(i) then
            inArray = true
            exit for
        else
            inArray = false
        end if
    next
End Function

Function isEmptyStr(str)
   isEmptyStr = true
   if isNull(str) or isEmpty(str) then
       isEmptyStr = true
       exit function
   else
       if str="" or Len(str)=0 then
           isEmptyStr = true
       else
           isEmptyStr = false
       end if
   end if
End Function


Sub goAdminLogin()
    Dim nowURL, queryString
    nowURL = server.URLEncode(request.serverVariables("PATH_INFO"))
    queryString = server.URLEncode(trim(request.querystring))
    if not isEmptyStr(queryString) then
        nowUrl = nowURL & "?" & queryString
    end if
    
    response.clear
    response.redirect "/_mngr/login.html?goUrl=" & nowURL
    response.end
End Sub



'-------------------------------------------------------------------------------
' javascript ÇÔ¼ö alert ¸Ş¼¼Áö Ãâ·Â
' »ç¿ëÇü½Ä call alert('¿À·ùÀÔ´Ï´Ù.',1)
'-------------------------------------------------------------------------------
Public Function Alert(msg,varInt)
    Dim action  ' ¾Ë¸²Ã¢ ÀÌÈÄ close, history back µîÀÇ action ¼³Á¤
    if isNumeric(varInt) then
        action = "history.go("&varInt&")"
    else
        select case LCase(varInt)
            case "c", "close" :  action = "self.close()"
            case "/" : action = "location.href='/'"
            case "o", "oclose" :  action = "opener.location.reload();self.close();"
            case else : action = "location.href='"&varInt&"'"
        end select
    end if
    
    msg = Replace(msg,"'","\'")
    
    Alert = "<script language=""javascript"" type=""text/javascript"">" & vbcr &_
            "<!--" & vbcr &_
            "    alert('" & msg & "');" & vbcr & action & vbcr &_
            "//-->" & vbcr &_
            "</script>"
    response.write Alert
End Function



Public Function AlertReplace(msg,location)
    Dim alertMsg, action
    if not isEmptyStr(msg) then
        msg = Replace(msg,"'","\'")
        alertMsg = "alert('"&msg&"');"
    end if
    if isNumeric(location) then
        action = "history.go("&location&")"
    else
        action = "document.location.replace('"&location&"');"
    end if
    
    AlertReplace = "<script language=""javascript"" type=""text/javascript"">" & vbcr &_
                   "<!--" & vbcr &_
                   alertMsg & vbcr & action &_
                   "//-->" & vbcr &_
                   "</script>"
    response.write AlertReplace
End Function


' ------------------------------------------------------------------------------
' ¹®ÀÚ¿­À» ÁöÁ¤µÈ ÀÚ¸®¼öÀÇ ¼ıÀÚÇü TEXT·Î ¹İÈ¯
' Çü½Ä : Calc(varStr, varInt)   , ex) 1 => 01, 22=>22, 22=> 022, 1 => 0001
' ------------------------------------------------------------------------------
Public Function Calc(varStr, varInt)
    Dim newStr, i
    newStr = varStr
    
    if isEmptyStr(newStr) then
        exit Function
    end if
    
    if not isNumeric(varInt) then  ' ±æÀÌ°¡ ÁöÁ¤µÇÁö ¾Ê¾Ò°Å³ª, ¼ıÀÚÇüÀÌ ¾Æ´Ñ°æ¿ì
        'response.write ""
        exit Function
    end if
    
    if Len(newStr) < varInt then
        for i=1 to varInt-Len(newStr)
            newStr = "0" & newStr
        next
    end if
    if varStr="0" or varStr=0 then  ' ÀÔ·Â°ªÀÌ ¾ø´Â °æ¿ì °ø¹é°ª ¹İÈ¯
        newStr = "00"
    end if
    Calc = newStr
End Function




Sub isAdminChk(varLv)
    Call adminLoginKeep()
    
    Dim userID, userLV  ' ·Î±×ÀÎ Á¤º¸
    userID = base64Decode(request.Cookies("AD_userID"))  ' ¾ÆÀÌµğ
    userLV = base64Decode(request.Cookies("AD_userLV"))  ' ·¹º§

    ' ÀúÀåµÈ ·¹º§ÄíÅ°°¡ ¼ıÀÚÇüÀÎ °æ¿ì Á¤¼ö º¯È¯ (default: 0) -------------------
    if isNumeric(userLV)=true then
        userLV = Cint(userLV)
    else
        userLV = 0
    end if
    ' --------------------------------------------------------------------------
    
    ' Login ±ÇÇÑ Ã¼Å© ----------------------------------------------------------
    if not isEmptyStr(userID) and not isEmptyStr(userLV) then
        if cint(userLV)< cint(varLv) then
            response.write "<span style=""font-size:12pt; line-height:25px;""><center>±ÇÇÑÀÌ ¾ø½À´Ï´Ù.<br>" &_
                           "<a href=""javascript:history.back();""><font color=""#0066cc"">[back]</font></a></center></span>"
            response.end
        end if
    else
       call goAdminLogin()    
    end if
    ' --------------------------------------------------------------------------

End Sub
' ==============================================================================




' ·Î±×ÀÎ À¯Áö / »èÁ¦ ===========================================================
' ÀúÀåµÈ ·Î±×ÀÎ ½Ã°£À» ºñ±³ÇÏ¿© ÄíÅ° À¯Áö ½Ã°£À» ´Ã·ÁÁÜ
' ------------------------------------------------------------------------------

' °­Á¦ ·Î±×¾Æ¿ô ¼³Á¤ -----------------------------------------------------------
Sub logOutCompulsion()
    response.Cookies("AD_userID") = ""
    response.Cookies("AD_userLV") = ""
    response.Cookies("AD_userHR") = ""
    response.Cookies("AD_userID").Expires = Date - 1000
    response.Cookies("AD_userLV").Expires = Date - 1000
    response.Cookies("AD_userHR").Expires = Date - 1000
End Sub
' ------------------------------------------------------------------------------

' ·Î±×ÀÎ À¯Áö ¼³Á¤ -------------------------------------------------------------
Sub adminLoginKeep()
    Dim userID, userLV, userLoginTime  ' ·Î±×ÀÎ Á¤º¸
    userID = base64Decode(request.Cookies("AD_userID"))  ' ¾ÆÀÌµğ
    userLV = base64Decode(request.Cookies("AD_userLV"))  ' ·¹º§
    userLoginTime = base64Decode(request.Cookies("AD_userHR"))         ' ·Î±×ÀÎ ½Ã°£
    
		If isNumeric(userLoginTime) and Len(userLoginTime)=12 Then
        Dim YYMMDD, HHIISS, getUserLoginTime
        YYMMDD = Cdate (Left(userLoginTime,4)&"-"&Mid(userLoginTime,5,2)&"-"&Mid(userLoginTime,7,2))
        HHIISS = Cdate (Mid(userLoginTime,9,2)&":"&Mid(userLoginTime,11,2))
        getUserLoginTime = YYMMDD + HHIISS
		
        If not isEmptyStr(getUserLoginTime) and isDate(getUserLoginTime) Then
             if LoginKeepTime >= DateDiff("n",getUserLoginTime,now) then
                if not isEmptyStr(userID) and not isEmptyStr(userLV) then
                    ' ¾ÆÀÌµğ/·¹º§/·Î±×ÀÎ½Ã°£ µîÀÌ ¸ğµÎ À¯È¿ÇÒ¶§¸¸ ·Î±×ÀÎ À¯Áö, ÀÌ¿Ü´Â °­Á¦ ·Î±×¾Æ¿ô
                    'response.Cookies("AD_userHR") = now()
										        response.Cookies("AD_userHR") = base64Encode(Year(now) & Calc(Month(now),2) & Calc(Day(now),2) & Calc(Hour(now),2) & Calc(Minute(now),2))
                else
                    Call logOutCompulsion()
                end if
            else
                Call logOutCompulsion()
            end if
        Else
            Call logOutCompulsion()
        End If
		Else
				Call logOutCompulsion()
		End If
End Sub



Sub isAdminChk_pop(lv)
    Call adminLoginKeep()
    Dim userID, userLV  ' ·Î±×ÀÎ Á¤º¸
    userID = base64Decode(request.Cookies("AD_userID"))  ' ¾ÆÀÌµğ
    userLV = base64Decode(request.Cookies("AD_userLV"))  ' ·¹º§

    ' Login ±ÇÇÑ Ã¼Å© ----------------------------------------------------------
    if (isEmptyStr(userID) or isEmptyStr(userLV)) or cint(userLV)<cint(lv) then
        response.clear
        response.write "<script language='JavaScript' type='text/javascript'>alert('í—ˆìš©ë˜ì§€ ì•ŠëŠ” ì‚¬ìš©ìì…ë‹ˆë‹¤.');opener.location.reload();self.close();</script>"
        response.end
    end if
    ' --------------------------------------------------------------------------
    
    ' dictionary °³Ã¼ ºñ¿ò -----------------------------------------------------
   ' set ObjDic = Nothing
    ' --------------------------------------------------------------------------

End Sub


Sub isAdminChk_iframe(lv)
    Call adminLoginKeep()
    Dim userID, userLV  ' ·Î±×ÀÎ Á¤º¸
    userID = base64Decode(request.Cookies("AD_userID"))  ' ¾ÆÀÌµğ
    userLV = base64Decode(request.Cookies("AD_userLV"))  ' ·¹º§

    ' Login ±ÇÇÑ Ã¼Å© ----------------------------------------------------------
    if (isEmptyStr(userID) or isEmptyStr(userLV)) or cint(userLV)<cint(lv) then
        response.clear
        response.write "<script language='JavaScript' type='text/javascript'>alert('í—ˆìš©ë˜ì§€ ì•ŠëŠ” ì‚¬ìš©ìì…ë‹ˆë‹¤.');parent.location.reload();</script>"
        response.end
    end if
    ' --------------------------------------------------------------------------
    
    ' dictionary °³Ã¼ ºñ¿ò -----------------------------------------------------
   ' set ObjDic = Nothing
    ' --------------------------------------------------------------------------

End Sub
' ============


' Æû¿ä¼Ò¸¦ ¹Ş¾Æ¿È --------------------------------------------------------------
' ------------------------------------------------------------------------------
Function reqFmTrim(f)
    Dim vStr : vStr = f
    if Len(vStr)=0 then
        Exit Function
    end if
    
    vStr = inSqlInjection(Trim(request.form(vStr)))
    reqFmTrim = vStr
End Function



Function sendMailFreeUTF(M_FROMName, M_FROM, M_TO, M_SUBJECT, M_MAILBODY, M_FORMAT)
    'if not isTestAdmin() then
    on Error Resume Next
    'end if
	  Dim objMessage, objConfig, objField
	
    SET objMessage = Server.CreateObject("CDO.Message")
    SET objConfig = Server.CreateObject("CDO.Configuration")

    SET objField = objConfig.Fields
    
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "mail.meci.co.kr"
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "senderonly@meci.kr"'kaetogis
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "meci2318harry"'tkdcl1010010
    objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
		objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
		objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
    
    objField.update
    
    Set objMessage.Configuration = objConfig

    objMessage.Subject  = M_SUBJECT
    objMessage.From     = M_FROM
    objMessage.To       = M_TO
    If M_FORMAT=1 Then
        objMessage.HTMLBody = M_MAILBODY   ' TXT : objMessage.TextBody , HTML : objMessage.HTMLBody
        objMessage.BodyPart.Charset="UTF-8"
        objMessage.TextBodyPart.Charset="UTF-8"
        objMessage.HTMLBodyPart.Charset="UTF-8"
        objMessage.HTMLBodyPart.ContentTransferEncoding = "quoted-printable"
    Else
        objMessage.TextBody = M_MAILBODY   ' TXT : objMessage.TextBody , HTML : objMessage.HTMLBody
        objMessage.BodyPart.Charset="UTF-8"
        objMessage.TextBodyPart.Charset="UTF-8"
        objMessage.HTMLBodyPart.Charset="UTF-8"
        objMessage.TextBodyPart.ContentTransferEncoding = "quoted-printable"  
    End If
    'objMessage.AddAttachment      "file://d:\Webhost\OnPcs\TPM2006\Instructions for Review System.pdf"
    objMessage.fields.update
    
    Dim result
    
    objMessage.Send
    
    'if isTestAdmin() then
'        echobr err.number
'        response.end
'    end if
    
    set objField = Nothing
    set objMessage = nothing
    set objConfig  = nothing
    
    
    'sendMailFreeUTF = True
    if Err.number=0 then
        sendMailFreeUTF = True
    else
        sendMailFreeUTF = False
    end if
    
End Function




' ------------------------------------------------------------------------------
' Sql Injection
' inSqlInjection(sql) : inPut
' outSqlInjection(sql) : outPut
' ------------------------------------------------------------------------------
Function inSqlInjection(sql)
    if not isEmptyStr(sql) then
        sql = Replace(sql,";","&#59;")
        sql = Replace(sql,"--","&#45;&#45;")
        sql = Replace(sql,"'","&#39;")
        sql = Replace(sql,"exec(","")
    end if
    inSqlInjection = sql
End Function

Function outSqlInjection(sql)
    if not isEmptyStr(sql) then
        sql = Replace(sql,"&#59;",";")
        sql = Replace(sql,"&#45;&#45;","--")
        sql = Replace(sql,"&#39;","'")
        
        
        sql = Replace(sql,"&", "&amp;" )
        sql = Replace(sql,">", "&gt;" )
        sql = Replace(sql, "<", "&lt;" )
        sql = Replace(sql,"""", "&quot;" )
        sql = Replace(sql,"'", "&#039;" )
    else
        sql = ""
    end if
    outSqlInjection = sql
End Function 


function DeadLine(str)  ' str : 2015-02-27 23:59:59
    Dim returnVal
    returnVal=false
		if datediff("n",str,now)<=0 then  ' ¿¡¾à½Ã°£ ÀüÀÌ¸é true
	     returnVal=true
	  end if
	  DeadLine= returnVal
end function 



function cuttxt(str,l)
    Dim rV
    rV=str
    if len(rV)>l then
      rV=left(rV,l-2)&".."
    end if
    cuttxt = rV
end function



Function inSql(sql)
    if not isEmptyStr(sql) then
        sql = Replace(sql,";","&#59;")
        sql = Replace(sql,"--","&#45;&#45;")
        sql = Replace(sql,"'","&#39;")
        sql = Replace(sql,"exec(","")
    end if
    inSql = sql
End Function

Function outSql(sql)
    if not isEmptyStr(sql) then
        sql = Replace(sql,"&#59;",";")
        sql = Replace(sql,"&#45;&#45;","--")
        sql = Replace(sql,"&#39;","'")
        sql = Replace(sql,"&#40;","(")
    else
        sql = ""
    end if
    outSql = sql
End Function  



Function outSqlView(sql)
    if not isEmptyStr(sql) then
        sql = outSql(sql)
        sql = Replace(sql,"&", "&amp;" )
        sql = Replace(sql,">", "&gt;" )
        sql = Replace(sql, "<", "&lt;" )
        sql = Replace(sql,"""", "&quot;" )
        sql = Replace(sql,"'", "&#039;" )
    else
        sql = ""
    end if
    outSqlView = sql
End Function


function proc_Function(fun,msg)
    Dim rTxt,msgTxt
		
		if not isEmptyStr(msg) then
    		msgTxt = Replace(msg,"'","\'")
    end if
		
		rTxt = "<script language=""javascript"" type=""text/javascript"">" & vbcr &_
            "<!--" & vbcr 
		
		if not isEmptyStr(msgTxt) then
    		rTxt = rTxt&"  alert('"&msgTxt&"');"& vbcr 
    end if
		if not isEmptyStr(fun) then
    		rTxt = rTxt&fun& vbcr 
    end if
		
		rTxt = rTxt&"//-->" & vbcr &_
            "</script>"						
		
		response.write rTxt 				

End Function


%>