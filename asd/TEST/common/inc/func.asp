<%
' ##############################################################################
' 페이지에 사용될 함수 모음
' 작성일 : 2006. 08. 07
' 수정일 : 2010. 01. 07
' ##############################################################################
Dim i, j, k  ' 각 페이지에서 사용될 루프 변수

'-------------------------------------------------------------------------------
' echo : response.write 테스트 용도로만 쓰임
'-------------------------------------------------------------------------------
Public Sub echo(str)
    If isEmpty(str) or isNull(str) Then
        Exit Sub
    End if
    response.write(str)
End Sub

Public Sub echobr(str)
    If isEmpty(str) or isNull(str) Then
        response.write "<br>"
        Exit Sub
    End if
    response.write(str&"<br>")
End Sub
' ------------------------------------------------------------------------------


' ------------------------------------------------------------------------------
' Server Variables
' ------------------------------------------------------------------------------
Public Sub getServerInfo()
    Dim servItem, sv_value
    response.write "<table border=1 cellspacing=0 cellpadding=3>"
    i=1
    FOR EACH servItem in request.ServerVariables
        response.write "<tr>"
        response.write "<td>"&i&"</td>"
        response.write "<td>"&servItem&"</td>"
        if request.servervariables(servItem).item = "" then
           sv_value="&nbsp;"
        else
           sv_value=request.servervariables(servItem).item
        end if
        response.write "<td>"&sv_value&"</td>"
        
        response.write "</tr>"
        i=i+1
    Next
    response.write "</table>"
End Sub



' ------------------------------------------------------------------------------
' 현재 페이지의 URL을 가져옴(절대 경로) => /test/test.asp?asdf=asdf < %= getUrl()% >
' ------------------------------------------------------------------------------
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
' 도메인(호스트)을 가져옴. www.domain.com
' ------------------------------------------------------------------------------
Public Function getHost()
    Dim requestHost
    requestHost = request.ServerVariables("HTTP_HOST")
    getHost = requestHost
End Function

' ------------------------------------------------------------------------------
' 이전 접근 경로. http://www.domain.com/mail.asp
' ------------------------------------------------------------------------------
Public Function getReferer()
    Dim requestRef
    requestRef = request.ServerVariables("HTTP_REFERER")
    getReferer = requestRef
End Function


' ------------------------------------------------------------------------------
' String의 공백 여부 체크
' if isEmptyStr(string) then
'     ' 빈값인 경우(true) 실행
' else
'     ' 값이 있을 경우(false) 실행
' end if
' ------------------------------------------------------------------------------
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



' ------------------------------------------------------------------------------
' 대소문자 구분없이 Replace
' ------------------------------------------------------------------------------
Public Function ReplaceNoCase(allText, findText, replaceText)
    if isEmpty(allText) then exit Function end if
    if isEmpty(findText) then exit Function end if
    if isEmpty(replaceText) then exit Function end if
    
    Dim regObj
    Set regObj        = New RegExp 
    regObj.Pattern    = findText   ' 패턴설정
    regObj.IgnoreCase = True       ' 대소문자 구분 여부
    regObj.Global     = True       ' 전체 문서에서 검색
    
    Dim tmpStr
    tmpStr = regObj.Replace(allText, replaceText)

    'if tmpStr = Ucase(replaceText) then
    '    ReplaceNoCase = replaceText
    'else
    '    ReplaceNoCase = tmpStr
    'end if
    ReplaceNoCase = tmpStr
    
End Function 


' ------------------------------------------------------------------------------
' html => text로 변형
' ------------------------------------------------------------------------------
Public Function strTags(str)
    str = Replace(str,"<","&lt;")
    str = Replace(str,">","&gt;")
    strTags = str
End Function

Public Function stripTags(str)
    If IsNull(str) Then ' 널값이 들어왔다면 함수 종료
    		Exit Function
  	End If
    
    Dim rex
    Set rex = new RegExp
    rex.Pattern = "<[^>]+>"
    rex.Global = true
    stripTags = rex.Replace(str,"")
    Set rex = Nothing
End Function

Public Function subStripTags(str)  ' <sub></sub>, <sup></sup> 를 제외한 태크 제거
    if not isEmptyStr(str) then
        str = Replace(str,"<sup>","$$$sup$$$")
        str = Replace(str,"</sup>","$$$/sup$$$")
        str = Replace(str,"<sub>","$$$sub$$$")
        str = Replace(str,"</sub>","$$$/sub$$$")
        str = strTags(str)
        str = Replace(str,"$$$sup$$$","<sup>")
        str = Replace(str,"$$$/sup$$$","</sup>")
        str = Replace(str,"$$$sub$$$","<sub>")
        str = Replace(str,"$$$/sub$$$","</sub>")
    end if
    subStripTags = str
End Function



Sub loginTrue_pop(str) ' 로그인 유무만 판단
   Dim alertTxt
	 alertTxt = "<script language=""javascript"" type=""text/javascript"">" & vbcr &_
            			"<!--" & vbcr 
	if not isEmptyStr(str) then
      alertTxt =alertTxt&"alert('"&str&"');"	 
	end if								
  alertTxt =alertTxt&" self.close();opener.location.reload();" & vbcr &_
            			"//-->" & vbcr &_
            			"</script>"
	 								
   response.write alertTxt
				 
End Sub


Sub pop_go(str,act) ' 로그인 유무만 판단
  Dim alertTxt
	alertTxt = "<script language=""javascript"" type=""text/javascript"">" & vbcr &_
            			"<!--" & vbcr 
	if not isEmptyStr(str) then
      alertTxt =alertTxt&"alert('"&str&"');"	 
	end if								
  alertTxt =alertTxt&" location.href='"&act&"';opener.location.reload();" & vbcr &_
            			"//-->" & vbcr &_
            			"</script>"
	 								
   response.write alertTxt
				 
End Sub


