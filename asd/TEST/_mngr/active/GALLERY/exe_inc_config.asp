<%

Dim schCate,sch_value

sch_value           = inSqlInjection(request("sch_value"))

ReDim abssearchKeyAr(0)  ' �˻�� �迭�� ����

abssearchKeyAr(0) = sch_value       


Dim searchLinkString,searchAttachStr,searchLinkJoinStr,searchString

For i=0 to  Ubound(abssearchKeyAr)
    
    If not isEmptyStr(abssearchKeyAr(i)) Then
        searchAttachStr = " and "    ' �˻�� ���� ��� �������� and �߰�
        searchLinkJoinStr = "&"    ' �˻�� ���� ��� ��������ũ�� ���Ṯ�� �߰�
        
        Select Case i
            Case 0 :  searchString = searchString & searchAttachStr & "subject like '%"&abssearchKeyAr(i)&"%'" 
                     searchLinkString = searchLinkString & searchLinkJoinStr & "sch_value="&server.URLEncode(sch_value)&""
        End Select
    Else
        searchAttachStr = ""     ' ���Ṯ�� Reset
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
Dim listLoop ' ���� ������������ ������ ��� ��
Dim idxTmpNum  ' �Խù� ��� ��ȣ
Dim colspanCount
Dim fori
Dim trbg
Dim strErrMsg
Dim rsPageCount
%>