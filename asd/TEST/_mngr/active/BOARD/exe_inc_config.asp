<%

Dim sch_field,sch_value
sch_field           = inSql(trim(request("sch_field")))
sch_value					  = inSql(trim(request("sch_value")))

if isEmptyStr(sch_value) then sch_field="" 

Dim searchLinkString,searchAttachStr,searchLinkJoinStr,searchString
if not isEmptyStr(sch_field) and not isEmptyStr(sch_value) then
    searchLinkString = searchLinkString&"&sch_field="&server.URLEncode(sch_field)&"&sch_value="&server.URLEncode(sch_value)

    if sch_field="A" then
		     searchString = searchString & " and title like '%"&sch_value&"%'" 
		else
		     searchString = searchString & " and content like '%"&sch_value&"%'"		
		end if   
end if
		





Dim basicSql,orderTxt

basicSql = "select idx,boardCate,title,content,view_date,file_or,file_sv,link_txt,b_hit,b_langCheck,file_or_list,file_sv_list from TB_board where boardCate='"&boardCate&"'"


if sMenu="00" then
		basicSql = basicSql&" and  b_actStatus='Y' "
elseif  sMenu="01" then
    basicSql = basicSql&"  and  b_actStatus='N' "
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