Sub pop_close(str) ' 로그인 유무만 판단
  Dim alertTxt
	alertTxt = "<script language=""javascript"" type=""text/javascript"">" & vbcr &_
            			"<!--" & vbcr 
	if not isEmptyStr(str) then
      alertTxt =alertTxt&"alert('"&str&"');"	 
	end if								
  alertTxt =alertTxt&" opener.location.reload();self.close();" & vbcr &_
            			"//-->" & vbcr &_
            			"</script>"
	 								
   response.write alertTxt
				 
End Sub


Sub pop_parent() ' 로그인 유무만 판단
  Dim alertTxt
	alertTxt = "<script language=""javascript"" type=""text/javascript"">" & vbcr &_
            			"<!--" & vbcr 
  alertTxt =alertTxt&" parent.location.reload();" & vbcr &_
            			"//-->" & vbcr &_
            			"</script>"
	 								
   response.write alertTxt
				 
End Sub

'-------------------------------------------------------------------------------
' javascript 함수 alert 메세지 출력
' 사용형식 call alert('오류입니다.',1)
'-------------------------------------------------------------------------------
Public Function Alert(msg,varInt)
    Dim action  ' 알림창 이후 close, history back 등의 action 설정
    if isNumeric(varInt) then
        action = "history.go("&varInt&")"
    else
        select case LCase(varInt)
            case "c", "close" :  action = "self.close()"
            case "o", "close" :  action = "opener.location.reload();self.close();"
            case "p", "close" :  action = "parent.location.reload()"
            case "/" : action = "location.href='/'"
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
' htmlMetaRefresh
' varContent : 유지시간,  varUrl : 이동페이지
' ------------------------------------------------------------------------------
Public Sub htmlMetaRefresh(varContent, varUrl)
    response.write "<meta http-equiv=""refresh"" content="""&varContent&"; URL="&varUrl&""">"
End Sub




' ------------------------------------------------------------------------------
' 문자열을 지정된 자리수의 숫자형 TEXT로 반환
' 형식 : Calc(varStr, varInt)   , ex) 1 => 01, 22=>22, 22=> 022, 1 => 0001
' ------------------------------------------------------------------------------
Public Function Calc(varStr, varInt)
    Dim newStr, i
    newStr = varStr
    
    if isEmptyStr(newStr) then
        exit Function
    end if
    
    if not isNumeric(varInt) then  ' 길이가 지정되지 않았거나, 숫자형이 아닌경우
        'response.write ""
        exit Function
    end if
    
    if Len(newStr) < varInt then
        for i=1 to varInt-Len(newStr)
            newStr = "0" & newStr
        next
    end if
    if varStr="0" or varStr=0 then  ' 입력값이 없는 경우 공백값 반환
        newStr = "00"
    end if
    Calc = newStr
End Function



' ------------------------------------------------------------------------------
' 반올림 함수 getRound
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


' ------------------------------------------------------------------------------
' 지정된 자릿수 만큼 반올림 getRoundFormat(수, 자리수) - 2009. 1. 23
' ------------------------------------------------------------------------------
Function getRoundFormat(varInt, val)
    If not isNumeric(varInt) or not isNumeric(val) Then
        Exit Function
    End If
    
    Dim newInt, valCount
    newInt = Round(varInt,0)
    
    If Len(newInt) <= val Then
        Exit Function
    End If
    
    Dim i
    If val>1 Then
        valcount = 1
        for i=1 to val-1
            valCount = valCount * 10
        next
    Else
        valCount = 1
    End If

    If val=0 Then
        newInt = newInt  ' 변화 없음
    ElseIf CLng(Right(newInt,val)) >= 5*valCount Then
        newInt = (Left(newInt, Len(newInt)-val)+1)*valCount*10  ' 반올림
    Else
        newInt = Left(newInt, Len(newInt)-val) * valCount*10    ' 반내림
    End If
        
    getRoundFormat = newInt
    
End Function
' ------------------------------------------------------------------------------


' ------------------------------------------------------------------------------
' 배열값 존재 검사
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


' ------------------------------------------------------------------------------
' 배열 Merge
' 두개의 배열을 한개의 배열로 재 선언
' ------------------------------------------------------------------------------
Function arrayMerge(arr1, arr2)
    If Not isArray(arr1) or Not isArray(arr2) Then
        Response.write "Not Array"
        Exit Function
    End If
    
    Dim array1, array2
    array1 = arr1
    array2 = arr2
    
    ' 두 배열의 크기 합
    Dim arrCnt : arrCnt = UBound(array1) + UBound(array2) + 1
    
    Dim i, j, k  ' 공통 변수 초기화
    ReDim newArray(arrCnt)  ' 배열 선언
    
    For i=0 to arrCnt
        ' 첫번째 배열을 새로운 배열에 삽입
        for j=0 to UBound(array1)
            newArray(i) = array1(j)
            i = i+1
        next
        
        ' 두번째 배열을 새로운 배열에 추가
        for k=0 to UBound(array2)
            newArray(i) = array2(k)
            i = i+1
        next
    Next
    arrayMerge = newArray
End Function


' ------------------------------------------------------------------------------
' 게시판에서 idx가 NULL 이거나 빈값일때 에러 메시지 호출
' call noEntryPage()
' ------------------------------------------------------------------------------
Public Function noEntryPage()
    Dim Msg_NoEntryPage
    Msg_NoEntryPage = "We’re sorry, but there is no this site. Web page that matches your entry.<br>You may wish to try another entry."
    response.clear()
    response.write Msg_NoEntryPage  ' noEntry Text 출력
    response.write " <a href=""javascript:history.back();"">back</a>"
    response.end
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
				
    else
        sql = ""
    end if
    inSqlInjection = sql
End Function

Function outSqlInjection(sql)
    if not isEmptyStr(sql) then
        sql = Replace(sql,"&#59;",";")
        sql = Replace(sql,"&#45;&#45;","--")
        sql = Replace(sql,"&#39;","'")
        sql = Replace(sql,"&#40;","(")
        
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




' 폼요소를 받아옴 --------------------------------------------------------------
' ------------------------------------------------------------------------------
Function reqFmTrim(f)
    Dim vStr : vStr = f
    if Len(vStr)=0 then
        Exit Function
    end if
    
    vStr = inSqlInjection(Trim(request.form(vStr)))
    reqFmTrim = vStr
End Function


' ------------------------------------------------------------------------------
' 폼을 배열로 받을때 쉼표(,) 문자열 치환
' ------------------------------------------------------------------------------
Function inSplitComma(str)
    if not isEmpty(str) then
        str = Replace(str,",","&#44;")
    end if
    inSplitComma = str
End Function

Function outSplitComma(str)
    if not isEmpty(str) then
        str = Replace(str,"&#44;",",")
    end if
    outSplitComma = str
End Function



' ------------------------------------------------------------------------------
' 영문표기 일자로 변경
' ------------------------------------------------------------------------------
Function chDateEn(strDate, opt) 
    if isDate(strDate) then  ' 유효 날자 검사
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
						case "dMY-" : chDateEn = calc(dateD,2) & "-" & dateMonthAr(dateM-1) & "-" & dateY
						case "YMD" : chDateEn = dateY& "-" & calc(dateM,2) & "-" & calc(dateD,2)
            case else  : chDateEn = ""
        end select
    end if
    
End Function





' ------------------------------------------------------------------------------
' 게시판에서 자동링크 함수
' Function Name    : regular_replace
' Description      : 정규표현식을 이용한 대치
'
' Function Name    : autoLink
' Description      : 문서에 있는 Url를 찾아내어  자동으로 링크
' ------------------------------------------------------------------------------
Function eregi_replace(pattern, replace, text)
    Dim eregObj
    
    Set eregObj= New RegExp
    eregObj.Pattern= pattern ' Set Pattern(패턴 설정)
    eregObj.IgnoreCase    = True ' Set Case Insensitivity(대소문자 구분 여부)
    eregObj.Global= True ' Set All Replace(전체 문서에서 검색)
    
    eregi_replace = eregObj.Replace(text, replace)    ' Replace String
    Set eregObj = Nothing
End Function

Function autoLink(text)
    Dim regex_file, regex_http, regex_mail
    regex_file="gz|tgz|tar|gzip|zip|rar|mpeg|mpg|exe|rpm|dep|rm|ram|asf|ace|viv|avi|mid|gif|jpg|png|bmp|eps|mov"
    regex_http ="(http|https|ftp|telnet|news):\/\/(([\xA1-\xFEa-z0-9_\-]+\.[][\xA1-\xFEa-z0-9:;&#@=_~%\?\/\.\,\+\-]+)(\/|[\.]*[a-z0-9]))"
    regex_mail ="([\xA1-\xFEa-z0-9_\.\-]+)@([\xA1-\xFEa-z0-9_\-]+\.[a-z0-9\-\._\-]+[\.]*[\xA1-\xFEa-z0-9\?=]*)"
    
    ' img tag 와 a tag 의 경우 링크가 여러줄에 걸쳐 이루어져 있을 경우
    ' 이를 한줄로 합침 (합치면서 부가 옵션들은 모두 삭제함)
    'text = eregi_replace("<(a|img)[^>]*(href|src)[^>]*(" & regex_http &"|mailto:" & regex_mail & ")[^>]*>","<$1 $2=""$3"">", text)
    text = eregi_replace("<(a)[^>]*(href)[^>]*(" & regex_http & "|mailto:" & regex_mail & ")[^>]*>","<$1 $2=""$3"">", text)
    
    ' 특수문자와 링크시 target 삭제
    text = eregi_replace("&(quot|gt|lt)","!$1", text)
    
    ' html 사용시 Link 보호
    text = eregi_replace("class='MIME' href=""(" & regex_http & ")""[^>]*>","class='MIME' href=""$2_orig://$3"" target=""_blank"">", text)
    text = eregi_replace("class='MIME' href=""mailto:(" & regex_mail & ")"">","class='MIME' href=""mailto:$2#-#$3"">", text)
    text = eregi_replace("(background|codebase|src)[ \n]*=[\n""' ]*(" & regex_http & ")[""']*","$1=""$3_orig://$4""",text)
    
    '링크가 안된 Url및 Email Address 자동 링크
    text = eregi_replace("(" & regex_http & ")" ,"<a class='MIME' href=""$1""target=""_blank"">$1</a>", text)
    text = eregi_replace("(" & regex_mail & ")","<a class='MIME' href=""mailto:$1"">$1</a>", text)
    
    ' 보호를 위해 치환된것 복구
    text = eregi_replace("!(quot|gt|lt)","&$1", text)
    text = eregi_replace("(http|https|ftp|telnet|news|mms)_orig","$1", text)
    text = eregi_replace("#-#","@",text)
    
    ' File Link시 Target을 삭제
    text = eregi_replace("(\.(" & regex_file & ")"") target=""_blank""","$1",text)
    
    autoLink = text
