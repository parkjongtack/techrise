<%

Dim schCate

schCate           = inSqlInjection(request("schCate"))

ReDim abssearchKeyAr(0)  ' �˻�� �迭�� ����

abssearchKeyAr(0) = schCate          


Dim searchLinkString,searchAttachStr,searchLinkJoinStr,searchString

For i=0 to  Ubound(abssearchKeyAr)
    
    If not isEmptyStr(abssearchKeyAr(i)) Then
        searchAttachStr = " and "    ' �˻�� ���� ��� �������� and �߰�
        searchLinkJoinStr = "&"    ' �˻�� ���� ��� ��������ũ�� ���Ṯ�� �߰�
        
        Select Case i
            Case 0 : searchString = searchString & searchAttachStr & "cate = '"&abssearchKeyAr(i)&"'" 
                     searchLinkString = searchLinkString & searchLinkJoinStr & "schCate="&server.URLEncode(schCate)&""
        End Select
    Else
        searchAttachStr = ""     ' ���Ṯ�� Reset
        searchLinkJoinStr = ""
    End If
Next	




Dim basicSql,orderTxt

basicSql = "select idx, subject,subjectKr,fileName, fileSize, fileWidth, fileHeight, thumbNail, hit, download, cate, regDate from AAC_gallery where "


       
    if sMenu="00" then
				basicSql = basicSql&" actResult=0 and cate>="&s_1st&" and cate<="&e_1st
    		orderTxt = " order by  idx desc "
    elseif  sMenu="01" then
        basicSql = basicSql&" actResult=0 and cate>="&s_2nd&" and cate<="&e_2nd
    		orderTxt = " order by  idx desc "
    end if
		       
        
basicSql = basicSql & searchString&orderTxt

Dim htmlSignUpList

Dim rsCount
Dim listLoop ' ���� ������������ ������ ��� ��
Dim idxTmpNum  ' �Խù� ��� ��ȣ
Dim colspanCount
Dim fori
Dim trbg
Dim strErrMsg
Dim rsPageCount
%>