<%
Dim titleTxt	: titleTxt		   = "Try Everything MANAGER"   


Const LoginKeepTime    = 60  ' �α��� ��ȿ�ð�(��)



Dim downloadQry


Dim menuIdx
menuIdx=cint(request("menuIdx"))

Dim sMenu 
sMenu = returnSubMenu(request("sMenu"))

Dim bMenu,mCate
bMenu = request("bMenu")
mCate  = request("mCate")

if isEmptyStr(bMenu) then bMenu=0
if isEmptyStr(mCate) then mCate=0

if not isNumeric(bMenu) then bMenu=0
if not isNumeric(mCate) then mCate=0



    

    
reDim menuAr_Info(0)  
menuAr_Info(0)  = "Media|0|4|"



reDim menuAr_Info_sub(4)  
menuAr_Info_sub(0)  = "공지 사항"
menuAr_Info_sub(1)  = "행사 뉴스 레터"
menuAr_Info_sub(2)  = "관련 보도"
menuAr_Info_sub(3)  = "행사 영상"
menuAr_Info_sub(4)  = "행사 사진"


Sub includeMainExeFile()
    Dim exeFileName
    select case menuIdx
        case "0" : exeFileName = "exe_NEWS.asp"
				case "1" : exeFileName = "exe_LETTER.asp"
				case "2" : exeFileName = "exe_MEDIA.asp"
				case "3" : exeFileName = "exe_VIDEO.asp"
				case "4" : exeFileName = "exe_PHOTO.asp"				
        case else : response.write "error" : response.end
    end select
    'response.write  exeFileName
    server.execute(exeFileName)
End Sub





function returnSubMenu(subStr)
    Dim maxSubidx 
    'select case menuIdx
'        case "0" : maxSubidx = 3
'				case "1" : maxSubidx = 3
'    end select
		
		maxSubidx =2
    
    Dim rVal
    rVal = subStr 
    if not isNumeric(subStr) or isEmptyStr(subStr) then
        rVal="00"
    elseif cint(subStr)<0 or cint(subStr)>maxSubidx  then
        rVal="00"
    end if
    returnSubMenu=rVal
    
end function





Dim adLevel:adLevel=base64Decode(request.Cookies("AD_userLV"))









' ������ ��ȣ ���� *************************************************************