End Function



' ------------------------------------------------------------------------------
' 정규 표현식 체크
' ------------------------------------------------------------------------------
Function RegExpTest(Patrn, TestStr)
    Dim RegExp
    SET RegExp = New RegExp
    
    RegExp.Pattern = Patrn  ' 패턴
    RegExp.IgnoreCase = True ' 대소문자 구별안함
    RegExpTest = RegExp.Test(TestStr)
    SET RegExp = Nothing
End Function



' ------------------------------------------------------------------------------
' 초간단 이메일 주소 체크(개 허접)
' ------------------------------------------------------------------------------
Function isEmailChar(strEmail)
    Dim isEmail : isEmail = false
    if instr(strEmail,"@") = 0 OR instr(strEmail,".") = 0 OR Len(strEmail) < 7 Then
        isEmail = false
    else
        isEmail = true
    end if
    isEmailChar = isEmail
End Function


' ------------------------------------------------------------------------------
'이메일 체크함수
' ------------------------------------------------------------------------------
Function isEmail(str)
    Dim ereg : ereg = false
    Dim ptrnStr
    ptrnStr = "^([a-z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-z0-9_\-]+\.)+))([a-z]{2,4}|[0-9]{1,3})(\]?)$"
    
    Dim eregEx, retVal               ' 정규표현식 변수 생성
    Set eregEx = New RegExp    ' 정규표현식 생성
    eregEx.Pattern = ptrnStr           ' 패턴지정
    eregEx.IgnoreCase = False      ' 대소문자 구분함
    retVal = eregEx.Test(str)      ' 정규표현식에 의거 문자 테스트
    Set eregEx = Nothing
    
    If retVal Then
      ereg = True           ' 정규표현식에 맞는 문자인 경우
    Else
      ereg = False          ' 정규표현식에 맞지 않는 문자인 경우
    End If
    
    isEmail = ereg
