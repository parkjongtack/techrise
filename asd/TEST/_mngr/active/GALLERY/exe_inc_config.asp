<%

Dim schCate,sch_value

sch_value           = inSqlInjection(request("sch_value"))

ReDim abssearchKeyAr(0)  ' 검색어를 배열에 담음

abssearchKeyAr(0) = sch_value       


Dim searchLinkString,searchAttachStr,searchLinkJoinStr,searchString

For i=0 to  Ubound(abssearchKeyAr)
    
    If not isEmptyStr(abssearchKeyAr(i)) Then
        searchAttachStr = " and "    ' 검색어가 있을 경우 쿼리문에 and 추가
        searchLinkJoinStr = "&"    ' 검색어가 있을 경우 페이지링크에 연결문자 추가
        
        Select Case i
            Case 0 :  searchString = searchString & searchAttachStr & "subject like '%"&abssearchKeyAr(i)&"%'" 
                     searchLinkString = searchLinkString & searchLinkJoinStr & "sch_value="&server.URLEncode(sch_value)&""
        End Select
    Else
        searchAttachStr = ""     ' 연결문자 Reset
        searchLinkJoinStr = ""
    End If
Next	




Dim basicSql,orderTxt

basicSql = "select idx, subject,subjectKr,fileName, fileSize, fileWidth, fileHeight, thumbNail, hit, download, cate, regDate from TB_gallery where "


       
    if sMenu="00" then
				basicSql = basicSql&" actResult=0 "
    elseif  sMenu="01" then
        basicSql = basicSql&" actResult=1 "
    end if
		orderTxt = " order by view_date desc, idx desc "
        
basicSql = basicSql & searchString&orderTxt

Dim htmlSignUpList

Dim rsCount
Dim listLoop ' 현재 페이지에서의 가져올 목록 수
Dim idxTmpNum  ' 게시물 출력 번호
Dim colspanCount
Dim fori
Dim trbg
Dim strErrMsg
Dim rsPageCount
%>