Sub gotoPageHTML(pageNo, listBlock,rsPageCount, parameterTxt)

    Dim htmlPageNumbering
    Dim startNum
    if pageNo<=listBlock then
        startNum = 1
    else
        startNum = (getRound(pageNo / listBlock) * listBlock) - listBlock + 1
    end if

    Dim imgBtnFst, imgBtnPrv, imgBtnNxt, imgBtnEnd  ' �̹��� ��ư Ȱ��ȭ ���� ��Ÿ��


    
    if pageNo<=1 then
        imgBtnFst = "<img src=""/_mngr/_img/btn_prev_1.gif"" width=""18"" height=""18"" border=""0"" style=""filter:gray();"">"
        imgBtnPrv = "<img src=""/_mngr/_img/btn_prev.gif"" width=""38"" height=""18"" border=""0"" style=""filter:gray();"">"
    else
        imgBtnFst = "<a href=""?"&parameterTxt&"&pageNo=1""><img src=""/_mngr/_img/btn_prev_1.gif"" width=""18"" height=""18"" border=""0""></a>"
        imgBtnPrv = "<a href=""?"&parameterTxt&"&pageNo="&pageNo-1&"""><img src=""/_mngr/_img/btn_prev.gif"" width=""38"" height=""18"" border=""0""></a>"
    end if

    if pageNo>=rsPageCount then
        imgBtnNxt = "<img src=""/_mngr/_img/btn_next.gif"" width=""38"" height=""18"" border=""0"" style=""filter:gray();"">"
        imgBtnEnd = "<img src=""/_mngr/_img/btn_next_1.gif"" width=""18"" height=""18"" border=""0"" style=""filter:gray();"">"
    else
        imgBtnNxt = "<a href=""?"&parameterTxt&"&pageNo="&pageNo+1&"""><img src=""/_mngr/_img/btn_next.gif"" width=""38"" height=""18"" border=""0""></a>"
        imgBtnEnd = "<a href=""?"&parameterTxt&"&pageNo="&rsPageCount&"""><img src=""/_mngr/_img/btn_next_1.gif"" width=""18"" height=""18"" border=""0""></a>"
    end if

    htmlPageNumbering =  "<td style=""padding-top:6;"">"&imgBtnFst&"</td>" &_
                    "<td width=""10""></td>" &_
                    "<td style=""padding:0px 2px 0px 0px;"" >"&imgBtnPrv&"</td>"

    Dim tmpBlink
    if pageNo<=rsPageCount then
        for i=startNum to listBlock+startNum-1
            if i>rsPageCount then
                exit for
            end if
            
            if i<(listBlock+startNum)-1 and i<rsPageCount then
                tmpBlink = "<td style=""padding:0pc 2px 6px 2px;""> <font style=""color:#88c2de;font-size:11px;"">|</font> </td>"
            else
                tmpBlink = ""
            end if
            htmlPageNumbering = htmlPageNumbering & "<td align=""center"" width=""12"" style=""padding:0pc 2px 6px 2px;"">"
            if i=pageNo then
                htmlPageNumbering = htmlPageNumbering & "<b><font style=""color:#000000;font-size:11px;font-weight:bold;"">" & i &  "</font></b>"
            else
                htmlPageNumbering = htmlPageNumbering & "<a href=""?"&parameterTxt&"&pageNo="&i&""" class='page'>" & i & "</a>"
            end if
            htmlPageNumbering = htmlPageNumbering & "</td>"
            htmlPageNumbering = htmlPageNumbering & tmpBlink
        next
    end if

    htmlPageNumbering = htmlPageNumbering & "<td style=""padding:0px 0px 0px 4px;"" >"&imgBtnNxt&"</td>" &_
                   "<td width=""10""></td>" &_
                   "<td style=""padding-top:6;"">"&imgBtnEnd&"</td>"
    
    htmlPageNumbering = "<table border=""0"" cellpadding=""0"" cellspacing=""0"" align='center'><tr>" & htmlPageNumbering & "</tr></table>"
    
    response.write htmlPageNumbering

End Sub    
' ******************************************************************************







' error text -------------------------------------------------------------------
Dim mode
mode       = Lcase(Trim(request("mode")))

Dim strNoList, strNotFound
strNoList   = "No list" ' ��Ͽ���...
strNotFound = "Search text not found."  ' �˻� �� 
' ------------------------------------------------------------------------------













' ������ �⺻ ���� -------------------------------------------------------------
Dim listCount ' ������ �� ��� ��
Const listBlock      = 10  ' ������ ���� ��
Const searchStrColor = "red" ' �˻��� Color
Dim listViewCnt : listViewCnt = request("listViewCnt")

if not isEmptyStr(listViewCnt) and isNumeric(listViewCnt) then
    ' select menu ��ϼ� ����
    if listViewCnt<=100 then
        listCount = listViewCnt
    else
        listCount = 10
    end if
else
    listCount = 10
end if
' ------------------------------------------------------------------------------



' ���� ������ ��ȣ �� ���� ������ ��ȣ�� ���� ----------------------------------
Dim pageNo, startPage
if Request("pageNo") = "" then
	  pageNo  = 1
else
    pageNo  = Cint(Request("pageNo"))
end if

if Request("startPage") = "" then
	  startPage = 1
else
    startPage = Cint(Request("startPage"))
end if
' --------------------------------------------------------------------------









Public Sub sessionArList()
    response.write " var sessionAr = new Array();"
    for i=0 to uBound(sessionAr)
        response.write "sessionAr["&i&"] = '" & sessionAr(i) & "';"
    next
End Sub


Dim signupTable,regTable,absTable,authorTable
signupTable = "signup_List"
regTable    = "registration"
absTable    = "Abstract_List"
authorTable = "Author_List"

%>