End Function


' ------------------------------------------------------------------------------
' 유효아이디 체크
' ------------------------------------------------------------------------------
Function invalidID(str)
    invalidID = false
    if isEmptyStr(str) then
        exit Function
    end if
    
    Dim allowStr
    'allowStr = "abcdefghijklmnopqrstuvwxyz0123456789"
    allowStr = "0123456789_"
    
    ' 시작문자가 영문자인지 체크
'    if RegExpTest("[a-z]",Mid(str,1,1))=true then
'        invalidID = true
'    else
'        exit Function
'    end if
    
    ' 아이디 유효 체크
    for i=0 to Len(str)
        if instr(allowStr,Mid(Lcase(str),i+1,1))=0 then
            invalidID = false
        else
            invalidID = true
        end if
    next
end Function




' ------------------------------------------------------------------------------
' 폼 전송 값 출력, call requestFormValue
' 2007.01.25
' ------------------------------------------------------------------------------
Function requestFormValue ()
    On Error Resume Next
    Dim requestValue, tmpKey, i
    requestValue = split(request.form,"&")
    response.write "<table border=""0"" cellpadding=""5"" cellspacing=""1"" bgcolor=""#CCCCCC"">" & vbcrLf &_
                   "  <tr bgColor=""#EFEFEF"" style=""font-size:9pt;"">" & vbcrLf &_
                   "    <td width=""20""><b>no.</b></td>" & vbcrLf &_
                   "    <td width=""100""><b>Key Name</b></td>" & vbcrLf &_
                   "    <td width=""20""><b>Len</b></td>" & vbcrLf &_
                   "    <td width=""350""><b>Key Value</b></td>" & vbcrLf &_
                   "    <td><b>URLEncode</b></td>" & vbcrLf
    for i=0 to uBound(requestValue)
        tmpKey = split(requestValue(i),"=")
        response.write "  <tr bgcolor=""#FFFFFF"" style=""font-size:9pt;"">" & vbcrLf &_
                       "    <td>" & i+1 & "</td>" & vbcrLf &_
                       "    <td>" & tmpKey(0) & "&nbsp;</td>" & vbcrLf &_
                       "    <td align=""right"" style=""color:#0000FF;"">" & len(mid(requestValue(i),inStr(requestValue(i),"=")+1)) & "</td>" & vbcrLf &_
                       "    <td style=""word-break:break-all;"">" & URLDecode(tmpKey(1)) & "&nbsp;</td>" & vbcrLf &_
                       "    <td style=""word-break:break-all;"">" & tmpKey(1) & "&nbsp;</td>" & vbcrLf &_
                       "  </tr>" & vbcrLf
        if ((i+1) mod 5) = 0 then
            response.write "  <tr bgcolor=""#CCCCCC""><td height=""1"" colspan=""5""></td></tr>" & vbcrLf
        end if
    next
    response.write "</table>"
End Function



' ------------------------------------------------------------------------------
' Server.URLDecode
' Encoding 된 문자열 강제 치환.
' ------------------------------------------------------------------------------
Function URLDecode(Expression)
    'Expression = Escape(Expression)
    Dim strSource, strTemp, strResult, strchr
    Dim lngPos, AddNum, IFKor
    strSource = Replace(Expression, "+", " ")
    For lngPos = 1 To Len(strSource)
        AddNum = 2
        strTemp = Mid(strSource, lngPos, 1)
        If strTemp = "%" Then
            If lngPos + AddNum < Len(strSource) + 1 Then
                strchr = CInt("&H" & Mid(strSource, lngPos + 1, AddNum))
                If strchr > 130 Then 
                    AddNum = 5
                    IFKor = Mid(strSource, lngPos + 1, AddNum)
                    IFKor = Replace(IFKor, "%", "")
                    strchr = CInt("&H" & IFKor )
                    'strchr = "&H" & IFKor
                End If
                strResult = strResult & Chr(strchr)
                'strResult = strResult & strchr
                lngPos = lngPos + AddNum
            End If
        Else
            strResult = strResult & strTemp
        End If
    Next     
    URLDecode = strResult
End Function





' ==============================================================================
' ------------------------------------------------------------------------------
' 로그인 체크 및 로그인 유효성 검사
' 로그인이 필요한 페이지 상단에 call loginCheck() 으로 호출
' 2007. 02. 22
' ------------------------------------------------------------------------------
Sub LoginCheck()
    call LoginKeep() ' 로그인 유지 함수
    
    Dim getUserID, getUserEM, getUserLV, getUserHR, getUserGR, getUserPT, getUserIF
    getUserID = base64Decode(request.Cookies("userID"))  ' 고유코드(s_code)
    getUserEM = base64Decode(request.Cookies("userEM"))  '  이메일
    getUserLV = base64Decode(request.Cookies("userLV"))  ' 레벨(1)
    getUserHR = base64Decode(request.Cookies("userHR"))  ' 접속시간
		getUserGR = base64Decode(request.Cookies("userGR"))  ' 접속시간
    
    getUserPT = base64Decode(request.Cookies("userPT"))
    getUserIF = base64Decode(request.Cookies("userIF"))
		 
    
    if isEmptyStr(getUserID) or isEmptyStr(getUserEM) or isEmptyStr(getUserLV) or isEmptyStr(getUserHR) then
        ' 쿠키값이 없는 경우 로그인 페이지로 이동
        response.clear()
        response.redirect "/signup/login.asp?pLn="&request("pLn")&"&reUrl=" & Server.UrlEncode(getUrl)
        response.end
    elseif not invalidID(getUserID) then  ' 유효한 아이디가 아닌경우 강제 로그아웃
        response.clear()
        response.redirect "/signup/login_process.asp?logOption=LogOut"
        response.end
    else
        if getUserIF="N" then
            response.redirect "/mypage/mypage_info_modify.asp?firstChk=Y&pLn="&request("pLn")&"&reUrl=" & Server.UrlEncode(getUrl)
            response.end        
        end if
    end if
End Sub




Sub LoginCheck_KR()
    call LoginKeep() ' 로그인 유지 함수
    
    Dim getUserID, getUserEM, getUserLV, getUserHR, getUserGR, getUserPT, getUserIF
    getUserID = base64Decode(request.Cookies("userID"))  ' 고유코드(s_code)
    getUserEM = base64Decode(request.Cookies("userEM"))  '  이메일
    getUserLV = base64Decode(request.Cookies("userLV"))  ' 레벨(1)
    getUserHR = base64Decode(request.Cookies("userHR"))  ' 접속시간
		getUserGR = base64Decode(request.Cookies("userGR"))  ' 접속시간
    
    getUserPT = base64Decode(request.Cookies("userPT"))
    getUserIF = base64Decode(request.Cookies("userIF"))
		
    
    if isEmptyStr(getUserID) or isEmptyStr(getUserEM) or isEmptyStr(getUserLV) or isEmptyStr(getUserHR) then
        ' 쿠키값이 없는 경우 로그인 페이지로 이동
        response.clear()
        response.redirect "/signup/kr_login.asp?reUrl=" & Server.UrlEncode(getUrl)
        response.end
    end if
    if not invalidID(getUserID) then  ' 유효한 아이디가 아닌경우 강제 로그아웃
        response.clear()
        response.redirect "/signup/login_process.asp?logOption=LogOut"
        response.end
    end if
End Sub



Sub goLogin(goUrl)
    Dim loginPage
    loginPage = "/signup/login.asp?reUrl=" & Server.UrlEncode(goUrl)
    response.redirect loginPage
    response.end
End Sub


Function loginTrue() ' 로그인 유무만 판단
    Dim getUserID
    getUserID = base64Decode(request.Cookies("userID"))
    loginTrue = false
    if invalidID(getUserID) then
        loginTrue = true
    end if
End Function


Public Function isTestAdmin()   ' 개발자 PC에서만 실행할때
    isTestAdmin = False
    
    Dim developerArr, userip
    developerArr = Array("218.51.113.134", "118.128.115.33")
    userip = request.ServerVariables("REMOTE_HOST")
    
    if inArray(developerArr,userip) then
        isTestAdmin = True
    end if
End Function


Public Function isAbsAdmin()   ' 학술 관리자만 접근 가능
    isAbsAdmin = False
    
    Dim developerArr, userip
    developerArr = Array("125.7.205.176","125.7.205.158","125.7.205.172","125.7.205.136","125.7.205.134")
    userip = request.ServerVariables("REMOTE_HOST")
    
    if inArray(developerArr,userip)  then
        isAbsAdmin = True
    end if
End Function


Public Function isRegAdmin()   ' 등록 관리자만 접근 가능
    isRegAdmin = False
    
    Dim allowArr, userip
    allowArr = Array("125.7.205.169", "125.7.205.136")
    userip = request.ServerVariables("REMOTE_HOST")
    
    if inArray(allowArr,userip)  then
        isRegAdmin = True
    end if
End Function


Public Function isTourAdmin()   ' 투어 관리자만 접근 가능
    isTourAdmin = False
    
    Dim developerArr, userip
    developerArr = Array("125.7.205.166", "125.7.205.167")
    userip = request.ServerVariables("REMOTE_HOST")
    
    if inArray(developerArr,userip) then
        isTourAdmin = True
    end if
End Function


Public Function isMeciAdmin()   ' 회사내 관리자만 접근 가능
    isMeciAdmin = False
    
    Dim developerArr, userip
    developerArr = Array("125.7.205.136", "125.7.205.139", "125.7.205.140", "125.7.205.145", "125.7.205.147", "125.7.205.164", "125.7.205.165", "125.7.205.135", "125.7.205.171")
    userip = request.ServerVariables("REMOTE_HOST")
    
    if inArray(developerArr,userip) or isTestAdmin() or isAbsAdmin() or isRegAdmin() then
        isMeciAdmin = True
    end if
End Function




' 로그인 유지 / 삭제 ===========================================================
' 저장된 로그인 시간을 비교하여 쿠키 유지 시간을 늘려줌
' ------------------------------------------------------------------------------

' 강제 로그아웃 설정 -----------------------------------------------------------
Sub LogOutCompulsion()
    response.Cookies("userID") = ""
    response.Cookies("userLV") = ""
    response.Cookies("userHR") = ""
		response.Cookies("userGR") = ""
		
    response.Cookies("userID").Expires = Date - 1000
    response.Cookies("userLV").Expires = Date - 1000
    response.Cookies("userHR").Expires = Date - 1000
    response.Cookies("userGR").Expires = Date - 1000
		
End Sub
' ------------------------------------------------------------------------------



' 로그인 유지 설정 -------------------------------------------------------------
Sub LoginKeep()
    Dim userID, userEM, userLV, userNM,userGR, userLoginTime  ' 로그인 정보
    userID = base64Decode(request.Cookies("userID"))  ' 아이디
    userEM = base64Decode(request.Cookies("userEM"))
    userLV = base64Decode(request.Cookies("userLV"))  ' 레벨
    userNM = base64Decode(request.Cookies("userNM"))
		userGR = base64Decode(request.Cookies("userGR"))
    userLoginTime = base64Decode(request.Cookies("userHR"))   ' 로그인 시간
    
    Const LoginKeepTime = 60  ' 로그인 유지 시간
    
    if isNumeric(userLoginTime) and Len(userLoginTime)=12 then
        Dim YYMMDD, HHIISS, getUserLoginTime
        YYMMDD = Cdate (Left(userLoginTime,4)&"-"&Mid(userLoginTime,5,2)&"-"&Mid(userLoginTime,7,2))
        HHIISS = Cdate (Mid(userLoginTime,9,2)&":"&Mid(userLoginTime,11,2))
        getUserLoginTime = YYMMDD + HHIISS
        
        if not isEmptyStr(getUserLoginTime) and isDate(getUserLoginTime) then
            if LoginKeepTime >= DateDiff("n",getUserLoginTime,now) then
                if not isEmptyStr(userID) and not isEmptyStr(userEM) and isEmailChar(userEM) and not isEmptyStr(userLV) and isNumeric(userLV) then
                    ' 아이디/이메일/레벨/로그인시간 등이 모두 유효할때만 로그인 유지, 이외는 강제 로그아웃
                    'response.Cookies("userHR") = base64Encode(now())
                    response.Cookies("userHR") = base64Encode(Year(now) & Calc(Month(now),2) & Calc(Day(now),2) & Calc(Hour(now),2) & Calc(Minute(now),2))
                else
                    Call logOutCompulsion()
                end if
            else
                call logOutCompulsion()
            end if
        else
            call logOutCompulsion()
        end if
    else
        call logOutCompulsion()
    end if
End Sub
' ------------------------------------------------------------------------------


' ------------------------------------------------------------------------------
' 관리자 로그인 체크
'Sub isAdminChk(varLvName)
'    Dim userID, userLV  ' 로그인 정보
'    userID = base64Decode(request.Cookies("userID"))  ' 아이디
'    userLV = base64Decode(request.Cookies("userLV"))  ' 레벨
'
'    ' 저장된 레벨쿠키가 숫자형인 경우 정수 변환 (default: 0) -------------------
'    if isNumeric(userLV)=true then
'        userLV = Cint(userLV)
'    else
'        userLV = 0
'    end if
'    ' --------------------------------------------------------------------------
'    
'    ' 사용자별 레벨 설정 -------------------------------------------------------
'    Dim LvDefaultAr, LvChairAr, LvEventAr, LvMeciAr, LvAdminAr
'    LvDefaultAr = Array(0,1,2,3,4,5,10)  ' 전체 사용자
'    LvChairAr   = Array(3,4,5,10) ' 심사용 사용자
'    LvEventAr   = Array(4,5,10) ' 행사 담당자용
'    LvMeciAr    = Array(5,10)  ' 행사 관리자
'    LvAdminAr   = Array(10)  ' 통합 관리자
'    ' --------------------------------------------------------------------------
'    
'    ' 권한 레벨을 배열에 저장 --------------------------------------------------
'    Dim objDic
'    set objDic = CreateObject("Scripting.Dictionary")
'    objDic.Add "default", LvDefaultAr
'    objDic.Add "chair", LvChairAr
'    objDic.Add "event", LvEventAr
'    objDic.Add "meci", LvMeciAr
'    objDic.Add "admin", LvAdminAr
'    ' --------------------------------------------------------------------------
'    
'    ' Key 검사 -----------------------------------------------------------------
'    if not objDic.Exists(varLvName) then
'        set ObjDic = Nothing
'        response.clear
'        response.write "<span style=""font-size:12pt; line-height:25px;""><center>"&_
'                       "주어진 키가 존재하지 않습니다.</center></span>"
'        response.end
'    end if
'    ' --------------------------------------------------------------------------
'    
'    ' Login 권한 체크 ----------------------------------------------------------
'    if not isEmptyStr(userID) and not isEmptyStr(userLV) then
'        if not inArray(objDic(varLvName),userLV) then
'            set ObjDic = Nothing
'            response.clear
'            response.write "<span style=""font-size:12pt; line-height:25px;""><center>권한이 없습니다.<br>" &_
'                           "<a href=""javascript:history.back();""><font color=""#0066cc"">[back]</font></a></center></span>"
'            response.end
'        end if
'    elseif isEmptyStr(userID) then
'        set ObjDic = Nothing
'        call goAdminLogin()
'    elseif isEmptyStr(userLV) then
'        set ObjDic = Nothing
'        call goAdminLogin()
'    end if
'    ' --------------------------------------------------------------------------
'    
'    ' dictionary 개체 비움 -----------------------------------------------------
'    set ObjDic = Nothing
'    ' --------------------------------------------------------------------------
'
'End Sub
' ==============================================================================



' ------------------------------------------------------------------------------
' SSL 보안 페이지로 URL 변경 (2007. 07. 03)
' ------------------------------------------------------------------------------
Function setSslPage()
    if request.ServerVariables("HTTPS")<>"on" then
        Dim SecurityUrl, chGetUrl
        if not isEmptyStr(getUrl) then
            chGetUrl = getUrl
            ' 소문자 변환시 암호화코드 오류발생되므로 LCase 해제(2008. 7. 16) 
            'chGetUrl = Replace(LCase(chGetUrl),"/default.asp","/")
            chGetUrl = Replace(chGetUrl,"/Default.asp","/")
            chGetUrl = Replace(chGetUrl,"/default.asp","/")
        end if
        'if LCase(chGetUrl) = "/default.asp" then chGetUrl = "/" end if
        SecurityUrl = "https://"&request.ServerVariables("HTTP_HOST") & chGetUrl
        response.clear()
        'call AlertReplace("",SecurityUrl)
        response.redirect SecurityUrl
    end if
End Function



' ------------------------------------------------------------------------------
' SSL 해지 페이지로 URL 변경 (2007. 07. 03)
' ------------------------------------------------------------------------------
Function unSetSslPage()
    if request.ServerVariables("HTTPS")<>"off" then
        Dim inSecurityUrl, chGetUrl
        if not isEmptyStr(getUrl) then
            chGetUrl = getUrl
            ' 소문자 변환시 암호화코드 오류발생되므로 LCase 해제(2008. 7. 16) 
            'chGetUrl = Replace(LCase(chGetUrl),"/default.asp","/")
            chGetUrl = Replace(chGetUrl,"/default.asp","/")
        end if
        'if LCase(chGetUrl) = "/default.asp" then chGetUrl = "/" end if
        inSecurityUrl = "http://"&request.ServerVariables("SERVER_NAME") & chGetUrl
        response.clear()
        response.redirect inSecurityUrl
    end if
End Function




' ------------------------------------------------------------------------------
' 메일캐리어를 통한 메일 발송
' call senderMailCarrier(fromEmail, "harrykim@meci.co.kr","test메일",MailBody)
' 2007.07.25
' ver 1.0
' ------------------------------------------------------------------------------
Function senderMailCarrier(fromEmail, toEmail, subject, contents)
    Dim User, SessionID
    Set User = Server.CreateObject("MCWEB.MailUser")
    If User.Login("senderonly@meci.kr", "meci2318harry") Then
        Session("WEBUSER") = User.SessionID
    End If
    SessionID = Session("WEBUSER")
    
    User.Close
    SEt User = nothing
    
    Dim Recipients
    Set Recipients = Server.CreateObject("MCWEB.Recipients")
    Recipients.Add toEmail
    
    Dim NewMessage
    Set NewMessage = Server.CreateObject("MCWEB.NewMessage")
    NewMessage.Charset = "euc-kr"
    NewMessage.FromName = "IFHNOS 2010 Seoul Secretariat"
    NewMessage.FromAddr = fromEmail
    NewMessage.To = Recipients
    NewMessage.Subject = subject
    NewMessage.BodyFormat = 1	'HTML
    NewMessage.Body = contents
   
    senderMailCarrier = NewMessage.Send(SessionID)
    
    Set Recipients = Nothing
    Set NewMessage = Nothing
End Function


Function sendMailFree(M_FROMName, M_FROM, M_TO, M_SUBJECT, M_MAILBODY, M_FORMAT)
 
      Dim objMessage, objConfig, objField
    
    SET objMessage = Server.CreateObject("CDO.Message")
    SET objConfig = Server.CreateObject("CDO.Configuration")
 
    SET objField = objConfig.Fields
    
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "222.239.254.82"
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
    Else
        objMessage.TextBody = M_MAILBODY   ' TXT : objMessage.TextBody , HTML : objMessage.HTMLBody
    End If
    'objMessage.AddAttachment      "file://d:\Webhost\OnPcs\TPM2006\Instructions for Review System.pdf"
    objMessage.fields.update
    
    objMessage.Send
    
    set objField = Nothing
    set objMessage = nothing
    set objConfig  = nothing
    
    sendMailFree = True
End Function


' Ver 1.1 (2007.12.27)
' Ver 1.1 (2007.12.27)
Function sendMailFree_old(fromName, fromEmail, toEmail, subject, contents, format)
    Dim User, SessionID
    Set User = Server.CreateObject("MCWEB.MailUser")
    If User.Login("senderonly@meci.kr", "meci2318harry") Then
        Session("WEBUSER") = User.SessionID
    End If
    SessionID = Session("WEBUSER")
    
    User.Close
    SEt User = nothing
    
    Dim Recipients
    Set Recipients = Server.CreateObject("MCWEB.Recipients")
    Recipients.Add toEmail
    
    Dim NewMessage
    Set NewMessage = Server.CreateObject("MCWEB.NewMessage")
    NewMessage.Charset = "euc-kr"
    NewMessage.FromName = fromName
    NewMessage.FromAddr = fromEmail
    NewMessage.To = Recipients
    NewMessage.Subject = subject
    NewMessage.BodyFormat = format	'1: HTML, 0:Text
    NewMessage.Body = contents
   
    sendMailFree_old = NewMessage.Send(SessionID)
    
    Set Recipients = Nothing
    Set NewMessage = Nothing
End Function


Function GoogleSendMail(strFrom, strTo, strSubject, strBody)
        On Error Resume Next
        Dim iMsg,iConf,Flds,schema,SendEmailGmail
				
        Set iMsg = CreateObject("CDO.Message")
        Set iConf = CreateObject("CDO.Configuration")
        Set Flds = iConf.Fields

        schema = "http://schemas.microsoft.com/cdo/configuration/"

        Flds.Item(schema & "sendusing") = 2
        Flds.Item(schema & "smtpaccountname") = strFrom
        Flds.Item(schema & "sendemailaddress") = strFrom&"<noreply@icaap10.org>"
        Flds.Item(schema & "smtpuserreplyemailaddress") = strFrom&"<noreply@icaap10.org>"
        Flds.Item(schema & "smtpserver") = "smtp.gmail.com" 
        Flds.Item(schema & "smtpserverport") = 465
        Flds.Item(schema & "smtpauthenticate") = 1
        Flds.Item(schema & "sendusername") = "noreply@icaap10.org"
        Flds.Item(schema & "sendpassword") = "icaap2011"
        Flds.Item(schema & "smtpusessl") = 1
        Flds.Update

        Set Flds = Nothing

        Set iMsg =  Server.CreateObject("CDO.Message")
    
        With iMsg
          .Configuration = iConf
          .To       = strTo
          .Subject  = strSubject
          .HTMLBody = strBody
          SendEmailGmail = .Send
        End With
    
        set iMsg = nothing
        set iConf = nothing
        set Flds = nothing
        If Err.number <> 0 Then
          GoogleSendMail = Err.Description
        Else
          GoogleSendMail = 0
        End If
End Function

		

Function sendMailFree_bak(M_FROMNAME, M_FROM, M_TO, M_SUBJECT, M_MAILBODY,   M_FORMAT)
	  
		Dim objMessage, objConfig, objField
	
    SET objMessage = Server.CreateObject("CDO.Message")
    SET objConfig = Server.CreateObject("CDO.Configuration")

		
    SET objField = objConfig.Fields
    
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com"
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "admin@icaap10.org"
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "icaap2011"
    objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465  '25
		objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
		objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
   
     
    objField.update
    
    Set objMessage.Configuration = objConfig

    objMessage.Subject  = M_SUBJECT
    objMessage.From     = """" & M_FROMNAME & """" & "<" & M_FROM & ">"
    objMessage.To       = M_TO
    
    If M_FORMAT=1 then
        objMessage.HTMLBody = M_MAILBODY   ' TXT : objMessage.TextBody , HTML : objMessage.HTMLBody
    Else
        objMessage.TextBody = M_MAILBODY   ' TXT : objMessage.TextBody , HTML : objMessage.HTMLBody
    End If
   
		 
    'objMessage.AddAttachment      "file://d:\Webhost\OnPcs\TPM2006\Instructions for Review System.pdf"
    objMessage.fields.update
		    
    objMessage.Send
		
    set objField = Nothing
    set objMessage = nothing
    set objConfig  = nothing		
    
		sendMailFree_bak = true
End Function




' Ver 1.1 (2007.12.27)
Function sendMailUtf(fromName, fromEmail, toEmail, subject, contents, format)
    Dim User, SessionID
    Set User = Server.CreateObject("MCWEB.MailUser")
    If User.Login("senderonly@meci.kr", "meci2318harry") Then
        Session("WEBUSER") = User.SessionID
    End If
    SessionID = Session("WEBUSER")
    
    User.Close
    SEt User = nothing
    
    Dim Recipients
    Set Recipients = Server.CreateObject("MCWEB.Recipients")
    Recipients.Add toEmail
    
    Dim NewMessage
    Set NewMessage = Server.CreateObject("MCWEB.NewMessage")
    NewMessage.Charset = "utf-8"
    NewMessage.FromName = fromName
    NewMessage.FromAddr = fromEmail
    NewMessage.To = Recipients
    NewMessage.Subject = subject
    NewMessage.BodyFormat = format	'1: HTML, 0:Text
    NewMessage.Body = contents
   
    sendMailUtf = NewMessage.Send(SessionID)
    
    Set Recipients = Nothing
    Set NewMessage = Nothing
End Function


Sub sendMailCdo(M_TO, M_SUBJECT, M_MAILBODY, M_FROM)
	  Dim objMessage, objConfig, objField
	
    SET objMessage = Server.CreateObject("CDO.Message")
    SET objConfig = Server.CreateObject("CDO.Configuration")

    SET objField = objConfig.Fields
    
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "mail.icsv15.org"
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "sender"'kaetogis
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "sendermeci"'tkdcl1010010
    objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
		objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 30
		objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
    
    objField.update
    
    Set objMessage.Configuration = objConfig

    objMessage.Subject  = M_SUBJECT
    objMessage.From     = M_FROM
    objMessage.To       = M_TO
    objMessage.HTMLBody = M_MAILBODY   ' TXT : objMessage.TextBody , HTML : objMessage.HTMLBody
    'objMessage.AddAttachment      "file://d:\Webhost\OnPcs\TPM2006\Instructions for Review System.pdf"
    objMessage.fields.update
    
    objMessage.Send
    
    set objField = Nothing
    set objMessage = nothing
    set objConfig  = nothing
End Sub


function joinTxt(rVal,str)
		if not isEmptyStr(str) then
		    if not isEmptyStr(rVal) then
    		    rVal=rVal&", "&str
    		else
            rVal=str
    		end if
		end if
		joinTxt=rVal
end function






Function sendMailFreeUTF(M_FROMName, M_FROM, M_TO, M_SUBJECT, M_MAILBODY, M_FORMAT)
    'if not isTestAdmin() then
    'on Error Resume Next
    'end if
	  Dim objMessage, objConfig, objField
	
    SET objMessage = Server.CreateObject("CDO.Message")
    SET objConfig = Server.CreateObject("CDO.Configuration")

    SET objField = objConfig.Fields
    
    objField.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    objField.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "webmail.meci.kr"
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
'    if Err.number=0 then
'        sendMailFreeUTF = True
'    else
'        sendMailFreeUTF = False
'    end if
    
    set objField = Nothing
    set objMessage = nothing
    set objConfig  = nothing
    
    
    sendMailFreeUTF = True
    
End Function




' ------------------------------------------------------------------------------
' 2011. 3. 9
' 파일 읽기
' ADODB.Stream
' UTF-8을 지원하지 않는 FileSystemObject를 대체함.
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



function DeadLine(str)  ' str : 2015-02-27 23:59:59
    Dim returnVal
    returnVal=false
		if datediff("n",str,now)<=0 then  ' 에약시간 전이면 true
	     returnVal=true
	  end if
	  DeadLine= returnVal
end function


function 	call_Function(msg,fun)
    Dim jsTxt
    jsTxt  = "<script language='javascript' type='text/javascript'>" & vbcr &_
		         "<!--" & vbcr 
		
		if not isEmptyStr(msg) then
		    msg = Replace(msg,"'","\'")
		    jsTxt = jsTxt&"  alert('"&msg&"');"& vbcr 
		end if
		
		
		jsTxt = jsTxt&fun& vbcr				
		
		jsTxt =jsTxt&"//-->"& vbcr &_
           "</script>"

		response.write   jsTxt
		response.end
		
end function 
%>
